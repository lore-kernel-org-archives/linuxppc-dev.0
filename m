Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzBvr6zG6zDqKk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 16:03:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC] [PATCH] Trace TLBIE's
In-Reply-To: <2637022.69IxkT9g0N@new-mexico>
References: <3dcd0c76-46fd-cb7a-945d-4b5a679fa544@gmail.com>
 <87polmtscd.fsf@concordia.ellerman.id.au>
 <8a496713-bc00-6520-b715-481de507363e@gmail.com>
 <2637022.69IxkT9g0N@new-mexico>
Date: Thu, 06 Apr 2017 16:03:04 +1000
Message-ID: <8760iiul7r.fsf@concordia.ellerman.id.au>
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

Alistair Popple <alistair@popple.id.au> writes:

> On Wed, 23 Nov 2016 10:40:36 PM Balbir Singh wrote:
>>
>> > But overall I guess it's OK. We'd want to do a quick benchmark to make
>> > sure it's not adding any overhead.
>>
>> OK.. I'll try and find a benchmark and run it with traces disabled.
>
> For what's it's worth I didn't notice any slow down running a NAMD
> test with tracing disabled and ~400000 tlbie's in 34s. Turning tracing
> on could have slowed things down ever so slightly, but I didn't notice
> as it may have just been in the noise of the benchmark I was running
> (I wasn't specifically looking at timing, hence the vagueness of the
> remarks).
>
> Otherwise the patch worked and would be useful - I have already had to
> setup tlbie counting/tracing several times in the last 12 months.
>
> Tested-by: Alistair Popple <alistair@popple.id.au>

OK thanks.

To get it merged I'd like:
 - always called after the barriers.
 - no calls in loops, instead add a "count" field to the trace point and
   when we call it multiple times in a loop we pass the count.

So you'd see entries something like:

<...>-5141  [062]  1354.486693: tlbie: lpid=0, local=1, rb=0x7b5d0ff874f11f1, rs=0, ric=0, prs=0, r=0, count=128

cheers
