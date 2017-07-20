Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCt2H1KZqzDqpB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 22:07:51 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id r9so950374ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 05:07:51 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <87mv7zgwpl.fsf@concordia.ellerman.id.au>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
 <87mv7zgwpl.fsf@concordia.ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Jul 2017 14:07:46 +0200
Message-ID: <CAMuHMdXU-R8kBs_xp7XDK0pnC5fakpghchuEPD8jtEcHLmgyHg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Brown <matthew.brown.dev@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-spi <linux-spi@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2017 at 1:43 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Matt Brown <matthew.brown.dev@gmail.com> writes:
>> The cacheflush prototypes currently use start and stop values and each
>> call requires typecasting the address to an unsigned long.
>> This patch changes the cacheflush prototypes to follow the x86 style of
>> using a base and size values, with base being a void pointer.
>>
>> All callers of the cacheflush functions, including drivers, have been
>> modified to conform to the new prototypes.
>>
>> The 64 bit cacheflush functions which were implemented in assembly code
>> (flush_dcache_range, flush_inval_dcache_range) have been translated into
>> C for readability and coherence.

>> --- a/arch/powerpc/include/asm/cacheflush.h
>> +++ b/arch/powerpc/include/asm/cacheflush.h
>> @@ -51,13 +51,13 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
>>   * Write any modified data cache blocks out to memory and invalidate them.
>>   * Does not invalidate the corresponding instruction cache blocks.
>>   */
>> -static inline void flush_dcache_range(unsigned long start, unsigned long stop)
>> +static inline void flush_dcache_range(void *start, unsigned long size)
>>  {
>> -     void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
>> -     unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
>> +     void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
>
> unsigned long would be nicer than u32.

Indeed. That would make this work on ppc64, too.
After which ppc64 has an identical copy (u64 = unsigned long on ppc64) below?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
