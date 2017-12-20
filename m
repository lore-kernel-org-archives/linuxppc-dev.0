Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gtV14FhzDrvJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:17 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sbrG078970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:15 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyav94gkv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:14 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:13 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 01/17] powerpc/64: do not trace irqs-off at interrupt
 return to soft-disabled context
Date: Wed, 20 Dec 2017 09:25:41 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

When an interrupt is returning to a soft-disabled context (which can
happen for non-maskable interrupts or synchronous interrupts), it goes
through the motions of soft-disabling again, including calling
TRACE_DISABLE_INTS (i.e., trace_hardirqs_off()).

This is not necessary, because we must already be soft-disabled in the
interrupt context, it also may be causing crashes in the irq tracing
code to re-enter as an nmi. Replace it with a warning to ensure that
soft-interrupts are still disabled.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 3320bcac7192..b3055ebf20d1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -911,9 +911,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	beq	1f
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
-1:	li	r0,0
-	stb	r0,PACASOFTIRQEN(r13);
-	TRACE_DISABLE_INTS
+1:
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
+	/* The interrupt should not have soft enabled. */
+	lbz	r7,PACASOFTIRQEN(r13)
+	tdnei	r7,0
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
+#endif
 	b	.Ldo_restore
 
 	/*
-- 
2.7.4
