Date: Thu, 1 Nov 2001 02:04:26 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: initrd cleanup
Message-ID: <20011101020426.A31790@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

would that patch make someone really unhappy?
The point is that when you have an initrd with /linuxrc that one is
executed in any case, no need to force the root=ram0.


diff -urN linuxppc_2_4/arch/ppc/kernel/chrp_setup.c linuxppc_2_4/arch/ppc/kernel/chrp_setup.c
--- linuxppc_2_4/arch/ppc/kernel/chrp_setup.c	Sun Sep  9 21:35:14 2001
+++ linuxppc_2_4/arch/ppc/kernel/chrp_setup.c	Thu Nov  1 01:44:26 2001
@@ -235,12 +235,8 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* this is fine for chrp */
 	initrd_below_start_ok = 1;
-
-	if (initrd_start)
-		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	else
 #endif
-		ROOT_DEV = to_kdev_t(0x0802); /* sda2 (sda1 is for the kernel) */
+	ROOT_DEV = to_kdev_t(0x0802); /* sda2 (sda1 is for the kernel) */

 	/* Lookup PCI host bridges */
 	chrp_find_bridges();
diff -urN linuxppc_2_4/arch/ppc/kernel/pmac_setup.c linuxppc_2_4/arch/ppc/kernel/pmac_setup.c
--- linuxppc_2_4/arch/ppc/kernel/pmac_setup.c	Mon Oct 22 11:38:30 2001
+++ linuxppc_2_4/arch/ppc/kernel/pmac_setup.c	Thu Nov  1 01:44:11 2001
@@ -364,12 +364,8 @@
 #ifdef CONFIG_VT
 	kd_mksound = pmac_mksound;
 #endif
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	else
-#endif
-		ROOT_DEV = to_kdev_t(DEFAULT_ROOT_DEVICE);
+
+	ROOT_DEV = to_kdev_t(DEFAULT_ROOT_DEVICE);

 #ifdef CONFIG_SMP
 	/* Check for Core99 */
diff -urN linuxppc_2_4/arch/ppc/kernel/prep_setup.c linuxppc_2_4/arch/ppc/kernel/prep_setup.c
--- linuxppc_2_4/arch/ppc/kernel/prep_setup.c	Mon Oct 22 11:38:30 2001
+++ linuxppc_2_4/arch/ppc/kernel/prep_setup.c	Thu Nov  1 01:45:24 2001
@@ -265,11 +265,6 @@
 	case _PREP_Motorola:
 		/* Enable L2.  Assume we don't need to flush -- Cort*/
 		*(unsigned char *)(0x8000081c) |= 3;
-#ifdef CONFIG_BLK_DEV_INITRD
-		if (initrd_start)
-			ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0); /* /dev/ram */
-		else
-#endif
 #ifdef CONFIG_ROOT_NFS
 			ROOT_DEV = to_kdev_t(0x00ff); /* /dev/nfs */
 #else
diff -urN linuxppc_2_4/arch/ppc/kernel/setup.c linuxppc_2_4/arch/ppc/kernel/setup.c
--- linuxppc_2_4/arch/ppc/kernel/setup.c	Sat Oct 13 05:05:13 2001
+++ linuxppc_2_4/arch/ppc/kernel/setup.c	Thu Nov  1 01:46:22 2001
@@ -436,7 +436,6 @@
 					r3 += KERNELBASE;
 				initrd_start = r3;
 				initrd_end = r3 + r4;
-				ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
 				initrd_below_start_ok = 1;
 			}
 #endif

Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
