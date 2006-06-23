Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:15:37 +1000
Subject: [PATCH] Remove remaining iSeries debugger cruft
Message-Id: <20060623081535.2B18B67A6C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

None of this seems to be necessary, so let's see if can remove it and not
break anything. Booted on iSeries & pSeries here.

NB. we don't remove the hvReleaseData, we just move it down so that the file
reads more clearly.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/head_64.S          |   37 ++++++++-------------------------
 arch/powerpc/platforms/iseries/setup.c |   12 ----------
 2 files changed, 9 insertions(+), 40 deletions(-)

Index: to-merge/arch/powerpc/kernel/head_64.S
===================================================================
--- to-merge.orig/arch/powerpc/kernel/head_64.S
+++ to-merge/arch/powerpc/kernel/head_64.S
@@ -85,34 +85,6 @@ END_FTR_SECTION(0, 1)
 	/* Catch branch to 0 in real mode */
 	trap
 
-#ifdef CONFIG_PPC_ISERIES
-	/*
-	 * At offset 0x20, there is a pointer to iSeries LPAR data.
-	 * This is required by the hypervisor
-	 */
-	. = 0x20
-	.llong hvReleaseData-KERNELBASE
-
-	/*
-	 * At offset 0x28 and 0x30 are offsets to the mschunks_map
-	 * array (used by the iSeries LPAR debugger to do translation
-	 * between physical addresses and absolute addresses) and
-	 * to the pidhash table (also used by the debugger)
-	 */
-	.llong mschunks_map-KERNELBASE
-	.llong 0	/* pidhash-KERNELBASE SFRXXX */
-
-	/* Offset 0x38 - Pointer to start of embedded System.map */
-	.globl	embedded_sysmap_start
-embedded_sysmap_start:
-	.llong	0
-	/* Offset 0x40 - Pointer to end of embedded System.map */
-	.globl	embedded_sysmap_end
-embedded_sysmap_end:
-	.llong	0
-
-#endif /* CONFIG_PPC_ISERIES */
-
 	/* Secondary processors spin on this value until it goes to 1. */
 	.globl  __secondary_hold_spinloop
 __secondary_hold_spinloop:
@@ -124,6 +96,15 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.llong	0x0
 
+#ifdef CONFIG_PPC_ISERIES
+	/*
+	 * At offset 0x20, there is a pointer to iSeries LPAR data.
+	 * This is required by the hypervisor
+	 */
+	. = 0x20
+	.llong hvReleaseData-KERNELBASE
+#endif /* CONFIG_PPC_ISERIES */
+
 	. = 0x60
 /*
  * The following code is used on pSeries to hold secondary processors
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -81,8 +81,6 @@ static void iSeries_pci_final_fixup(void
 #endif
 
 extern int rd_size;		/* Defined in drivers/block/rd.c */
-extern unsigned long embedded_sysmap_start;
-extern unsigned long embedded_sysmap_end;
 
 extern unsigned long iSeries_recal_tb;
 extern unsigned long iSeries_recal_titan;
@@ -563,16 +561,6 @@ static void __init iSeries_fixup_klimit(
 	if (naca.xRamDisk)
 		klimit = KERNELBASE + (u64)naca.xRamDisk +
 			(naca.xRamDiskSize * HW_PAGE_SIZE);
-	else {
-		/*
-		 * No ram disk was included - check and see if there
-		 * was an embedded system map.  Change klimit to take
-		 * into account any embedded system map
-		 */
-		if (embedded_sysmap_end)
-			klimit = KERNELBASE + ((embedded_sysmap_end + 4095) &
-					0xfffffffffffff000);
-	}
 }
 
 static int __init iSeries_src_init(void)
