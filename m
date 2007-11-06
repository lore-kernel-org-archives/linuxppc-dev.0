Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98EC5DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 10:03:19 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA6N4pCQ031349
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 18:04:51 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA6N3FY5128232
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 18:03:16 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA6N3Fqr024286
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 18:03:15 -0500
Date: Tue, 6 Nov 2007 16:59:09 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: mmap question on ppc440
Message-ID: <20071106165909.0e80fb4e@zod.rchland.ibm.com>
In-Reply-To: <1194386530.6523.37.camel@pasglop>
References: <472F8503.2080705@harris.com> <20071105151659.3ea601e4@weaponx>
	<200711060750.21750.sr@denx.de> <1194386530.6523.37.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 Nov 2007 09:02:10 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Tue, 2007-11-06 at 07:50 +0100, Stefan Roese wrote:
> > On Monday 05 November 2007, Josh Boyer wrote:
> > > > I am attempting to access the CPLD on the AMCC Sequoia board from
> > > > user-land.  I open /dev/mem, and mmap it, then try to access the
> > > > resulting pointer.  That works fine when accessing physical addresses
> > > > that correspond to RAM, but as soon as I try to access the CPLD at
> > > > physical address 0xc0000000, I get an infinite machine check.
> > >
> > > That's because the CPLD is actually at physical address 0x1C0000000.
> > > Yay for 36-bit physical addresses.
> > 
> > Right. Are you using arch/ppc or arch/powerpc? If it's arch/ppc you could
> > give the following patch a try:
> > 
> > @@ -275,6 +275,14 @@
> >  {
> >         size_t size = vma->vm_end - vma->vm_start;
> > 
> > +#if defined(CONFIG_44x) && !defined(CONFIG_PPC_MERGE)
> > +       /*
> > +        * 2006-08-07: sr
> > +        * Needed on 44x-er systems for 36bit addresses (like pci on 440gx)
> > +        */
> > +       vma->vm_pgoff = (fixup_bigphys_addr(vma->vm_pgoff << PAGE_SHIFT, size) >> PAGE_SHIFT);
> > +#endif
> > +
> >         if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
> >                 return -EINVAL;
> 
> I think we need to ditch the bigphys fixup stuff and come up with a way
> to make /dev/mem work with the actual 36 bits offsets (after all, it's
> all pgoff, it should work).

We did ditch bigphys in arch/powerpc.  mmap64 works apparently.

> The other problem is X of course... 32 bits X server currently cannot
> cope with physical addresses > 32 bits at all. They will just blow up or
> randomly scribble over /dev/mem.
> 
> The solution is libpciaccess and the new pci-rework branch of X which
> uses it, but I haven't had a chance to test that properly yet on 4xx.

Um... because arch/powerpc 4xx doesn't have PCI support? :)  You and
Valentine and Vitaly keep trading emails about it though, which is a
good sign.

josh
