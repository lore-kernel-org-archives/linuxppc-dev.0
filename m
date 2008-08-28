Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C534DDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 20:36:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7SAalKN018715
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Aug 2008 06:36:47 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7SAalRk224046
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Aug 2008 06:36:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7SAakUw003592
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Aug 2008 06:36:47 -0400
Date: Thu, 28 Aug 2008 06:36:44 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: vb <vb@vsbe.com>
Subject: Re: mmap and ppc460gt
Message-ID: <20080828063644.2ee4cf7c@zod.rchland.ibm.com>
In-Reply-To: <f608b67d0808272047i1c455c8bsb820d61bd8051bcf@mail.gmail.com>
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com> <200808271013.18659.arnd@arndb.de>
	<f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
	<adawsi2j8wt.fsf@cisco.com> <adak5e1kf2u.fsf@cisco.com>
	<f608b67d0808272047i1c455c8bsb820d61bd8051bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Roland Dreier <rdreier@cisco.com>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 27 Aug 2008 20:47:24 -0700
vb <vb@vsbe.com> wrote:

> On Wed, Aug 27, 2008 at 8:12 PM, Roland Dreier <rdreier@cisco.com> wrote:
> > OK, please try this and let me know if it helps:
> >
> > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > index 1c93c25..98d7bf9 100644
> > --- a/arch/powerpc/mm/mem.c
> > +++ b/arch/powerpc/mm/mem.c
> > @@ -75,11 +75,10 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
> >
> >  int page_is_ram(unsigned long pfn)
> >  {
> > -       unsigned long paddr = (pfn << PAGE_SHIFT);
> > -
> >  #ifndef CONFIG_PPC64   /* XXX for now */
> > -       return paddr < __pa(high_memory);
> > +       return pfn < max_pfn;
> >  #else
> > +       unsigned long paddr = (pfn << PAGE_SHIFT);
> >        int i;
> >        for (i=0; i < lmb.memory.cnt; i++) {
> >                unsigned long base;
> >
> 
> Ronald, thank you for the hint,  I actually tried something slightly different:
> 
> return pfn < (__pa(high_memory) >> PAGE_SHIFT);
> 
> and it worked. I guess your fix is faster, I'll try it tomorrow.
> 
> I also checked that the problem is there in the top of the tree in
> Linus' git - isn't it amazing - I guess very few people use mmap()
> nowadays, everybody must be using UIO device :-)

No, most people use device drivers in the kernel.

josh
