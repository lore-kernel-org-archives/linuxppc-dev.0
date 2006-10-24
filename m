Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F82367BE2
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 07:41:44 +1000 (EST)
Subject: Re: [PATCH] powerpc: map 4K iommu pages even on 64K largepage systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061024200803.GC6360@austin.ibm.com>
References: <20061024002540.GA6360@austin.ibm.com>
	<1161665007.10524.572.camel@localhost.localdomain>
	<1161666868.10524.577.camel@localhost.localdomain>
	<20061024200803.GC6360@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 07:41:23 +1000
Message-Id: <1161726084.10524.622.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-24 at 15:08 -0500, Linas Vepstas wrote:
> Hi Ben,
> 
> The patch tests well; bt there was one change I didn't understand ...
> 
> > +++ linux-cell/include/asm-powerpc/iommu.h	2006-10-24 14:58:45.000000000 +1000
> > +
> > +#define IOMMU_PAGE_SHIFT      12
> 
> 
> > +++ linux-cell/include/asm-powerpc/tce.h	2006-10-24 14:59:20.000000000 +1000
> >  
> >  #define TCE_SHIFT	12
> >  #define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
> > -#define TCE_PAGE_FACTOR	(PAGE_SHIFT - TCE_SHIFT)
> 
> This is zero now, but if anyone ever changes IOMMU_PAGE_SHIFT to a
> value oter than 12,  then the below will break:

My point is that we'll probably not change IOMMU_PAGE_SHIFT. The only
thing we might do is to move the shift into the iommu_table structure to
make it per-iommu (in which case the TCE backend will use 4k or 64k
depending on actual HW/FW support for those sizes).

> > +++ linux-cell/arch/powerpc/platforms/pseries/iommu.c	2006-10-24 15:00:07.000000000 +1000
> >  
> > -	index <<= TCE_PAGE_FACTOR;
> > -	npages <<= TCE_PAGE_FACTOR;
> 
> since this shift does need to be made, if IOMMU_PAGE_SHIFT != TCE_SHIFT

Which will not happen.

> > +++ linux-cell/arch/powerpc/sysdev/dart.h	2006-10-24 15:01:16.000000000 +1000
> >  
> >  #define DART_PAGE_SHIFT		12
> >  #define DART_PAGE_SIZE		(1 << DART_PAGE_SHIFT)
> > -#define DART_PAGE_FACTOR	(PAGE_SHIFT - DART_PAGE_SHIFT)
> 
> I'd argue that the right fix would have been
> 
> > +#define DART_PAGE_FACTOR	(IOMMU_PAGE_SHIFT - DART_PAGE_SHIFT)

See my above comment :)

> > +++ linux-cell/arch/powerpc/sysdev/dart_iommu.c	2006-10-24 15:01:47.000000000 +1000
> >  
> > -	index <<= DART_PAGE_FACTOR;
> > -	npages <<= DART_PAGE_FACTOR;
> 
> And do *not* remove these lines... certainly, they would have to be
> put back in if we made iommu_page_size to be a variable in the iommu
> table..

No. DART would set the table shift to DART_PAGE_SHIFT, TCE would set it
to TCE_PAGE_SHIFT and the backend would always get natively sized
addresses/counts.

Ben.
