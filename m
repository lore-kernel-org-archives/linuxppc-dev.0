Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87025DDE2E
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:08:15 +1000 (EST)
Date: Fri, 21 Sep 2007 18:08:03 -0500 (CDT)
Subject: [PATCH 14/15] boot: add a hook to start cpus
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-14.miltonm@bga.com>
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

The kexec code is doing strange contortions with dtops.finalize and
platform_ops.vmlinux_alloc to manage the slave cpus.   Add a hook
with the needed information.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
vs 12181
rediff fuzz.

Index: kernel/arch/powerpc/boot/kexec.c
===================================================================
--- kernel.orig/arch/powerpc/boot/kexec.c	2007-09-20 17:49:13.000000000 -0500
+++ kernel/arch/powerpc/boot/kexec.c	2007-09-20 17:49:19.000000000 -0500
@@ -117,32 +117,11 @@ static void init_flat_tree(struct boot_p
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
@@ -167,8 +146,7 @@ void kexec_platform_init(struct boot_par
 	init_flat_tree(dt_blob);
 
 	platform_ops.find_vmlinuz = find_vmlinux_in_initramfs;
-	platform_ops.vmlinux_alloc = kexec_vmlinux_alloc;
+	platform_ops.vmlinux_alloc = ranges_vmlinux_alloc;
 	platform_ops.fixups = kexec_fixups;
-	finalize_chain = dt_ops.finalize;
-	dt_ops.finalize = kexec_finalize;
+	platform_ops.start_smp = send_slaves_to_kernel;
 }
Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-09-20 17:49:10.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-09-20 17:49:19.000000000 -0500
@@ -202,6 +202,9 @@ void start(void)
 	else
 		printf(" using OF tree (promptr=%p)\n\r", loader_info.promptr);
 
+	if (platform_ops.start_smp)
+		platform_ops.start_smp(vmlinux.addr);
+
 	if (console_ops.close)
 		console_ops.close();
 
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-09-20 17:49:10.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-09-20 17:49:19.000000000 -0500
@@ -35,6 +35,7 @@ struct platform_ops {
 	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
 	void *	(*vmlinux_alloc)(unsigned long size);
+	void	(*start_smp)(void *vmlinux);
  	void	(*find_vmlinuz)(struct gunzip_state *, void **srcp,
  			unsigned long *lenp);
 };
