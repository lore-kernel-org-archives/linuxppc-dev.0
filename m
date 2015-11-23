Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id E2C691A02B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:10:37 +1100 (AEDT)
Message-ID: <1448273441.31665.186.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] sata_dwc_460ex: move to generic DMA driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  rsarmah@amcc.com, Alexey Brodkin
 <Alexey.Brodkin@synopsys.com>
Date: Mon, 23 Nov 2015 12:10:41 +0200
In-Reply-To: <yw1xwptab2zs.fsf@unicorn.mansr.com>
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <yw1xwptab2zs.fsf@unicorn.mansr.com>
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

On Sun, 2015-11-22 at 13:03 +0000, Måns Rullgård wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > The SATA implementation based on two actually different devices,
> > i.e. SATA and
> > DMA controllers.
> > 
> > For Synopsys DesignWare DMA we have already a generic
> > implementation of the
> > driver. Thus, the patch converts the code to use DMAEngine
> > framework and
> > dw_dmac driver.
> > 
> > In future it will be better to split the devices inside DTS as well
> > like it's
> > done on other platforms.


> > @@ -1721,16 +1227,16 @@ static int sata_dwc_probe(struct
> > platform_device *ofdev)
> >  		   idr, ver[0], ver[1], ver[2]);
> > 
> >  	/* Get SATA DMA interrupt number */
> > -	irq = irq_of_parse_and_map(np, 1);
> > -	if (irq == NO_IRQ) {
> > +	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
> 
> This doesn't look like it has been more than compile-tested.

Yes, that's true, my question [1] was a crying in the wilderness.

>   Nothing
> ever allocates hsdev->dma, so it can't possibly work.

You are right.

> 
> Also, has anyone given any thought to getting rid of the dependency
> on
> the DW DMA controller?

How? Before it was even more harder link to it (embedded routines).

On the other hand you may introduce dma_ops and use them like it's
done, for example, in spi-dw*.c

>   Presumably support for old device trees would
> need to be retained for compatibility.  Maybe checking for a "dmas"
> property and falling back on the current behaviour if it's missing.  

I didn't get how DT is related to DW or any other DMAC used with this
SATA controller.

> My
> goal is to get this driver working with another chip using the same
> SATA
> controller but a different DMA engine.

It would be nice to eventually bring this working with generic DMA
Engine API. Please, keep me in Cc list regarding this driver.

[1] https://lkml.org/lkml/2014/12/12/547

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
