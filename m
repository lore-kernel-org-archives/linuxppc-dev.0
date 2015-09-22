Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 327361A09B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:51:02 +1000 (AEST)
Message-Id: <a8718136980080a9b8ec7b76e6786a434b50e447.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 15/25] powerpc/8xx: move 8xx SPRN defines into reg_8xx.h
 and add some missing ones
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:58 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move 8xx SPRN defines into reg_8xx.h and add some missing ones

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
No change in v2

 arch/powerpc/include/asm/mmu-8xx.h | 26 +++++++++++++-------------
 arch/powerpc/include/asm/reg_8xx.h | 24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index f05500a..44408d6 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -11,7 +11,7 @@
  * is written, and the contents of several registers are used to
  * create the entry.
  */
-#define SPRN_MI_CTR	784	/* Instruction TLB control register */
+/* SPRN_MI_CTR */	/* Instruction TLB control register */
 #define MI_GPM		0x80000000	/* Set domain manager mode */
 #define MI_PPM		0x40000000	/* Set subpage protection */
 #define MI_CIDEF	0x20000000	/* Set cache inhibit when MMU dis */
@@ -23,7 +23,7 @@
 /* These are the Ks and Kp from the PowerPC books.  For proper operation,
  * Ks = 0, Kp = 1.
  */
-#define SPRN_MI_AP	786
+/* SPRN_MI_AP */
 #define MI_Ks		0x80000000	/* Should not be set */
 #define MI_Kp		0x40000000	/* Should always be set */
 
@@ -44,7 +44,7 @@
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
  * this register are used to create the TLB entry.
  */
-#define SPRN_MI_EPN	787
+/* SPRN_MI_EPN */
 #define MI_EPNMASK	0xfffff000	/* Effective page number for entry */
 #define MI_EVALID	0x00000200	/* Entry is valid */
 #define MI_ASIDMASK	0x0000000f	/* ASID match value */
@@ -54,7 +54,7 @@
  * For the instruction TLB, it contains bits that get loaded into the
  * TLB entry when the MI_RPN is written.
  */
-#define SPRN_MI_TWC	789
+/* SPRN_MI_TWC */
 #define MI_APG		0x000001e0	/* Access protection group (0) */
 #define MI_GUARDED	0x00000010	/* Guarded storage */
 #define MI_PSMASK	0x0000000c	/* Mask of page size bits */
@@ -68,7 +68,7 @@
  * causes a TLB entry to be created for the instruction TLB, using
  * additional information from the MI_EPN, and MI_TWC registers.
  */
-#define SPRN_MI_RPN	790
+/* SPRN_MI_RPN */
 #define MI_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
 
 /* Define an RPN value for mapping kernel memory to large virtual
@@ -78,7 +78,7 @@
  */
 #define MI_BOOTINIT	0x000001fd
 
-#define SPRN_MD_CTR	792	/* Data TLB control register */
+/* SPRN_MD_CTR */	/* Data TLB control register */
 #define MD_GPM		0x80000000	/* Set domain manager mode */
 #define MD_PPM		0x40000000	/* Set subpage protection */
 #define MD_CIDEF	0x20000000	/* Set cache inhibit when MMU dis */
@@ -89,14 +89,14 @@
 #define MD_IDXMASK	0x00001f00	/* TLB index to be loaded */
 #define MD_RESETVAL	0x04000000	/* Value of register at reset */
 
-#define SPRN_M_CASID	793	/* Address space ID (context) to match */
+/* SPRN_M_CASID */	/* Address space ID (context) to match */
 #define MC_ASIDMASK	0x0000000f	/* Bits used for ASID value */
 
 
 /* These are the Ks and Kp from the PowerPC books.  For proper operation,
  * Ks = 0, Kp = 1.
  */
-#define SPRN_MD_AP	794
+/* SPRN_MD_AP */
 #define MD_Ks		0x80000000	/* Should not be set */
 #define MD_Kp		0x40000000	/* Should always be set */
 
@@ -117,7 +117,7 @@
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
  * this register are used to create the TLB entry.
  */
-#define SPRN_MD_EPN	795
+/* SPRN_MD_EPN */
 #define MD_EPNMASK	0xfffff000	/* Effective page number for entry */
 #define MD_EVALID	0x00000200	/* Entry is valid */
 #define MD_ASIDMASK	0x0000000f	/* ASID match value */
@@ -127,7 +127,7 @@
  * During a software tablewalk, reading this register provides the address
  * of the entry associated with MD_EPN.
  */
-#define SPRN_M_TWB	796
+/* SPRN_M_TWB */
 #define	M_L1TB		0xfffff000	/* Level 1 table base address */
 #define M_L1INDX	0x00000ffc	/* Level 1 index, when read */
 					/* Reset value is undefined */
@@ -137,7 +137,7 @@
  * when the MD_RPN is written.  It is also provides the hardware assist
  * for finding the PTE address during software tablewalk.
  */
-#define SPRN_MD_TWC	797
+/* SPRN_MD_TWC */
 #define MD_L2TB		0xfffff000	/* Level 2 table base address */
 #define MD_L2INDX	0xfffffe00	/* Level 2 index (*pte), when read */
 #define MD_APG		0x000001e0	/* Access protection group (0) */
@@ -155,13 +155,13 @@
  * causes a TLB entry to be created for the data TLB, using
  * additional information from the MD_EPN, and MD_TWC registers.
  */
-#define SPRN_MD_RPN	798
+/* SPRN_MD_RPN */
 #define MD_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
 
 /* This is a temporary storage register that could be used to save
  * a processor working register during a tablewalk.
  */
-#define SPRN_M_TW	799
+/* SPRN_M_TW */
 
 #ifndef __ASSEMBLY__
 typedef struct {
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index e8ea346..150323c 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -4,6 +4,21 @@
 #ifndef _ASM_POWERPC_REG_8xx_H
 #define _ASM_POWERPC_REG_8xx_H
 
+/* MMU registers */
+#define SPRN_MI_CTR	784	/* Instruction TLB control register */
+#define SPRN_MI_AP	786
+#define SPRN_MI_EPN	787
+#define SPRN_MI_TWC	789
+#define SPRN_MI_RPN	790
+#define SPRN_MD_CTR	792	/* Data TLB control register */
+#define SPRN_M_CASID	793	/* Address space ID (context) to match */
+#define SPRN_MD_AP	794
+#define SPRN_MD_EPN	795
+#define SPRN_M_TWB	796
+#define SPRN_MD_TWC	797
+#define SPRN_MD_RPN	798
+#define SPRN_M_TW	799
+
 /* Cache control on the MPC8xx is provided through some additional
  * special purpose registers.
  */
@@ -14,6 +29,15 @@
 #define SPRN_DC_ADR	569	/* Address needed for some commands */
 #define SPRN_DC_DAT	570	/* Read-only data register */
 
+/* Misc Debug */
+#define SPRN_DPDR	630
+#define SPRN_MI_CAM	816
+#define SPRN_MI_RAM0	817
+#define SPRN_MI_RAM1	818
+#define SPRN_MD_CAM	824
+#define SPRN_MD_RAM0	825
+#define SPRN_MD_RAM1	826
+
 /* Commands.  Only the first few are available to the instruction cache.
 */
 #define	IDC_ENABLE	0x02000000	/* Cache enable */
-- 
2.1.0
