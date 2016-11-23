Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP0l50Rc0zDw5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 22:40:33 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tP0l43bXBz9t0w
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2016 22:40:32 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 3so961247pgd.0
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2016 03:40:32 -0800 (PST)
Subject: Re: [RFC] [PATCH] Trace TLBIE's
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3dcd0c76-46fd-cb7a-945d-4b5a679fa544@gmail.com>
 <87polmtscd.fsf@concordia.ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8a496713-bc00-6520-b715-481de507363e@gmail.com>
Date: Wed, 23 Nov 2016 22:40:36 +1100
MIME-Version: 1.0
In-Reply-To: <87polmtscd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/11/16 21:15, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> Just a quick patch to trace tlbie(l)'s. The idea being that it can be
>> enabled when we suspect corruption or when we need to see if we are doing
>> the right thing during flush. I think the format can be enhanced to
>> make it nicer (expand the RB/RS/IS/L cases in more detail). For now I am
>> sharing the idea to get inputs
>>
>> A typical trace might look like this
>>
>>
>> <...>-5141  [062]  1354.486693: tlbie:                
>> 	tlbie with lpid 0, local 0, rb=7b5d0ff874f11f1, rs=0, ric=0 prs=0 r=0
>> systemd-udevd-2584  [018]  1354.486772: tlbie:
>> 	tlbie with lpid 0, local 0, rb=17be1f421adc10c1, rs=0, ric=0 prs=0 r=0
>> ...
>>
>> qemu-system-ppc-5371  [016]  1412.369519: tlbie:
>> 	tlbie with lpid 0, local 1, rb=67bd8900174c11c1, rs=0, ric=0 prs=0 r=0
>> qemu-system-ppc-5377  [056]  1421.687262: tlbie:
>> 	tlbie with lpid 1, local 0, rb=5f04edffa00c11c1, rs=1, ric=0 prs=0 r=0
> 
> My first reaction is "why the hell do we have so many open-coded
> tlbies". So step one might be to add a static inline helper, that way we
> don't have to add the trace_tlbie() in so many places.
> 

The problem is the variants

Hash uses the two operand variant and radix on p9 uses the 5 operand variant.
To make matters even more complex depending on the CPU_FTR_ARCH we also have
operand variants with L and a version where the immediate value was removed.
I've tried to encapsulate the traces with their variants, but that implied
having the traces at the various call sites

We also use tlbie* from assembly (like the one called by kvmppc_hv_entry),
which is not covered by these traces at the moment, but I guess we can
add them as well.

> Also in some of them you call trace_tlbie() before the
> eieio/tlbsync/ptesync. Which may not be wrong, but looks worrying at
> first glance.
> 

I'll try and make it consistent, but there are places like do_tlbies()
where we loop do the tlbie(l)'s and then do sync's. In those case
I've had to put the traces within the loop instead of queuing or looping
twice. We don't access any of the addresses flushed, just print the registers.

> But overall I guess it's OK. We'd want to do a quick benchmark to make
> sure it's not adding any overhead.

OK.. I'll try and find a benchmark and run it with traces disabled.

Thanks for the review
Balbir Singh
