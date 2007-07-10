Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:12:52 -0500 (CDT)
Subject: [PATCH 14/15] boot: add a hook to start cpus
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-14.miltonm@bga.com>
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

The kexec code is doing strange contortions with dtops.finalize and
platform_ops.vmlinux_alloc to manage the slave cpus.   Add a hook
with the needed information.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Index: work.git/arch/powerpc/boot/kexec.c
===================================================================
--- work.git.orig/arch/powerpc/boot/kexec.c	2007-07-10 04:39:43.000000000 -0500
+++ work.git/arch/powerpc/boot/kexec.c	2007-07-10 04:40:01.000000000 -0500
@@ -180,32 +180,11 @@ static void init_flat_tree(struct boot_p
 		fatal("Unable to initialize device_tree library!\n\r");
 }
 
-static void *saved_vmlinux_addr;
-
-static void *kexec_vmlinux_alloc(unsigned long size)
-{
-	void *addr;
-
-	addr = ranges_vmlinux_alloc(size);
-
-	saved_vmlinux_addr = addr;
-	return addr;
-}
-
 static void kexec_fixups(void)
 {
 	wait_slaves_moved();
 }
 
-static unsigned long (*finalize_chain)(void);
-
-static unsigned long kexec_finalize(void)
-{
-	send_slaves_to_kernel(saved_vmlinux_addr);
-
-	return finalize_chain();
-}
-
 void kexec_platform_init(struct boot_param_header *dt_blob)
 {
 	slaves_are_low();
@@ -226,8 +205,7 @@ void kexec_platform_init(struct boot_par
 	init_flat_tree(dt_blob);
 
 	platform_ops.find_vmlinuz = find_vmlinux_in_initramfs;
-	platform_ops.vmlinux_alloc = kexec_vmlinux_alloc;
+	platform_ops.vmlinux_alloc = ranges_vmlinux_alloc;
 	platform_ops.fixups = kexec_fixups;
-	finalize_chain = dt_ops.finalize;
-	dt_ops.finalize = kexec_finalize;
+	platform_ops.start_smp = send_slaves_to_kernel;
 }
Index: work.git/arch/powerpc/boot/main.c
===================================================================
--- work.git.orig/arch/powerpc/boot/main.c	2007-07-10 04:39:43.000000000 -0500
+++ work.git/arch/powerpc/boot/main.c	2007-07-10 04:39:43.000000000 -0500
@@ -212,6 +212,9 @@ void start(void)
 	else
 		printf(" using OF tree (promptr=%p)\n\r", loader_info.promptr);
 
+	if (platform_ops.start_smp)
+		platform_ops.start_smp(vmlinux.addr);
+
 	if (console_ops.close)
 		console_ops.close();
 
Index: work.git/arch/powerpc/boot/ops.h
===================================================================
--- work.git.orig/arch/powerpc/boot/ops.h	2007-07-10 04:39:43.000000000 -0500
+++ work.git/arch/powerpc/boot/ops.h	2007-07-10 04:39:43.000000000 -0500
@@ -35,6 +35,7 @@ struct platform_ops {
 	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
 	void *	(*vmlinux_alloc)(unsigned long size);
+	void	(*start_smp)(void *vmlinux);
  	void	(*find_vmlinuz)(struct gunzip_state *, void **srcp,
  			unsigned long *lenp);
 };
