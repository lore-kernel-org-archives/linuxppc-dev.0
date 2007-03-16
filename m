Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 14:46:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Don't pass the stack pointer to zImage's start() function
Message-ID: <20070316034653.GB12325@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present, the zImage entry code passes a copy of the stack pointer
to the start() function.  There's no real reason for this; the only
thing start() does with it is print it out.  It appears to be a
leftover debugging hack, so, this patch removes it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Now without a stupid error in the printf().  Please apply.

Index: working-2.6/arch/powerpc/boot/crt0.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/crt0.S	2007-03-15 16:15:51.000000000 +1100
+++ working-2.6/arch/powerpc/boot/crt0.S	2007-03-15 16:16:55.000000000 +1100
@@ -86,5 +86,4 @@ _zimage_start:
 	bl	platform_init
 
 	/* Call start */
-	mr	r3,r1
 	b	start
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-15 16:16:48.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-15 16:21:54.000000000 +1100
@@ -256,7 +256,7 @@ struct dt_ops dt_ops;
 struct console_ops console_ops;
 struct loader_info loader_info;
 
-void start(void *sp)
+void start(void)
 {
 	struct addr_range vmlinux, initrd;
 	kernel_entry_t kentry;
@@ -268,8 +268,7 @@ void start(void *sp)
 	if (platform_ops.fixups)
 		platform_ops.fixups();
 
-	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
-	       _start, sp);
+	printf("\n\rzImage starting: loaded at 0x%p\n\r", _start);
 
 	vmlinux = prep_kernel();
 	initrd = prep_initrd(vmlinux, loader_info.initrd_addr,
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-03-15 16:15:51.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-03-15 16:21:54.000000000 +1100
@@ -66,7 +66,7 @@ struct loader_info {
 };
 extern struct loader_info loader_info;
 
-void start(void *sp);
+void start(void);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
