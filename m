Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51C99DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 09:02:23 +1100 (EST)
Subject: Re: mmap question on ppc440
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711060750.21750.sr@denx.de>
References: <472F8503.2080705@harris.com> <20071105151659.3ea601e4@weaponx>
	<200711060750.21750.sr@denx.de>
Content-Type: text/plain
Date: Wed, 07 Nov 2007 09:02:10 +1100
Message-Id: <1194386530.6523.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-11-06 at 07:50 +0100, Stefan Roese wrote:
> On Monday 05 November 2007, Josh Boyer wrote:
> > > I am attempting to access the CPLD on the AMCC Sequoia board from
> > > user-land.  I open /dev/mem, and mmap it, then try to access the
> > > resulting pointer.  That works fine when accessing physical addresses
> > > that correspond to RAM, but as soon as I try to access the CPLD at
> > > physical address 0xc0000000, I get an infinite machine check.
> >
> > That's because the CPLD is actually at physical address 0x1C0000000.
> > Yay for 36-bit physical addresses.
> 
> Right. Are you using arch/ppc or arch/powerpc? If it's arch/ppc you could
> give the following patch a try:
> 
> @@ -275,6 +275,14 @@
>  {
>         size_t size = vma->vm_end - vma->vm_start;
> 
> +#if defined(CONFIG_44x) && !defined(CONFIG_PPC_MERGE)
> +       /*
> +        * 2006-08-07: sr
> +        * Needed on 44x-er systems for 36bit addresses (like pci on 440gx)
> +        */
> +       vma->vm_pgoff = (fixup_bigphys_addr(vma->vm_pgoff << PAGE_SHIFT, size) >> PAGE_SHIFT);
> +#endif
> +
>         if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
>                 return -EINVAL;

I think we need to ditch the bigphys fixup stuff and come up with a way
to make /dev/mem work with the actual 36 bits offsets (after all, it's
all pgoff, it should work).

The other problem is X of course... 32 bits X server currently cannot
cope with physical addresses > 32 bits at all. They will just blow up or
randomly scribble over /dev/mem.

The solution is libpciaccess and the new pci-rework branch of X which
uses it, but I haven't had a chance to test that properly yet on 4xx.

Ben.
