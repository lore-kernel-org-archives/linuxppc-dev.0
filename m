Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id D641ADE0E7
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 21:00:19 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id u2so498497uge.14
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 04:00:18 -0700 (PDT)
Message-ID: <48B290BA.7060202@genesi-usa.com>
Date: Mon, 25 Aug 2008 12:00:10 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
References: <200808251131.02071.david.jander@protonic.nl>
In-Reply-To: <200808251131.02071.david.jander@protonic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

The focus has definitely been on VMX but that's not to say lower power
processors were forgotten :)

Gunnar von Boehn did some benchmarking with an assembly optimized routine,
for Cell, 603e and so on (basically the whole gamut from embedded up to
sever class IBM chips) and got some pretty good results;

http://www.powerdeveloper.org/forums/viewtopic.php?t=1426

It is definitely something that needs fixing. The generic routine in glibc
just copies words with no benefit of knowing the cache line size or any
cache block buffers in the chip, and certainly no use of cache control or
data streaming on higher end chips.

With knowledge of the right way to unroll the loops, how many copies to
do at once to try and get a burst, reducing cache usage etc. you can get
very impressive performance (as you can see, 50MB up to 78MB at the
smallest size, the basic improvement is 2x performance).

I hope that helps you a little bit. Gunnar posted code to this list not
long after. I have a copy of the "e300 optimized" routine but I thought
best he should post it here, than myself.

There is a lot of scope I think for optimizing several points (glibc,
kernel, some applications) for embedded processors which nobody is
really taking on. But, not many people want to do this kind of work..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

David Jander wrote:
> Hello,
> 
> I was wondering if there is a good replacement for GLibc memcpy() functions, 
> that doesn't have horrendous performance on embedded PowerPC processors (such 
> as Glibc has).
> 
> I did some simple benchmarks with this implementation on our custom MPC5121 
> based board (Freescale e300 core, something like a PPC603e, G2, without VMX):
> 
> ...
> unsigned long int a,b,c,d;
> unsigned long int a1,b1,c1,d1;
> ...
> while (len >= 32)
> {
>     a =  plSrc[0];
>     b =  plSrc[1];
>     c =  plSrc[2];
>     d =  plSrc[3];
>     a1 = plSrc[4];
>     b1 = plSrc[5];
>     c1 = plSrc[6];
>     d1 = plSrc[7];
>     plSrc += 8;
>     plDst[0] = a;
>     plDst[1] = b;
>     plDst[2] = c;
>     plDst[3] = d;
>     plDst[4] = a1;
>     plDst[5] = b1;
>     plDst[6] = c1;
>     plDst[7] = d1;
>     plDst += 8;
>     len -= 32;
> }
> ...
> 
> And the results are more than telling.... by linking this with LD_PRELOAD, 
> some programs get an enourmous performance boost.
> For example a small test program that copies frames into video memory (just 
> RAM) improved throughput from 13.2 MiB/s to 69.5 MiB/s.
> I have googled for this issue, but most optimized versions of memcpy() and 
> friends seem to focus on AltiVec/VMX, which this processor does not have.
> Now I am certain that most of the G2/G3 users on this list _must_ have a 
> better solution for this. Any suggestions?
> 
> Btw, the tests are done on Ubuntu/PowerPC 7.10, don't know if that matters 
> though...
> 
> Best regards,
> 
