Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcMh639wBzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 15:32:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, "pc\@us.ibm.com" <pc@us.ibm.com>
Subject: Re: [PATCH] powerpc/64s: dt_cpu_ftrs boot time setup option
In-Reply-To: <20170530101828.49ee3154@roar.ozlabs.ibm.com>
References: <20170511112441.30287-1-npiggin@gmail.com>
 <87h9046jmq.fsf@concordia.ellerman.id.au>
 <20170530101828.49ee3154@roar.ozlabs.ibm.com>
Date: Tue, 30 May 2017 15:32:54 +1000
Message-ID: <87shjm6ha1.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> On Mon, 29 May 2017 20:29:49 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
...
>> 
>> In practice it works because the base CPU spec that we initialise in
>> dt_cpu_ftrs.c is mostly OK, and skiboot also adds the cpu-version
>> property which causes us to call identify_cpu() again later, but that's
>> all a bit fragile IMHO.
>
> Yeah that's a huge bug :P Good catch. Possible something would fail on
> CPUs that aren't POWER8/9.

Yeah I had to hack a bit to make it fail because there's a few fallbacks
that save us - but yeah on something more different it would break.
 
>> So unfortunately I think we need to add logic in dt_cpu_ftrs_init() to
>> look for dt_cpu_ftrs=off on the command line.
>> 
>> The patch below seems to work, but would appreciate more eyes on it.
>
> I can't find a problem with it, but I don't know how this fdt/prom stuff
> all fits together exactly. Why is early_cmdline_parse() using call_prom
> for essentially the same thing?

Yeah it's a mess.

early_cmdline_parse() is in prom_init.c, which is *totally* different to
prom.c, confusing much?

prom_init runs while OpenFirmware is still alive, so it calls OF (aka.
prom) for things, whereas prom.c is part of the kernel proper and only
has the flat device tree to use.


I'll squash this in and send a v2.

cheers
