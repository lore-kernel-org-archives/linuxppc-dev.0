Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Thu, 19 Aug 2010 08:34:45 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] powerpc/4xx: Index interrupt stacks by physical cpu
Message-ID: <20100819123445.GA9695@zod.rchland.ibm.com>
References: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1282149866-4710-4-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282149866-4710-4-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 18, 2010 at 11:44:25AM -0500, Dave Kleikamp wrote:
>The interrupt stacks need to be indexed by the physical cpu since the
>critical, debug and machine check handlers use the contents of SPRN_PIR to
>index the critirq_ctx, dbgirq_ctx, and mcheckirq_ctx arrays.
>
>Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/irq.c      |   15 ++++++++-------
> arch/powerpc/kernel/setup_32.c |    9 +++++----
> 2 files changed, 13 insertions(+), 11 deletions(-)
>
>diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
>index d3ce67c..52e9c95 100644
>--- a/arch/powerpc/kernel/irq.c
>+++ b/arch/powerpc/kernel/irq.c
>@@ -446,22 +446,23 @@ struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
> void exc_lvl_ctx_init(void)
> {
> 	struct thread_info *tp;
>-	int i;
>+	int i, hw_cpu;
>
> 	for_each_possible_cpu(i) {
>-		memset((void *)critirq_ctx[i], 0, THREAD_SIZE);
>-		tp = critirq_ctx[i];
>+		hw_cpu = get_hard_smp_processor_id(i);

This one throws this compile error when trying to build
ppc44x_defconfig:

CC      arch/powerpc/kernel/irq.o
arch/powerpc/kernel/irq.c: In function 'exc_lvl_ctx_init':
arch/powerpc/kernel/irq.c:452: error: implicit declaration of function
'get_hard_smp_processor_id'
make[1]: *** [arch/powerpc/kernel/irq.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

I'm guessing it needs a #include <asm/smp.h> added to it.

josh
