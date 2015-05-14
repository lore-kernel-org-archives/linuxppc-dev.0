Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0131.outbound.protection.outlook.com [157.56.110.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FBA01A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 06:18:15 +1000 (AEST)
Message-ID: <1431634680.3868.200.camel@freescale.com>
Subject: Re: [PATCH 3/4] powerpc32: memset(0): use cacheable_memzero
From: Scott Wood <scottwood@freescale.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Date: Thu, 14 May 2015 15:18:00 -0500
In-Reply-To: <555461BF.5020105@c-s.fr>
References: <cover.1431436210.git.christophe.leroy@c-s.fr>
 <9010ef9da0b2730af564a138b8d316d48eaf6d43.1431436210.git.christophe.leroy@c-s.fr>
 <1431564909.3868.162.camel@freescale.com> <555461BF.5020105@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Kyle Moffett <kyle@moffetthome.net>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-14 at 10:50 +0200, christophe leroy wrote:
> 
> Le 14/05/2015 02:55, Scott Wood a écrit :
> > On Tue, 2015-05-12 at 15:32 +0200, Christophe Leroy wrote:
> >> cacheable_memzero uses dcbz instruction and is more efficient than
> >> memset(0) when the destination is in RAM
> >>
> >> This patch renames memset as generic_memset, and defines memset
> >> as a prolog to cacheable_memzero. This prolog checks if the byte
> >> to set is 0 and if the buffer is in RAM. If not, it falls back to
> >> generic_memcpy()
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   arch/powerpc/lib/copy_32.S | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
> >> index cbca76c..d8a9a86 100644
> >> --- a/arch/powerpc/lib/copy_32.S
> >> +++ b/arch/powerpc/lib/copy_32.S
> >> @@ -12,6 +12,7 @@
> >>   #include <asm/cache.h>
> >>   #include <asm/errno.h>
> >>   #include <asm/ppc_asm.h>
> >> +#include <asm/page.h>
> >>   
> >>   #define COPY_16_BYTES		\
> >>   	lwz	r7,4(r4);	\
> >> @@ -74,6 +75,18 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
> >>    * to set them to zero.  This requires that the destination
> >>    * area is cacheable.  -- paulus
> >>    */
> >> +_GLOBAL(memset)
> >> +	cmplwi	r4,0
> >> +	bne-	generic_memset
> >> +	cmplwi	r5,L1_CACHE_BYTES
> >> +	blt-	generic_memset
> >> +	lis	r8,max_pfn@ha
> >> +	lwz	r8,max_pfn@l(r8)
> >> +	tophys	(r9,r3)
> >> +	srwi	r9,r9,PAGE_SHIFT
> >> +	cmplw	r9,r8
> >> +	bge-	generic_memset
> >> +	mr	r4,r5
> > max_pfn includes highmem, and tophys only works on normal kernel
> > addresses.
> Is there any other simple way to determine whether an address is in RAM 
> or not ?

If you want to do it based on the virtual address, rather than doing a
tablewalk or TLB search, you need to limit it to lowmem.

> I did that because of the below function from mm/mem.c
> 
> |int  page_is_ram(unsigned long  pfn)
> {
> #ifndef CONFIG_PPC64	/* XXX for now */
> 	return  pfn<  max_pfn;
> #else
> 	unsigned long  paddr= (pfn<<  PAGE_SHIFT);
> 	struct  memblock_region*reg;
> 
> 	for_each_memblock(memory,  reg)
> 		if  (paddr>=  reg->base&&  paddr< (reg->base+  reg->size))
> 			return  1;
> 	return  0;
> #endif
> }

Right, the problem is figuring out the pfn in the first place.

> > If we were to point memset_io, memcpy_toio, etc. at noncacheable
> > versions, are there any other callers left that can reasonably point at
> > uncacheable memory?
> Do you mean we could just consider that memcpy() and memset() are called 
> only with destination on RAM and thus we could avoid the check ?

Maybe.  If that's not a safe assumption I hope someone will point it
out.

> copy_tofrom_user() already does this assumption (allthought a user app 
> could possibly provide a buffer located in an ALSA mapped IO area)

The user could also pass in NULL.  That's what the fixups are for. :-)

-Scott
