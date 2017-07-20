Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCvDj322dzDqlX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 23:01:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matt Brown <matthew.brown.dev@gmail.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-ide\@vger.kernel.org" <linux-ide@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "adi-buildroot-devel\@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-spi <linux-spi@vger.kernel.org>,
 "linux-serial\@vger.kernel.org" <linux-serial@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
In-Reply-To: <CAMuHMdXU-R8kBs_xp7XDK0pnC5fakpghchuEPD8jtEcHLmgyHg@mail.gmail.com>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
 <87mv7zgwpl.fsf@concordia.ellerman.id.au>
 <CAMuHMdXU-R8kBs_xp7XDK0pnC5fakpghchuEPD8jtEcHLmgyHg@mail.gmail.com>
Date: Thu, 20 Jul 2017 23:01:56 +1000
Message-ID: <87h8y7gt2z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Thu, Jul 20, 2017 at 1:43 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Matt Brown <matthew.brown.dev@gmail.com> writes:
>>> The cacheflush prototypes currently use start and stop values and each
>>> call requires typecasting the address to an unsigned long.
>>> This patch changes the cacheflush prototypes to follow the x86 style of
>>> using a base and size values, with base being a void pointer.
>>>
>>> All callers of the cacheflush functions, including drivers, have been
>>> modified to conform to the new prototypes.
>>>
>>> The 64 bit cacheflush functions which were implemented in assembly code
>>> (flush_dcache_range, flush_inval_dcache_range) have been translated into
>>> C for readability and coherence.
>
>>> --- a/arch/powerpc/include/asm/cacheflush.h
>>> +++ b/arch/powerpc/include/asm/cacheflush.h
>>> @@ -51,13 +51,13 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
>>>   * Write any modified data cache blocks out to memory and invalidate them.
>>>   * Does not invalidate the corresponding instruction cache blocks.
>>>   */
>>> -static inline void flush_dcache_range(unsigned long start, unsigned long stop)
>>> +static inline void flush_dcache_range(void *start, unsigned long size)
>>>  {
>>> -     void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
>>> -     unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
>>> +     void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
>>
>> unsigned long would be nicer than u32.
>
> Indeed. That would make this work on ppc64, too.
> After which ppc64 has an identical copy (u64 = unsigned long on ppc64) below?

That was Matt's homework to notice that ;)

cheers
