Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B787EB6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 08:57:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8E7EDDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 08:57:16 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: blackluck@ktk.bme.hu
In-Reply-To: <4A465AF5.9000606@ktk.bme.hu>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
	<1245794228.10356.31.camel@pasglop> <1245799792.10356.42.camel@pasglop>
	<1245822826.9237.62.camel@concordia>
	<1245823019.10356.69.camel@pasglop>
	<1245824392.9237.85.camel@concordia>  <4A465AF5.9000606@ktk.bme.hu>
Content-Type: text/plain
Date: Sun, 28 Jun 2009 08:54:20 +1000
Message-Id: <1246143260.22312.66.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-06-27 at 19:46 +0200, Laszlo Fekete wrote:
> Hello!
> 
> Thank you very much, this patch works me too.
> 
> Maybe this patch will be in the debian kernel someday?

The patch isn't actually correct just yet :-) Michael will
be posting a proper one next week. It should be possible to
request its inclusion into debian separately, we'll probably
send it to stable@kernel.org as well.

Cheers,
Ben.

> Thank you: blackluck
> 
> Michael Ellerman wrote: 
> > On Wed, 2009-06-24 at 15:56 +1000, Benjamin Herrenschmidt wrote:
> >   
> > > On Wed, 2009-06-24 at 15:53 +1000, Michael Ellerman wrote:
> > >     
> > > > Doesn't fix my machine :/
> > > > 
> > > >       
> > > That doesn't make sense ... What if you remove the bit inside the ifdef
> > > CONFIG_MPIC_BROKEN_REGREAD in _mpic_read() ?
> > > 
> > > If that makes a difference, then it would be interesting to add a printk
> > > in there that prints what the original value "val" is and what we have
> > > in the shadow...
> > >     
> > 
> > With this patch it boots:
> > 
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 2353adc..fc17289 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -231,13 +231,16 @@ static inline u32 _mpic_irq_read(struct mpic *mpic, unsign
> >         unsigned int    isu = src_no >> mpic->isu_shift;
> >         unsigned int    idx = src_no & mpic->isu_mask;
> >         unsigned int    val;
> > +       unsigned int    shadow;
> >  
> >         val = _mpic_read(mpic->reg_type, &mpic->isus[isu],
> >                          reg + (idx * MPIC_INFO(IRQ_STRIDE)));  
> >  #ifdef CONFIG_MPIC_BROKEN_REGREAD
> > -       if (reg == 0)
> > -               val = (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY)) |
> > +       if (reg == 0) {
> > +               shadow = (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY)) |
> >                         mpic->isu_reg0_shadow[idx];
> > +               printk("%s: val 0x%x shadow 0x%x\n", __func__, val, shadow);
> > +       }
> >  #endif
> >         return val;
> >  }
> > 
> > 
> > And I see:
> > 
> > sym53c8xx 0000:00:0c.0: enabling device (0140 -> 0143)
> > sym0: <896> rev 0x7 at pci 0000:00:0c.0 irq 17
> > sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
> > _mpic_irq_read: val 0x80480004 shadow 0x80080014
> > _mpic_irq_read: val 0x480004 shadow 0x480004
> > 
> > 
> > 
> > cheers
> >   
