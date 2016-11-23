Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNys010DkzDw0W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 21:15:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC] [PATCH] Trace TLBIE's
In-Reply-To: <3dcd0c76-46fd-cb7a-945d-4b5a679fa544@gmail.com>
References: <3dcd0c76-46fd-cb7a-945d-4b5a679fa544@gmail.com>
Date: Wed, 23 Nov 2016 21:15:30 +1100
Message-ID: <87polmtscd.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> Just a quick patch to trace tlbie(l)'s. The idea being that it can be
> enabled when we suspect corruption or when we need to see if we are doing
> the right thing during flush. I think the format can be enhanced to
> make it nicer (expand the RB/RS/IS/L cases in more detail). For now I am
> sharing the idea to get inputs
>
> A typical trace might look like this
>
>
> <...>-5141  [062]  1354.486693: tlbie:                
> 	tlbie with lpid 0, local 0, rb=7b5d0ff874f11f1, rs=0, ric=0 prs=0 r=0
> systemd-udevd-2584  [018]  1354.486772: tlbie:
> 	tlbie with lpid 0, local 0, rb=17be1f421adc10c1, rs=0, ric=0 prs=0 r=0
> ...
>
> qemu-system-ppc-5371  [016]  1412.369519: tlbie:
> 	tlbie with lpid 0, local 1, rb=67bd8900174c11c1, rs=0, ric=0 prs=0 r=0
> qemu-system-ppc-5377  [056]  1421.687262: tlbie:
> 	tlbie with lpid 1, local 0, rb=5f04edffa00c11c1, rs=1, ric=0 prs=0 r=0

My first reaction is "why the hell do we have so many open-coded
tlbies". So step one might be to add a static inline helper, that way we
don't have to add the trace_tlbie() in so many places.

Also in some of them you call trace_tlbie() before the
eieio/tlbsync/ptesync. Which may not be wrong, but looks worrying at
first glance.

But overall I guess it's OK. We'd want to do a quick benchmark to make
sure it's not adding any overhead.

cheers
