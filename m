Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FCFADE4BB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:06:35 +1000 (EST)
Date: Fri, 21 Sep 2007 18:06:23 -0500 (CDT)
Subject: [PATCH 12/15] bootwrapper: kexec extract vmlinux from initramfs
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-12.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
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

The implementation searches the initramfs for a path specified
by the property linux,kernel-path in chosen.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
vs 12179
change property from boot-file to linux,kernel-path
context diffs

Index: kernel/arch/powerpc/boot/kexec.c
===================================================================
--- kernel.orig/arch/powerpc/boot/kexec.c	2007-09-20 17:49:08.000000000 -0500
+++ kernel/arch/powerpc/boot/kexec.c	2007-09-20 17:49:13.000000000 -0500
@@ -23,6 +23,8 @@
 #include "flatdevtree.h"
 #include "page.h"
 #include "types.h"
+#include "cpio.h"
+#include "stat.h"
 
 extern char _start[];
 extern char _end[];
@@ -41,6 +43,51 @@ static void find_console_from_tree(void)
 	}
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
+	rc = getprop(devp, "linux,kernel-path", path, sizeof(path));
+	if (rc < 0)
+		fatal("find_vmlinux: no linux,kernel-path property in /chosen")
+	else if (rc == 0 || rc > MAX_PATH)
+		fatal("linux,kernel-path too long in /chosen")
+
+	rc = find_in_initramfs(path, (void *)loader_info.initrd_addr,
+			loader_info.initrd_size, state);
+	if (!rc)
+		fatal("find_vmlinux: couldn't find linux,kernel-path %s"
+				" in initramfs", path);
+
+	rc = get_cpio_file_mode();
+	if (!S_ISREG(rc))
+		fatal("find_vmlinux: linux,kernel-path %s is not"
+				" a regular file", path)
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
@@ -119,6 +166,7 @@ void kexec_platform_init(struct boot_par
 	/* now that we have a malloc region, start over from the flat tree */
 	init_flat_tree(dt_blob);
 
+	platform_ops.find_vmlinuz = find_vmlinux_in_initramfs;
 	platform_ops.vmlinux_alloc = kexec_vmlinux_alloc;
 	platform_ops.fixups = kexec_fixups;
 	finalize_chain = dt_ops.finalize;
