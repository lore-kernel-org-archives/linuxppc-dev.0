Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id F18E5DDF87
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 01:00:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so416159pyi.27
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 08:00:46 -0700 (PDT)
Message-ID: <fa686aa40808140800s417af75ex76ae73ec990be58d@mail.gmail.com>
Date: Thu, 14 Aug 2008 09:00:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH v2] powerpc: add ioremap_early() function for mapping
	IO regions before MMU_init()
In-Reply-To: <1C19524E-8400-4F61-AEB1-19CF20E71098@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080813025726.26033.29519.stgit@trillian.secretlab.ca>
	<1C19524E-8400-4F61-AEB1-19CF20E71098@kernel.crashing.org>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 7:00 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Aug 12, 2008, at 10:03 PM, Grant Likely wrote:
>
>> +/**
>> + * ioremap_early - Allow large persistant IO regions to be mapped early.
>> + * @addr: physical address of region
>> + * @size: size of region
>> + *
>> + * This routine uses setbat() to set up IO ranges before the MMU is
>> + * fully configured.
>> + *
>> + * This routine can be called really early, before MMU_init() is called.
>>  It
>> + * is useful for setting up early debug output consoles and frequently
>> + * accessed IO regions, like the internally memory mapped registers
>> (IMMR)
>> + * in an SoC.  Ranges mapped with this function persist even after
>> MMU_init()
>> + * is called and the MMU is turned on 'for real.'
>> + *
>> + * The region mapped is large (minimum size of 128k) and virtual mapping
>> must
>> + * be aligned against this boundary.  Therefore, to avoid fragmentation
>> all
>> + * calls to ioremap_early() are best made before any calls to ioremap
>> + * for smaller regions.
>> + */
>> +void __iomem * __init
>> +ioremap_early(phys_addr_t addr, unsigned long size)
>> +{
>> +       unsigned long v, p;
>> +       int i;
>> +
>> +       /* Be loud and annoying if someone calls this too late.
>> +        * No need to crash the kernel though */
>> +       WARN_ON(mem_init_done);
>> +       if (mem_init_done)
>> +               return NULL;
>> +
>> +       /* Make sure request is sane */
>> +       if (size == 0)
>> +               return NULL;
>> +
>> +       /* If the region is already block mapped, then there is nothing
>> +        * to do; just return the mapped address */
>> +       v = p_mapped_by_bats(addr);
>> +       if (v)
>> +               return (void __iomem *)v;
>> +
>> +       /* Adjust size to reflect aligned region */
>> +       p = _ALIGN_DOWN(addr, 128 << 10); /* BATs align on 128k boundaries
>> */
>> +       size = ALIGN(addr - p + size, 128 << 10);
>> +
>> +       /* Allocate the aligned virtual base address.  ALIGN_DOWN is used
>> +        * to ensure no overlaps occur with normal 4k ioremaps. */
>> +       v = ioremap_bot = _ALIGN_DOWN(ioremap_bot, 128 << 10) - size;
>> +
>> +       /* Set up a BAT for this IO region */
>> +       i = loadbat(v, p, size, _PAGE_IO);
>
> what happens if we run out of bats?

Then it returns NULL and the caller must handle it.  The board port
maintainer needs understand the board/CPU/SoC and not depend on more
BATs than are available.  They also need to understand that there is a
tradeoff between BATs for IO and BATs for RAM.  If the board port uses
up all the BATs for IO, then RAM above 256MB ends up getting mapped
with PTEs and there is a performance hit.  My expectation is that only
platform code will use this facility.  Device drivers should continue
to use ioremap() and will gain the benefit of the BATs if platform
code already set them up.  I can add some text to the documentation to
describe this.

I'm not going to make any attempt to fallback to PTEs for IO when
there isn't enough BATs.  Doing so adds an order of magnitude more
complexity.

> does this actually build on any non-BAT based ppc32 system?

Heh, oops.  I had built the older version of this on 4xx, but I didn't
do this one.  I'll fix it in v3

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
