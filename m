Return-Path: <jwboyer@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5683C2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 05:53:18 +1000 (EST)
Received: by mail-ie0-f170.google.com with SMTP id at1so2359643iec.15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 May 2013 12:53:15 -0700 (PDT)
Date: Wed, 1 May 2013 15:53:01 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: Mike <michael.heltne@gmail.com>
Subject: Re: flush_icache_range on AMCC 44x targets
Message-ID: <20130501195301.GA8320@zod.gha.chartermi.net>
References: <CANtoAtNsjMdgdpj31myTDUBy_sbMk4nvgBzir_2ZHnSgsgZ=JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANtoAtNsjMdgdpj31myTDUBy_sbMk4nvgBzir_2ZHnSgsgZ=JQ@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 30, 2013 at 02:17:59PM +0200, Mike wrote:
>Hi,
>
>i was reading trough arch/powerpc/kernel/misc32.S looking at the icbi and
>iccci instructions, from whats on print in
>http://s.eeweb.com/members/kvks_kumar/answers/1356585717-PPC440_UM2013.pdf(page
>272) iccci should be used once in the power-on / reset routine, and
>as far as flush_icache_range goes presumably before icbi is called?

I'm not understanding your question.

>So should not flush_icache_range go
>#ifdef CONFIG_44x
>iccci    0, r0
>#endif
>icbi    0,r6

The icbi isn't ever executed on 44x at all.

>arch/powerpc/kernel/misc32.S:
>/*
> * Write any modified data cache blocks out to memory
> * and invalidate the corresponding instruction cache blocks.
> * This is a no-op on the 601.
> *
> * flush_icache_range(unsigned long start, unsigned long stop)
> */
>_KPROBE(__flush_icache_range)
>BEGIN_FTR_SECTION
>    blr                /* for 601, do nothing */
>END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>    li    r5,L1_CACHE_BYTES-1
>    andc    r3,r3,r5
>    subf    r4,r3,r4
>    add    r4,r4,r5
>    srwi.    r4,r4,L1_CACHE_SHIFT
>    beqlr
>    mtctr    r4
>    mr    r6,r3
>1:    dcbst    0,r3
>    addi    r3,r3,L1_CACHE_BYTES
>    bdnz    1b
>    sync                /* wait for dcbst's to get to ram */
>#ifndef CONFIG_44x

This part above is "if not defined CONFIG_44X", which means execute
everything below here until you hit #else if you are running on a
processor that isn't 4xx.

>    mtctr    r4
>2:    icbi    0,r6
>    addi    r6,r6,L1_CACHE_BYTES
>    bdnz    2b
>#else

Otherwise, use iccci.  Which is what you're sort of suggesting be done.

>    /* Flash invalidate on 44x because we are passed kmapped addresses and
>       this doesn't work for userspace pages due to the virtually tagged
>       icache.  Sigh. */
>    iccci    0, r0
>#endif

So.  I think the code is already doing what you think it should?

josh
