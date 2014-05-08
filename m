Return-Path: <anton@samba.org>
Date: Thu, 8 May 2014 22:31:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/powernv: Correctly set hypervisor interrupt little
 endian bit on POWER8
Message-ID: <20140508223138.4d600b60@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HID0 IBM bit 19 is the HILE bit on POWER8. Set it to 0 to take
exceptions in big endian and to 1 to take them in little endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/reg.h
===================================================================
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -397,6 +397,7 @@
 #define SPRN_HASH1	0x3D2		/* Primary Hash Address Register */
 #define SPRN_HASH2	0x3D3		/* Secondary Hash Address Resgister */
 #define SPRN_HID0	0x3F0		/* Hardware Implementation Register 0 */
+#define HID0_HILE_SH	(63 - 19)	/* Hypervisor interrupt little endian */
 #define HID0_HDICE_SH	(63 - 23)	/* 970 HDEC interrupt enable */
 #define HID0_EMCP	(1<<31)		/* Enable Machine Check pin */
 #define HID0_EBA	(1<<29)		/* Enable Bus Address Parity */
Index: b/arch/powerpc/kernel/cpu_setup_power.S
===================================================================
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -60,6 +60,7 @@ _GLOBAL(__setup_cpu_power8)
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
+	bl	__init_HILE
 	mtlr	r11
 	blr
 
@@ -78,6 +79,7 @@ _GLOBAL(__restore_cpu_power8)
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
+	bl	__init_HILE
 	mtlr	r11
 	blr
 
@@ -132,6 +134,26 @@ __init_HFSCR:
 	mtspr	SPRN_HFSCR,r3
 	blr
 
+__init_HILE:
+	mfspr	r3,SPRN_HID0
+	li	r4,1
+	sldi	r4,r4,HID0_HILE_SH
+#ifdef __LITTLE_ENDIAN__
+	or	r3,r3,r4
+#else
+	andc	r3,r3,r4
+#endif
+	sync
+	mtspr	SPRN_HID0,r3
+	mfspr	r3,SPRN_HID0
+	mfspr	r3,SPRN_HID0
+	mfspr	r3,SPRN_HID0
+	mfspr	r3,SPRN_HID0
+	mfspr	r3,SPRN_HID0
+	mfspr	r3,SPRN_HID0
+	isync
+	blr
+
 /*
  * Clear the TLB using the specified IS form of tlbiel instruction
  * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
