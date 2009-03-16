Return-Path: <hpa@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11BE4DDF81
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 05:42:50 +1100 (EST)
Date: Mon, 16 Mar 2009 18:42:27 GMT
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-tip-commits@vger.kernel.org
In-Reply-To: <20090316185256.4a160374.sfr@canb.auug.org.au>
References: <20090316185256.4a160374.sfr@canb.auug.org.au>
Subject: [tip:irq/sparseirq] sparseirq,
	powerpc/cell: fix unused variable warning in interrupt.c
Message-ID: <tip-a6bc3262c561780d2a6587aa3d5715b1e7d8fa13@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de,
	yinghai@kernel.org, mingo@elte.hu
Reply-To: mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
	yinghai@kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	sfr@canb.auug.org.au, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit-ID:  a6bc3262c561780d2a6587aa3d5715b1e7d8fa13
Gitweb:     http://git.kernel.org/tip/a6bc3262c561780d2a6587aa3d5715b1e7d8fa13
Author:     Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate: Mon, 16 Mar 2009 18:52:56 +1100
Commit:     Ingo Molnar <mingo@elte.hu>
CommitDate: Mon, 16 Mar 2009 09:21:57 +0100

sparseirq, powerpc/cell: fix unused variable warning in interrupt.c

This new compiler warning:

   arch/powerpc/platforms/cell/interrupt.c: In function 'handle_iic_irq':
   arch/powerpc/platforms/cell/interrupt.c:240: warning: unused variable 'cpu'

Triggers because the local variable 'cpu' became unused due to commit:

   dee4102: sparseirq: use kstat_irqs_cpu instead

Remove the variable.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
LKML-Reference: <20090316185256.4a160374.sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@elte.hu>


---
 arch/powerpc/platforms/cell/interrupt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 1f0d774..882e470 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -237,8 +237,6 @@ extern int noirqdebug;
 
 static void handle_iic_irq(unsigned int irq, struct irq_desc *desc)
 {
-	const unsigned int cpu = smp_processor_id();
-
 	spin_lock(&desc->lock);
 
 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
