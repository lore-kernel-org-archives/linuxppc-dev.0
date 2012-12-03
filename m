Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBB282C007E
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2012 02:07:58 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 3 Dec 2012 20:37:48 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CB7ADE004C
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2012 20:37:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB3F7nVa7667992
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2012 20:37:49 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB3KbekF010944
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2012 07:37:41 +1100
Subject: [PATCH v2 1/4] kprobes/powerpc: Do not disable External interrupts
 during single step
To: bigeasy@linutronix.de, oleg@redhat.com, ananth@in.ibm.com,
 srikar@linux.vnet.ibm.com
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Mon, 03 Dec 2012 20:37:42 +0530
Message-ID: <20121203150720.7727.91582.stgit@suzukikp>
In-Reply-To: <20121203150438.7727.74924.stgit@suzukikp>
References: <20121203150438.7727.74924.stgit@suzukikp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 anton@redhat.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suzuki K. Poulose <suzuki@in.ibm.com>

External/Decrement exceptions have lower priority than the Debug Exception.
So, we don't have to disable the External interrupts before a single step.
However, on BookE, Critical Input Exception(CE) has higher priority than a
Debug Exception. Hence we mask them.

Signed-off-by: 	Suzuki K. Poulose <suzuki@in.ibm.com>
Cc:		Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:		Ananth N Mavinakaynahalli <ananth@in.ibm.com>
Cc:		Kumar Gala <galak@kernel.crashing.org>
Cc:		linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/kprobes.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index e88c643..4901b34 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -104,13 +104,13 @@ void __kprobes arch_remove_kprobe(struct kprobe *p)
 
 static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
-	/* We turn off async exceptions to ensure that the single step will
-	 * be for the instruction we have the kprobe on, if we dont its
-	 * possible we'd get the single step reported for an exception handler
-	 * like Decrementer or External Interrupt */
-	regs->msr &= ~MSR_EE;
 	regs->msr |= MSR_SINGLESTEP;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
+	/* 
+	 * We turn off Critical Input Exception(CE) to ensure that the single
+	 * step will be for the instruction we have the probe on; if we don't,
+	 * it is possible we'd get the single step reported for CE.
+	 */
 	regs->msr &= ~MSR_CE;
 	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
 #ifdef CONFIG_PPC_47x
