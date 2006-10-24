Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54ABC67C52
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 06:09:08 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9OK950v010517
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 16:09:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9OK851h361894
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 14:08:05 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9OK84lx016040
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 14:08:04 -0600
Date: Tue, 24 Oct 2006 15:08:03 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: map 4K iommu pages even on 64K largepage systems
Message-ID: <20061024200803.GC6360@austin.ibm.com>
References: <20061024002540.GA6360@austin.ibm.com>
	<1161665007.10524.572.camel@localhost.localdomain>
	<1161666868.10524.577.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161666868.10524.577.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
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


Hi Ben,

The patch tests well; bt there was one change I didn't understand ...

> +++ linux-cell/include/asm-powerpc/iommu.h	2006-10-24 14:58:45.000000000 +1000
> +
> +#define IOMMU_PAGE_SHIFT      12


> +++ linux-cell/include/asm-powerpc/tce.h	2006-10-24 14:59:20.000000000 +1000
>  
>  #define TCE_SHIFT	12
>  #define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
> -#define TCE_PAGE_FACTOR	(PAGE_SHIFT - TCE_SHIFT)

This is zero now, but if anyone ever changes IOMMU_PAGE_SHIFT to a
value oter than 12,  then the below will break:

> +++ linux-cell/arch/powerpc/platforms/pseries/iommu.c	2006-10-24 15:00:07.000000000 +1000
>  
> -	index <<= TCE_PAGE_FACTOR;
> -	npages <<= TCE_PAGE_FACTOR;

since this shift does need to be made, if IOMMU_PAGE_SHIFT != TCE_SHIFT

> +++ linux-cell/arch/powerpc/sysdev/dart.h	2006-10-24 15:01:16.000000000 +1000
>  
>  #define DART_PAGE_SHIFT		12
>  #define DART_PAGE_SIZE		(1 << DART_PAGE_SHIFT)
> -#define DART_PAGE_FACTOR	(PAGE_SHIFT - DART_PAGE_SHIFT)

I'd argue that the right fix would have been

> +#define DART_PAGE_FACTOR	(IOMMU_PAGE_SHIFT - DART_PAGE_SHIFT)

> +++ linux-cell/arch/powerpc/sysdev/dart_iommu.c	2006-10-24 15:01:47.000000000 +1000
>  
> -	index <<= DART_PAGE_FACTOR;
> -	npages <<= DART_PAGE_FACTOR;

And do *not* remove these lines... certainly, they would have to be
put back in if we made iommu_page_size to be a variable in the iommu
table..

--linas
