Return-Path: <dgibson@ozlabs.org>
Date: Thu, 16 Nov 2006 15:31:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Small clarification of initrd handling
Message-ID: <20061116043132.GA10821@localhost.localdomain>
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

This patch makes the handling of the initrd (or initramfs) in the
zImage wrapper a little easier to follow.  Instead of passing the
initrd addresses out from prep_kernel() via the cryptic a1 and a2
parameters, use the global struct add_range, 'initrd'.  prep_kernel()
already passes information through the 'vmlinux' addr_range struct, so
this seems like a reasonable extension.

Some comments also clarify the logic with prep_kernel(): we use an
initrd included in the zImage if present, otherwise we use an initrd
passed in by the bootloader in the a1 and a2 parameters (yaboot, at
least, uses this mechanism to pass an initrd).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2006-11-16 14:31:45.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2006-11-16 15:23:44.000000000 +1100
@@ -169,7 +169,7 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
-static void prep_kernel(unsigned long *a1, unsigned long *a2)
+static void prep_kernel(unsigned long a1, unsigned long a2)
 {
 	int len;
 
@@ -205,11 +205,14 @@ static void prep_kernel(unsigned long *a
 	}
 
 	/*
-	 * Now we try to alloc memory for the initrd (and copy it there)
+	 * Now find the initrd
+	 *
+	 * First see if we have an image attached to us.  If so
+	 * allocate memory for it and copy it there.
 	 */
 	initrd.size = (unsigned long)(_initrd_end - _initrd_start);
 	initrd.memsize = initrd.size;
-	if ( initrd.size > 0 ) {
+	if (initrd.size > 0) {
 		printf("Allocating 0x%lx bytes for initrd ...\n\r",
 		       initrd.size);
 		initrd.addr = (unsigned long)malloc((u32)initrd.size);
@@ -218,8 +221,6 @@ static void prep_kernel(unsigned long *a
 					"ramdisk !\n\r");
 			exit();
 		}
-		*a1 = initrd.addr;
-		*a2 = initrd.size;
 		printf("initial ramdisk moving 0x%lx <- 0x%lx "
 			"(0x%lx bytes)\n\r", initrd.addr,
 			(unsigned long)_initrd_start, initrd.size);
@@ -227,6 +228,12 @@ static void prep_kernel(unsigned long *a
 			initrd.size);
 		printf("initrd head: 0x%lx\n\r",
 				*((unsigned long *)initrd.addr));
+	} else if (a2 != 0) {
+		/* Otherwise, see if yaboot or another loader gave us an initrd */
+		initrd.addr = a1;
+		initrd.memsize = initrd.size = a2;
+		printf("Using loader supplied initrd at 0x%lx (0x%lx bytes)\n\r",
+		       initrd.addr, initrd.size);
 	}
 
 	/* Eventually gunzip the kernel */
@@ -307,7 +314,7 @@ void start(unsigned long a1, unsigned lo
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
 	       _start, sp);
 
-	prep_kernel(&a1, &a2);
+	prep_kernel(a1, a2);
 
 	/* If cmdline came from zimage wrapper or if we can edit the one
 	 * in the dt, print it out and edit it, if possible.
@@ -331,7 +338,7 @@ void start(unsigned long a1, unsigned lo
 	}
 	else
 		/* XXX initrd addr/size should be passed in properties */
-		kentry(a1, a2, promptr);
+		kentry(initrd.addr, initrd.size, promptr);
 
 	/* console closed so printf below may not work */
 	printf("Error: Linux kernel returned to zImage boot wrapper!\n\r");

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
