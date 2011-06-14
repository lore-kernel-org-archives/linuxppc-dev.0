Return-Path: <sfbest@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57E50B6FAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 04:16:07 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5EHjO7a020947
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2011 13:45:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5EIFvQX684156
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2011 14:15:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5EIFv1R021209
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2011 15:15:57 -0300
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
From: Steve Best <sfbest@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <1308072658.2452.10.camel@orca.stoopid.dyndns.org>
References: <20110614165011.23034.66685.sendpatchset@squad5-lp1.lab.bos.redhat.com>
	<1308072658.2452.10.camel@orca.stoopid.dyndns.org>
Content-Type: text/plain
Date: Tue, 14 Jun 2011 14:17:01 -0400
Message-Id: <1308075422.13495.8.camel@dhcp-100-2-27.bos.redhat.com>
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


On Tue, 2011-06-14 at 12:30 -0500, Nathan Lynch wrote:
> Hi Steve,
> 
> On Tue, 2011-06-14 at 12:58 -0400, Steve Best wrote:
> > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > index e72dcf6..e1aab6b 100644
> > --- a/arch/powerpc/Kconfig.debug
> > +++ b/arch/powerpc/Kconfig.debug
> > @@ -283,4 +283,15 @@ config PPC_EARLY_DEBUG_CPM_ADDR
> >  	  platform probing is done, all platforms selected must
> >  	  share the same address.
> >  
> > +config STRICT_DEVMEM
> > +        def_bool y
> 
> Default new config items to n, please.

ok
> 
> 
> > --- a/arch/powerpc/mm/mem.c
> > +++ b/arch/powerpc/mm/mem.c
> > @@ -520,3 +520,21 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> >  	hash_preload(vma->vm_mm, address, access, trap);
> >  #endif /* CONFIG_PPC_STD_MMU */
> >  }
> > +
> > +/*
> > + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
> > + * is valid. The argument is a physical page number.
> > + *
> > + * On PowerPC, access has to be given to data regions used by X. We have to
> > + * disallow access to device-exclusive MMIO regions and system RAM. 
> > + */
> > +int devmem_is_allowed(unsigned long pfn)
> > +{
> > +        if ((pfn >= 57360 || pfn <= 57392))
> > +                return 1;
> 
> That seems... fragile.  Where do these numbers come from, and are they
> appropriate for all platforms and configurations?

This is the range I got from testing pseries blades and servers. maybe
there is a better way to get this range anyone know of a way?
> 
> 
-Steve
