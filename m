Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id E3C54DE0AB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 21:18:07 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: [RFC] [PATCH v2] MPC5121 TLB errata workaround
Date: Fri, 13 Mar 2009 11:20:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903131121.00077.david.jander@protonic.nl>
Cc: Paul Mackerras <paulus@samba.org>, Wolfgang Denk <wd@denx.de>,
	Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Complete workaround for DTLB errata in MPC5121e processors of die M36P and 
older (all currently existing versions).

Due to the bug, the hardware-implemented LRU algorythm always goes to way 1 of 
the TLB. This fix implements the proposed software workaround in form of a LRW table for chosing the TLB-way.

Signed-off-by: David Jander <david@protonic.nl>

---
 arch/powerpc/kernel/head_32.S |   65 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 0f4fac5..a88b3aa 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -540,6 +540,10 @@ DataLoadTLBMiss:
  * r2: ptr to linux-style pte
  * r3: scratch
  */
+#ifdef CONFIG_PPC_MPC512x
+       b      TlbWo    /* Code for TLB-errata workaround doesn't fit here */
+RFTlbWo:
+#endif
        mfctr   r0
        /* Get PTE (linux-style) and check access */
        mfspr   r3,SPRN_DMISS
@@ -612,6 +616,31 @@ DataStoreTLBMiss:
  * r2: ptr to linux-style pte
  * r3: scratch
  */
+#ifdef CONFIG_PPC_MPC512x
+/* MPC512x: workaround for errata in die M36P and earlier:
+ * Implement LRW for TLB way.
+ */
+       mfspr   r3,SPRN_DMISS
+       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
+       lis     r2,lrw@ha       /* Search index in lrw[] */
+       addi    r2,r2,lrw@l
+       tophys(r2,r2)
+       lwzx    r1,r3,r2       /* Get item from lrw[] */
+       cmpwi   0,r1,0         /* Was it way 0 last time? */
+       beq-    0,113f         /* Then goto 113: */
+
+       mfspr   r1,SPRN_SRR1
+       rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
+       mtspr   SPRN_SRR1,r1
+
+       li      r0,0
+       stwx    r0,r3,r2       /* Make lrw[] entry 0 */
+       b       114f
+113:
+       li      r0,1
+       stwx    r0,r3,r2       /* Make lrw[] entry 1 */
+114:
+#endif
        mfctr   r0
        /* Get PTE (linux-style) and check access */
        mfspr   r3,SPRN_DMISS
@@ -688,6 +717,34 @@ DataStoreTLBMiss:
        .globl mol_trampoline
        .set mol_trampoline, i0x2f00

+#ifdef CONFIG_PPC_MPC512x
+TlbWo:
+/* MPC512x: workaround for errata in die M36P and earlier:
+ * Implement LRW for TLB way.
+ */
+       mfspr   r3,SPRN_DMISS
+       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
+       lis     r2,lrw@ha       /* Search index in lrw[] */
+       addi    r2,r2,lrw@l
+       tophys(r2,r2)
+       lwzx    r1,r3,r2       /* Get item from lrw[] */
+       cmpwi   0,r1,0         /* Was it way 0 last time? */
+       beq-    0,113f         /* Then goto 113: */
+
+       mfspr   r1,SPRN_SRR1
+       rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
+       mtspr   SPRN_SRR1,r1
+
+       li      r0,0
+       stwx    r0,r3,r2       /* Make lrw[] entry 0 */
+       b       114f
+113:
+       li      r0,1
+       stwx    r0,r3,r2       /* Make lrw[] entry 1 */
+114:
+       b       RFTlbWo
+#endif
+
        . = 0x3000

 AltiVecUnavailable:
@@ -1321,6 +1378,14 @@ intercept_table:
        .long 0, 0, 0, 0, 0, 0, 0, 0
        .long 0, 0, 0, 0, 0, 0, 0, 0
        .long 0, 0, 0, 0, 0, 0, 0, 0
+
+#ifdef CONFIG_PPC_MPC512x
+lrw:
+       .long 0, 0, 0, 0, 0, 0, 0, 0
+       .long 0, 0, 0, 0, 0, 0, 0, 0
+       .long 0, 0, 0, 0, 0, 0, 0, 0
+       .long 0, 0, 0, 0, 0, 0, 0, 0
+#endif

 /* Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
