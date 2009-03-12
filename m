Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id CBBF3DDF6F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 00:28:02 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Proposal: [PATCH] Workaround for MPC5121 DTLB errata
Date: Thu, 12 Mar 2009 14:30:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903121430.49077.david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Partial workaround for DTLB errata in MPC5121e processors of die M36P and 
older (all currently existing versions).

Due to the bug, the hardware-implemented LRU algorythm always goes to way 1 of 
the TLB. This fix forces writes to go to way 0, which would speed up 
memory-copy operations where bits 15...19 of source and destination address 
are the same.

Signed-off-by: David Jander <david@protonic.nl>

---
 arch/powerpc/kernel/head_32.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -614,6 +614,14 @@ DataStoreTLBMiss:
  */
        mfctr   r0
        /* Get PTE (linux-style) and check access */
+#ifdef CONFIG_PPC_MPC512x
+/* MPC512x: (partial) workaround for errata in die M36P and earlier:
+ * Force writes to Way 0 (reads are always way 1)
+ */
+       mfspr   r3,SPRN_SRR1
+       rlwinm  r3,r3,0,15,13  /* Mask out SRR1[WAY] */
+       mtspr   SPRN_SRR1,r3
+#endif
        mfspr   r3,SPRN_DMISS
        lis     r1,PAGE_OFFSET@h                /* check if kernel address */
        cmplw   0,r1,r3
