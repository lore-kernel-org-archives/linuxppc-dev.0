Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	by ozlabs.org (Postfix) with ESMTP id 0C02DB70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Feb 2011 17:02:04 +1100 (EST)
Date: Tue, 15 Feb 2011 07:01:58 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: irq_data conversion
Message-ID: <20110215060158.GG1727@mail.wantstofly.org>
References: <20110211125213.GE1240@mail.wantstofly.org>
	<20110214180715.GA30647@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110214180715.GA30647@angua.secretlab.ca>
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, glikely@secretlab.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 14, 2011 at 11:07:15AM -0700, Grant Likely wrote:

> > This patch converts powerpc over to the new irq_data based irq_chip
> > functions, as was done earlier for ARM and some other architectures.
> > 
> > struct irq_data is described here:
> > 
> > 	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ff7dcd44dd446db2c3e13bdedf2d52b8e0127f16
> > 
> > The new irq_chip functions are described here:
> > 
> > 	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8822657e799b02c55556c99a601261e207a299d
> > 
> > As I don't have powerpc hardware myself, this hasn't been well-tested
> > at all -- build and run-time testing would be much appreciated.
> 
> Apply warning:
> 
> /home/grant/hacking/linux-2.6/.git/rebase-apply/patch:3470: space before tab in indent.
>  	.irq_mask_ack	= uic_mask_ack_irq,
> warning: 1 line adds whitespace errors.

The original uic.c already had the space there, but yes, there's no
reason not to fix that while we're at it -- thanks.


> It seems to work fine on my ppc32 MPC5200 based Lite5200 board.
> 
> Got a build failure from my limited build farm:
> 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] cc1: warnings being treated as errors 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] /home/autotest/data/kernelcross/linux/arch/powerpc/platforms/pasemi/setup.c: In function 'pas_init_IRQ': 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] /home/autotest/data/kernelcross/linux/arch/powerpc/platforms/pasemi/setup.c:243: error: passing argument 1 of 'mpic_unmask_irq' makes pointer from integer without a cast 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] /home/autotest/data/kernelcross/linux/arch/powerpc/include/asm/mpic.h:470: note: expected 'struct irq_data *' but argument is of type 'int' 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] /home/autotest/data/kernelcross/linux/arch/powerpc/platforms/pasemi/setup.c: In function 'pas_machine_check_handler': 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] /home/autotest/data/kernelcross/linux/arch/powerpc/platforms/pasemi/setup.c:269: error: passing argument 1 of 'mpic_end_irq' makes pointer from integer without a cast 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] /home/autotest/data/kernelcross/linux/arch/powerpc/include/asm/mpic.h:474: note: expected 'struct irq_data *' but argument is of type 'int' 
> 02/14 10:38:57 ERROR|base_utils:0106| [stderr] make[3]: *** [arch/powerpc/platforms/pasemi/setup.o] Error 1 

OK, that should be fixed by this:


diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index f372ec1..a6067b3 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -240,7 +240,7 @@ static __init void pas_init_IRQ(void)
 		nmi_virq = irq_create_mapping(NULL, *nmiprop);
 		mpic_irq_set_priority(nmi_virq, 15);
 		set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
-		mpic_unmask_irq(nmi_virq);
+		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
 	of_node_put(mpic_node);
@@ -266,7 +266,7 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 	if (nmi_virq != NO_IRQ && mpic_get_mcirq() == nmi_virq) {
 		printk(KERN_ERR "NMI delivered\n");
 		debugger(regs);
-		mpic_end_irq(nmi_virq);
+		mpic_end_irq(irq_get_irq_data(nmi_virq));
 		goto out;
 	}
 

> I'm running it through the ozlabs build tester:
> 
> http://kisskb.ellerman.id.au/kisskb/branch/13/
> 
> Results should be available there sometime in the next 6-12 hours

Great, thanks.


thanks,
Lennert
