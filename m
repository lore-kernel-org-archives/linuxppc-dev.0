Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C7DB67C14
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 23:05:50 +1000 (EST)
Subject: [PATCH] Editable kernel command-line in zImage binary.
In-Reply-To: <17545.17329.227226.926906@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jun 2006 09:06:12 -0400
Message-Id: <11498583723378-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org, paulus@samba.org
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

zImage will set /chosen/bootargs (if it is otherwise empty) with the
contents of a buffer in the section "__builtin_cmdline".  This permits
tools to edit zImage binaries to set the command-line eventually
processed by vmlinux.

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/boot/main.c |   27 +++++++++++++++++++++++++++
 arch/powerpc/boot/prom.h |    7 +++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

40bea6ace95796a1575437d6dfdbef671012ffc1
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 816446f..c65a7ba 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -33,6 +33,14 @@ extern char _vmlinux_end[];
 extern char _initrd_start[];
 extern char _initrd_end[];
 
+/* A buffer that may be edited by tools operating on a zImage binary so as to
+ * edit the command line passed to vmlinux (by setting /chosen/bootargs).
+ * The buffer is put in it's own section so that tools may locate it easier.
+ */
+static char builtin_cmdline[512]
+	__attribute__((section("__builtin_cmdline")));
+
+
 struct addr_range {
 	unsigned long addr;
 	unsigned long size;
@@ -204,6 +212,23 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
+void export_cmdline(void* chosen_handle)
+{
+        int len;
+        char cmdline[2] = { 0, 0 };
+
+	if (builtin_cmdline[0] == 0) 
+		return;
+
+        len = getprop(chosen_handle, "bootargs", cmdline, sizeof(cmdline));
+        if (len > 0 && cmdline[0] != 0) 
+		return;
+
+	setprop(chosen_handle, "bootargs", builtin_cmdline,
+		strlen(builtin_cmdline) + 1);
+}
+
+
 void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
 {
 	int len;
@@ -289,6 +314,8 @@ void start(unsigned long a1, unsigned lo
 		memmove((void *)vmlinux.addr,(void *)vmlinuz.addr,vmlinuz.size);
 	}
 
+	export_cmdline(chosen_handle);
+
 	/* Skip over the ELF header */
 #ifdef DEBUG
 	printf("... skipping 0x%lx bytes of ELF header\n\r",
diff --git a/arch/powerpc/boot/prom.h b/arch/powerpc/boot/prom.h
index 3e2ddd4..a57b184 100644
--- a/arch/powerpc/boot/prom.h
+++ b/arch/powerpc/boot/prom.h
@@ -31,4 +31,11 @@ static inline int getprop(void *phandle,
 	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
 }
 
+
+static inline int setprop(void *phandle, const char *name,
+			  void *buf, int buflen)
+{
+	return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
+}
+
 #endif				/* _PPC_BOOT_PROM_H_ */
-- 
1.1.4.g0b63-dirty
