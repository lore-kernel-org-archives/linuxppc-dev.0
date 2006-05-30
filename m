Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E19C067A3D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 12:01:08 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4U21a2Q014747
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 22:01:36 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4U214D413818
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 22:01:04 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4U213k433138
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 22:01:03 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4U2smu4010227
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 22:54:48 -0400
Subject: [PATCH] Provide mechanism for editing builtin command-line in zImage
	binary.
In-Reply-To: 
Date: Mon, 29 May 2006 22:01:03 -0400
Message-Id: <11489544631499-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: mostrows@watson.ibm.com
Reply-To: mostrows@watson.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

zImage will store the builtin command-line in a dedicated section, allowing
it to be easily identified and edited with user-space tools.

zImage will set /chosen/bootargs to the stored builtin command-line setting,
if /chosen/bootargs is empty (emulating the behavior in prom_init.c).

Use of this mechanism avoids the need to modify firmware or rely on a
bootloader to customize kernel arguments (and overall system
behavior).  The command line can be edited as needed when a zImage is
copied to a TFTP staging area for download by firmware.

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/boot/Makefile |    3 ++-
 arch/powerpc/boot/main.c   |   28 ++++++++++++++++++++++++++++
 arch/powerpc/boot/prom.h   |    6 ++++++
 3 files changed, 36 insertions(+), 1 deletions(-)

38d6b8581e01886e352b699c978a3a5ac6672622
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 840ae59..d7ba474 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -41,7 +41,8 @@ src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 
-BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
+BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(O)/include -I$(O)/include2\
+			-D__KERNEL__
 
 quiet_cmd_copy_zlib = COPY    $@
       cmd_copy_zlib = sed "s@__attribute_used__@@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 816446f..eef25de 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -10,6 +10,9 @@
  */
 #include <stdarg.h>
 #include <stddef.h>
+#include <linux/autoconf.h>
+#include <asm/setup.h>
+
 #include "elf.h"
 #include "page.h"
 #include "string.h"
@@ -33,6 +36,16 @@ extern char _vmlinux_end[];
 extern char _initrd_start[];
 extern char _initrd_end[];
 
+#ifdef CONFIG_CMDLINE
+/* Putting this in a seperate section allows for simple tools to 
+ * edit this setting after a build (i.e. as the kernel image is being deployed
+ * for booting. 
+ */
+static char builtin_cmdline[COMMAND_LINE_SIZE]
+		__attribute__((section("__builtin_cmdline"))) = CONFIG_CMDLINE;
+#endif
+
+
 struct addr_range {
 	unsigned long addr;
 	unsigned long size;
@@ -204,6 +217,19 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
+void export_cmdline(void* chosen_handle)
+{
+#ifdef CONFIG_CMDLINE
+        int len;
+        char cmdline[COMMAND_LINE_SIZE];
+        len = getprop(chosen_handle, "bootargs", cmdline, sizeof(cmdline));
+        if ((len <= 0 || cmdline[0] == 0) && builtin_cmdline[0]) {
+                setprop(chosen_handle, "bootargs", builtin_cmdline,
+                        strlen(builtin_cmdline)+1);
+        }
+#endif /* CONFIG_CMDLINE */
+}
+
 void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
 {
 	int len;
@@ -289,6 +315,8 @@ void start(unsigned long a1, unsigned lo
 		memmove((void *)vmlinux.addr,(void *)vmlinuz.addr,vmlinuz.size);
 	}
 
+	export_cmdline(chosen_handle);
+
 	/* Skip over the ELF header */
 #ifdef DEBUG
 	printf("... skipping 0x%lx bytes of ELF header\n\r",
diff --git a/arch/powerpc/boot/prom.h b/arch/powerpc/boot/prom.h
index 3e2ddd4..f613092 100644
--- a/arch/powerpc/boot/prom.h
+++ b/arch/powerpc/boot/prom.h
@@ -31,4 +31,10 @@ static inline int getprop(void *phandle,
 	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
 }
 
+static inline int setprop(void *phandle, const char *name,
+                          void *buf, int buflen)
+{
+        return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
+}
+
 #endif				/* _PPC_BOOT_PROM_H_ */
-- 
1.1.4.g0b63-dirty
