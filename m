Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECE101A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 20:16:51 +1100 (AEDT)
Message-ID: <1444209410.19375.2.camel@ellerman.id.au>
Subject: Re: powerpc: Fix _ALIGN_* errors due to type difference.
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 07 Oct 2015 20:16:50 +1100
In-Reply-To: <87si5n12xd.fsf@linux.vnet.ibm.com>
References: <20151006094843.C8ECF140D71@ozlabs.org>
 <87si5n12xd.fsf@linux.vnet.ibm.com>
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

On Wed, 2015-10-07 at 14:16 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > On Fri, 2015-02-10 at 14:33:48 UTC, "Aneesh Kumar K.V" wrote:
> >> This avoid errors like
> >> 
> >>         unsigned int usize = 1 << 30;
> >>         int size = 1 << 30;
> >>         unsigned long addr = 64UL << 30 ;
> >> 
> >>         value = _ALIGN_DOWN(addr, usize); -> 0
> >>         value = _ALIGN_DOWN(addr, size);  -> 0x1000000000
> >
> > Are you actually seeing that anywhere? I assume not.
> 
> I hit that in new development. So not in the current kernel.

OK.

> >> diff --git a/arch/powerpc/boot/page.h b/arch/powerpc/boot/page.h
> >> index 14eca30fef64..87c42d7d283d 100644
> >> --- a/arch/powerpc/boot/page.h
> >> +++ b/arch/powerpc/boot/page.h
> >> @@ -22,8 +22,8 @@
> >>  #define PAGE_MASK	(~(PAGE_SIZE-1))
> >>  
> >>  /* align addr on a size boundary - adjust address up/down if needed */
> >> -#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
> >> -#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
> >> +#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
> >> +#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
> >>  
> >>  /* align addr on a size boundary - adjust address up if needed */
> >>  #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
> >> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> >> index 71294a6e976e..1dd69774a31c 100644
> >> --- a/arch/powerpc/include/asm/page.h
> >> +++ b/arch/powerpc/include/asm/page.h
> >> @@ -240,8 +240,8 @@ extern long long virt_phys_offset;
> >>  #endif
> >>  
> >>  /* align addr on a size boundary - adjust address up/down if needed */
> >> -#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
> >> -#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
> >> +#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
> >> +#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
> >
> >
> > It looks like ALIGN() in kernel.h already does this right, so can we just use
> > that instead for _ALIGN_UP() at least.
> >
> 
> But we still can't get rid of _ALIGN_UP, because that is used in other
> parts of the kernel and if you are suggesting use
> 
> #define _ALIGN_UP __ALIGN_KERNEL, IMHO that is unnecessary indirection
> for no real benefit.

Huh? The benefit is not having to define the same macro twice, that seems like
a pretty clear win.

_ALIGN_UP is ALIGN, just with this bug unfixed.

In other words if _ALIGN_UP was already an alias for ALIGN then you would have
not seen the bug (except in _ALIGN_DOWN()).

cheers
