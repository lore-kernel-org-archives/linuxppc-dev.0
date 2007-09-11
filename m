Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D5BADDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 01:51:49 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l8BFpgvx017317
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 08:51:42 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] QE: simplify GUEMR register initialization
Date: Tue, 11 Sep 2007 10:51:39 -0500
Message-Id: <11895258991411-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The initialization of the QE's GUEMR register is overly complicated, involving
multiple functions and a redundant ucc_common structure.  This patch removes
struct ucc_common, merges ucc_init_guemr() into ucc_set_type() (every caller
of ucc_init_guemr() also calls ucc_set_type() immediately afterward), and
removes the unused enum ucc_pram_initial_offset.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/ucc.c      |   62 ++++++++++++++++++++-------------
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |   12 +-----
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |   12 +-----
 include/asm-powerpc/immap_qe.h        |   11 +-----
 include/asm-powerpc/qe.h              |    7 ++--
 include/asm-powerpc/ucc.h             |   24 +------------
 6 files changed, 48 insertions(+), 80 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
index f970e54..597204f 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -43,43 +43,57 @@ int ucc_set_qe_mux_mii_mng(int ucc_num)
 }
 EXPORT_SYMBOL(ucc_set_qe_mux_mii_mng);
 
-int ucc_set_type(int ucc_num, struct ucc_common *regs,
-		 enum ucc_speed_type speed)
+/* Configure the UCC to either Slow or Fast.
+ *
+ * A given UCC can be figured to support either "slow" devices (e.g. UART)
+ * or "fast" devices (e.g. Ethernet).
+ *
+ * 'ucc_num' is the UCC number, from 0 - 7.
+ *
+ * This function also sets the UCC_GUEMR_SET_RESERVED3 bit because that bit
+ * must always be set to 1.
+ */
+int ucc_set_type(unsigned int ucc_num, enum ucc_speed_type speed)
 {
-	u8 guemr = 0;
+	u8 __iomem *p_guemr;
+	u8 mode;	/* The GUEMR register mode bits */
 
-	/* check if the UCC number is in range. */
-	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0))
+	/* The GUEMR register is at the same location for both slow and fast
+	   devices, so we just use uccX.slow.guemr. */
+	switch (ucc_num) {
+	case 0: p_guemr = &qe_immr->ucc1.slow.guemr;
+		break;
+	case 1: p_guemr = &qe_immr->ucc2.slow.guemr;
+		break;
+	case 2: p_guemr = &qe_immr->ucc3.slow.guemr;
+		break;
+	case 3: p_guemr = &qe_immr->ucc4.slow.guemr;
+		break;
+	case 4: p_guemr = &qe_immr->ucc5.slow.guemr;
+		break;
+	case 5: p_guemr = &qe_immr->ucc6.slow.guemr;
+		break;
+	case 6: p_guemr = &qe_immr->ucc7.slow.guemr;
+		break;
+	case 7: p_guemr = &qe_immr->ucc8.slow.guemr;
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	guemr = regs->guemr;
-	guemr &= ~(UCC_GUEMR_MODE_MASK_RX | UCC_GUEMR_MODE_MASK_TX);
 	switch (speed) {
 	case UCC_SPEED_TYPE_SLOW:
-		guemr |= (UCC_GUEMR_MODE_SLOW_RX | UCC_GUEMR_MODE_SLOW_TX);
+		mode = UCC_GUEMR_MODE_SLOW_RX | UCC_GUEMR_MODE_SLOW_TX;
 		break;
 	case UCC_SPEED_TYPE_FAST:
-		guemr |= (UCC_GUEMR_MODE_FAST_RX | UCC_GUEMR_MODE_FAST_TX);
+		mode = UCC_GUEMR_MODE_FAST_RX | UCC_GUEMR_MODE_FAST_TX;
 		break;
 	default:
 		return -EINVAL;
 	}
-	regs->guemr = guemr;
-
-	return 0;
-}
-
-int ucc_init_guemr(struct ucc_common *regs)
-{
-	u8 guemr = 0;
-
-	if (!regs)
-		return -EINVAL;
-
-	/* Set bit 3 (which is reserved in the GUEMR register) to 1 */
-	guemr = UCC_GUEMR_SET_RESERVED3;
 
-	regs->guemr = guemr;
+	out_8(p_guemr, (in_8(p_guemr) & ~UCC_GUEMR_MODE_MASK) |
+		UCC_GUEMR_SET_RESERVED3 | mode);
 
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index 3df202e..aa0fdd4 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -226,17 +226,9 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	uccf->rx_discarded = 0;
 #endif				/* STATISTICS */
 
-	/* Init Guemr register */
-	if ((ret = ucc_init_guemr((struct ucc_common *) (uf_regs)))) {
-		printk(KERN_ERR "%s: cannot init GUEMR", __FUNCTION__);
-		ucc_fast_free(uccf);
-		return ret;
-	}
-
 	/* Set UCC to fast type */
-	if ((ret = ucc_set_type(uf_info->ucc_num,
-				(struct ucc_common *) (uf_regs),
-				UCC_SPEED_TYPE_FAST))) {
+	ret = ucc_set_type(uf_info->ucc_num, UCC_SPEED_TYPE_FAST);
+	if (ret) {
 		printk(KERN_ERR "%s: cannot set UCC type", __FUNCTION__);
 		ucc_fast_free(uccf);
 		return ret;
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 1f65c26..bc30e1c 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -187,17 +187,9 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 
 	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
 
-	/* Init Guemr register */
-	if ((ret = ucc_init_guemr((struct ucc_common *) us_regs))) {
-		printk(KERN_ERR "%s: cannot init GUEMR", __FUNCTION__);
-		ucc_slow_free(uccs);
-		return ret;
-	}
-
 	/* Set UCC to slow type */
-	if ((ret = ucc_set_type(us_info->ucc_num,
-				(struct ucc_common *) us_regs,
-				UCC_SPEED_TYPE_SLOW))) {
+	ret = ucc_set_type(us_info->ucc_num, UCC_SPEED_TYPE_SLOW);
+	if (ret) {
 		printk(KERN_ERR "%s: cannot set UCC type", __FUNCTION__);
 		ucc_slow_free(uccs);
 		return ret;
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 1020b7f..16ed82f 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -260,7 +260,6 @@ struct ucc_slow {
 	__be16	utpt;
 	u8	res4[0x52];
 	u8	guemr;		/* UCC general extended mode register */
-	u8	res5[0x200 - 0x091];
 } __attribute__ ((packed));
 
 /* QE UCC Fast */
@@ -293,21 +292,13 @@ struct ucc_fast {
 	__be32	urtry;		/* UCC retry counter register */
 	u8	res8[0x4C];
 	u8	guemr;		/* UCC general extended mode register */
-	u8	res9[0x100 - 0x091];
-} __attribute__ ((packed));
-
-/* QE UCC */
-struct ucc_common {
-	u8	res1[0x90];
-	u8	guemr;
-	u8	res2[0x200 - 0x091];
 } __attribute__ ((packed));
 
 struct ucc {
 	union {
 		struct	ucc_slow slow;
 		struct	ucc_fast fast;
-		struct	ucc_common common;
+		u8	res[0x200];	/* UCC blocks are 512 bytes each */
 	};
 } __attribute__ ((packed));
 
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 9d304b1..2256188 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -321,13 +321,14 @@ enum qe_clock {
 #define UPGCR_ADDR	0x10000000	/* Master MPHY Addr multiplexing */
 #define UPGCR_DIAG	0x01000000	/* Diagnostic mode */
 
-/* UCC */
+/* UCC GUEMR register */
 #define UCC_GUEMR_MODE_MASK_RX	0x02
-#define UCC_GUEMR_MODE_MASK_TX	0x01
 #define UCC_GUEMR_MODE_FAST_RX	0x02
-#define UCC_GUEMR_MODE_FAST_TX	0x01
 #define UCC_GUEMR_MODE_SLOW_RX	0x00
+#define UCC_GUEMR_MODE_MASK_TX	0x01
+#define UCC_GUEMR_MODE_FAST_TX	0x01
 #define UCC_GUEMR_MODE_SLOW_TX	0x00
+#define UCC_GUEMR_MODE_MASK (UCC_GUEMR_MODE_MASK_RX | UCC_GUEMR_MODE_MASK_TX)
 #define UCC_GUEMR_SET_RESERVED3	0x10	/* Bit 3 in the guemr is reserved but
 					   must be set 1 */
 
diff --git a/include/asm-powerpc/ucc.h b/include/asm-powerpc/ucc.h
index afe3076..f96ea54 100644
--- a/include/asm-powerpc/ucc.h
+++ b/include/asm-powerpc/ucc.h
@@ -28,35 +28,13 @@ enum ucc_speed_type {
 	UCC_SPEED_TYPE_FAST, UCC_SPEED_TYPE_SLOW
 };
 
-/* Initial UCCs Parameter RAM address relative to: MEM_MAP_BASE (IMMR).
-*/
-enum ucc_pram_initial_offset {
-	UCC_PRAM_OFFSET_UCC1 = 0x8400,
-	UCC_PRAM_OFFSET_UCC2 = 0x8500,
-	UCC_PRAM_OFFSET_UCC3 = 0x8600,
-	UCC_PRAM_OFFSET_UCC4 = 0x9000,
-	UCC_PRAM_OFFSET_UCC5 = 0x8000,
-	UCC_PRAM_OFFSET_UCC6 = 0x8100,
-	UCC_PRAM_OFFSET_UCC7 = 0x8200,
-	UCC_PRAM_OFFSET_UCC8 = 0x8300
-};
-
 /* ucc_set_type
  * Sets UCC to slow or fast mode.
  *
  * ucc_num - (In) number of UCC (0-7).
- * regs    - (In) pointer to registers base for the UCC.
  * speed   - (In) slow or fast mode for UCC.
  */
-int ucc_set_type(int ucc_num, struct ucc_common *regs,
-		 enum ucc_speed_type speed);
-
-/* ucc_init_guemr
- * Init the Guemr register.
- *
- * regs - (In) pointer to registers base for the UCC.
- */
-int ucc_init_guemr(struct ucc_common *regs);
+int ucc_set_type(unsigned int ucc_num, enum ucc_speed_type speed);
 
 int ucc_set_qe_mux_mii_mng(int ucc_num);
 
-- 
1.5.2.4
