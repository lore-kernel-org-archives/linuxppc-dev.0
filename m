Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A47FDDDFA3
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 18:52:57 +1100 (EST)
Date: Mon, 16 Mar 2009 18:52:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] powerpc/cell: fix unused variable warning in interrupt.c
Message-Id: <20090316185256.4a160374.sfr@canb.auug.org.au>
In-Reply-To: <20090202174817.dd4a26f0.sfr@canb.auug.org.au>
References: <20090202174817.dd4a26f0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


arch/powerpc/platforms/cell/interrupt.c: In function 'handle_iic_irq':
arch/powerpc/platforms/cell/interrupt.c:240: warning: unused variable 'cpu'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/interrupt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

On Mon, 2 Feb 2009 17:48:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next build (powerpc ppc64_defconfig) produced this warning:
> 
> arch/powerpc/platforms/cell/interrupt.c: In function 'handle_iic_irq':
> arch/powerpc/platforms/cell/interrupt.c:240: warning: unused variable 'cpu'
> 
> Caused by commit dee4102a9a5882b4f7d5cc165ba29e8cc63cf92e ("sparseirq:
> use kstat_irqs_cpu instead").

This patch is relative to next-20090312 and updates the sparseirq tree.

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
-- 
1.6.2

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
