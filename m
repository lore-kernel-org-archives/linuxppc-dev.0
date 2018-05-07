Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fw6G1VhqzF1dn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 07:01:57 +1000 (AEST)
Message-ID: <d747ecedad20fa9e72cb622094b335bb999a5831.camel@kernel.crashing.org>
Subject: Re: [PATCH] cxl: disable the lazy approach for irqs in POWERVM
 environment.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Date: Tue, 08 May 2018 07:01:47 +1000
In-Reply-To: <62dca845-827f-dd31-5cff-6eed3e5a5d86@linux.vnet.ibm.com>
References: <1521736674-13128-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1521771288.16434.326.camel@au1.ibm.com>
 <fd18ea29-18f9-ae02-4e26-535ee189f739@linux.vnet.ibm.com>
 <1521879295.16434.377.camel@kernel.crashing.org>
 <62dca845-827f-dd31-5cff-6eed3e5a5d86@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-07 at 18:02 +0200, christophe lombard wrote:
> 
> To answer to your questions, here is the timeline in the cxl driver
> 
>    1. call disable_irq()
> 
>    2. call plpar_hcall9() to attach a process element
> 	During this phase, phyp (as described in CAPI PAPR document) 	
> 	disables the virtual interrupts provided in the process-element-
> 	struct.
> 	Then the partition must use ibm,set-xive to enable the virtual
> 	interrupt source after H_ATTACH_CA_PROCESS completes
> 	successfully.

Ok, this is the breakage. This PAPR API is badly defined, nothing other
than the existing interrupt management PAPR calls should affect the
enable/disable state of the interrupt The fact that attaching a process
element does is a broken design.

>    3. call enable_irq()
> 	Before the following patch (genirq: Avoid unnecessary low level
> 	irq function calls) be pushed in mainline, the unmask api
> 	(= ics_rtas_unmask_irq()) was called by default and everything
> 	was ok.
> 
> 	With this patch, the unmask api is now called only if 		
> 	IRQD_IRQ_MASKED is set and in our case, it's never done and the
> 	irqs remain masked.
> 
> 
>    So, there is a disconnect between the 'HW' (phyp) state of the
>    interrupt and the IRQD_IRQ_MASKED flag.
> 
>    In the timeline of the cxl driver, the IRQD_IRQ_MASKED flag is never
>    set.
>    This flag was not used in enable_irq(), before that the patch "genirq:
>    Avoid ..." was pushed. So ics_rtas_unmask_irq() was called and
>    everything was ok.
> 
> Thanks
> 
> > > 
> > > 
> > > 
> > > > > Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> > > > > ---
> > > > >    drivers/misc/cxl/guest.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> > > > > index f58b4b6c..dc476e1 100644
> > > > > --- a/drivers/misc/cxl/guest.c
> > > > > +++ b/drivers/misc/cxl/guest.c
> > > > > @@ -389,6 +389,7 @@ static void disable_afu_irqs(struct cxl_context *ctx)
> > > > >    		hwirq = ctx->irqs.offset[r];
> > > > >    		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> > > > >    			virq = irq_find_mapping(NULL, hwirq);
> > > > > +			irq_set_status_flags(virq, IRQ_DISABLE_UNLAZY);
> > > > >    			disable_irq(virq);
> > > > >    		}
> > > > >    	}
