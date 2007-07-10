Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:12:36 -0500 (CDT)
Subject: [PATCH 12/15] bootwrapper: extract the vmlinux from initramfs
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-12.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Teach the kexec platform to find the vmlinux from the initramfs.

The implementation searches the initramfs for a file specified
by the boot-file property in chosen.


Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Status: working.

Index: work.git/arch/powerpc/boot/kexec.c
===================================================================
--- work.git.orig/arch/powerpc/boot/kexec.c	2007-07-10 04:01:57.000000000 -0500
+++ work.git/arch/powerpc/boot/kexec.c	2007-07-10 04:04:09.000000000 -0500
@@ -23,6 +23,8 @@
 #include "flatdevtree.h"
 #include "page.h"
 #include "types.h"
+#include "cpio.h"
+#include "stat.h"
 
 extern char _start[];
 extern char _end[];
@@ -92,6 +94,51 @@ static void find_rmo_end(void)
 	rmo_end = (void *)*rp;
 }
 
+void find_vmlinux_in_initramfs(struct gunzip_state *state,
+		void **srcp, unsigned long *lenp)
+{
+	void *devp;
+	int rc;
+	char path[MAX_PATH];
+
+	if (!loader_info.initrd_size)
+		dt_find_initrd();
+	if (!loader_info.initrd_size)
+		fatal("find_vmlinux: no initramfs");
+	devp = finddevice("/chosen");
+	if (!devp)
+		fatal("find_vmlinux: no /chosen to find vmlinux");
+	rc = getprop(devp, "boot-file", path, sizeof(path));
+	if (rc < 0)
+		fatal("find_vmlinux: no boot-file property in /chosen")
+	else if (rc == 0 || rc > MAX_PATH)
+		fatal("boot-file too long in /chosen")
+
+	rc = find_in_initramfs(path, (void *)loader_info.initrd_addr,
+			loader_info.initrd_size, state);
+	if (!rc)
+		fatal("find_vmlinux: couldn't find boot-file %s in initramfs",
+				path);
+
+	rc = get_cpio_file_mode();
+	if (!S_ISREG(rc))
+		fatal("find_vmlinux: boot-file %s is not a regular file",
+				path)
+
+	get_cpio_info(srcp, &rc);
+	*lenp = get_cpio_file_size();
+}
+
+void cpio_error(char *msg)
+{
+	void *srcp;
+	int read;
+
+	get_cpio_info(&srcp, &read);
+
+	fatal("cpio_error at %p + 0x%x(%d): %s", srcp, read, read, msg);
+}
+
 /**
  * setup_initial_heap - setup a small heap in the bss
  * Using a preallocated heap, setup for scanning the device tree.
@@ -178,6 +225,7 @@ void kexec_platform_init(struct boot_par
 	ranges_init_malloc();
 	init_flat_tree(dt_blob);
 
+	platform_ops.find_vmlinuz = find_vmlinux_in_initramfs;
 	platform_ops.vmlinux_alloc = kexec_vmlinux_alloc;
 	platform_ops.fixups = kexec_fixups;
 	finalize_chain = dt_ops.finalize;
