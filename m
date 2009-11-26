Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C680D1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:10:47 +1100 (EST)
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0E9F11.5000605@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1259212694.16367.270.camel@pasglop>  <4B0E9F11.5000605@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 08:10:41 +1100
Message-ID: <1259269841.18084.24.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 16:30 +0100, Albert Herranz wrote:
> Benjamin Herrenschmidt wrote:
> > On Sun, 2009-11-22 at 23:01 +0100, Albert Herranz wrote:
> > 
> >> +static void flipper_pic_mask_and_ack(unsigned int virq)
> >> +{
> >> +	int irq = virq_to_hw(virq);
> >> +	void __iomem *io_base = get_irq_chip_data(virq);
> >> +
> >> +	clear_bit(irq, io_base + FLIPPER_IMR);
> >> +	set_bit(irq, io_base + FLIPPER_ICR);
> >> +}
> > 
> > Do not use clear_bit and set_bit on IOs. They will do lwarx/stwcx. which
> > is really not what you want. You can use __clear_bit and __set_bit but
> > it's still fishy. Those operate on unsigned long, so the size vary
> > between 32 and 64 bit etc... not something you care that much about, but
> > it's still the wrong tool for the job.
> > 
> > Do those guys have more than 32 interrupts ? If not, just hand
> > code the msak & shifts. If they do, then maybe stick with __clear_bit()
> > and __set_bit() which are the non atomic variants.
> > 
> 
> There can be only 32 interrupt sources per pic.
> I'll build a mask and check if just a simple write works too (it should IMHO), instead of a RWM.

For the ICR just writes should be ok. For the IMR, I wouldn't be
surprised if you need to RMW. In which case you have two options:

 - One is you just do RMW :-) As long as you don't do SMP, you don't
have a problem since these callbacks are generally called with local
IRQs off.

 - Or you could explicitely add a spinlock_irqsave just out of paranoia
or if you envision SMP type access to these things (from the aux
processor ? But then the spinlock would have to be shared with the aux
ptiocrocessor FW... fun)

 - In any case, clear_bit and set_bit are the wrong accessors since
lwarx and stwcx. are definitely the wrong instructions to use for non
cachable accesses. On other processor you probably would have blown up
here in fact. Also those accessors don't provide any memory barriers
which mean you may even have some ordering issues. Use readl_be() and
writel_be() (or the ppc specific in_be32/out_be32) or the _le variants
if you want to count bits backward :-)

- You could also keep in memory cache of what the mask is supposed to
be. You RMW the cache and do a simple store to the register. It won't
fix the concurrency problem (that you probably don't have anyways) but
it will make things faster by avoiding an MMIO load....

 - However you probably need that MMIO load anyways :-) Trick is, the
store you do to ack and mask an interrupt may take some time to hit the
PIC before the said PIC actually lowers the CPU EE line. Enough time for
your code to go back, re-enable MSR:EE and start calling into the
handlers. Enough time thus to catch a "spurrious" interrupt. Old pmacs
have a similar PIC and have the same problem. I would recommend that
after a mask or a mask & ack, you also read back the register. The MMIO
accessors (readl, etc...) will use a twi;isync construct to ensure that
the load has been fully completed before execution continues which will
help.

 - The construct and flow handler you use assume all interrupts are
level sensitive, this is the case right ?

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> 
> Thanks,
> Albert
