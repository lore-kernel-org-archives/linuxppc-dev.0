Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B8272C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:35:20 +1000 (EST)
Date: Tue, 10 Jul 2012 19:34:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/booke: Eliminate rfi from exception entry path.
Message-ID: <20120711003454.GA22757@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unlike classic, we don't really need the MSR change to be atomic with the
branch.  This eliminates a trap as a KVM guest (in the absence of
hardware hypervisor extensions), where mtmsr is paravirtualized but rfi
is not.  For a virtualized guest without any paravirtualization, this
eliminates an additional two traps (SRR0/1).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/entry_32.S |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ba3aeb4..6bb637c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -193,6 +193,9 @@ transfer_to_handler_cont:
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_BOOKE
+	mtmsr	r10
+#else
 	lis	r12,reenable_mmu@h
 	ori	r12,r12,reenable_mmu@l
 	mtspr	SPRN_SRR0,r12
@@ -201,6 +204,7 @@ transfer_to_handler_cont:
 	RFI
 reenable_mmu:				/* re-enable mmu so we can */
 	mfmsr	r10
+#endif /* !CONFIG_BOOKE */
 	lwz	r12,_MSR(r1)
 	xor	r10,r10,r12
 	andi.	r10,r10,MSR_EE		/* Did EE change? */
@@ -247,11 +251,23 @@ reenable_mmu:				/* re-enable mmu so we can */
 	mtlr	r9
 	bctr				/* jump to handler */
 #else /* CONFIG_TRACE_IRQFLAGS */
+#ifdef CONFIG_BOOKE
+	/*
+	 * We're not changing address space on Book E, and the extra rfi
+	 * can hurt when virtualized without hardware support -- whereas
+	 * mtmsr can be paravirtualized.
+	 */
+	mtmsr	r10
+	mtctr	r11
+	mtlr	r9
+	bctr
+#else
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r10
 	mtlr	r9
 	SYNC
 	RFI				/* jump to handler, enable MMU */
+#endif /* !CONFIG_BOOKE */
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #if defined (CONFIG_6xx) || defined(CONFIG_E500)
-- 
1.7.5.4
