Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 73A29681E8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Sep 2005 07:07:55 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 69so1022772wri
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Sep 2005 14:07:53 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 9 Sep 2005 00:08:39 +0300
References: <1729b6f2a199a759c4daeadd3ddcdc4a@freescale.com>
In-Reply-To: <1729b6f2a199a759c4daeadd3ddcdc4a@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509090008.39692.pantelis.antoniou@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: cpu features testing 32 vs 64 bit
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 09 September 2005 00:02, Becky Bruce wrote:
> So,
>
> in include/asm-ppc64/cacheflush.h is the following:
>
> static inline void flush_icache_range(unsigned long start, unsigned
> long stop)
> {
>          if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>                  __flush_icache_range(start, stop);
> }
>
> On the 32-bit side, we don't need the feature test -
> CPU_FTR_COHERENT_CACHE is only defined in 64-bit land, and has bits set
> in the upper 32.
>

Oh yes we need it. 8xx is non coherent.

> There's a couple of ways to deal with merging this:
>
> 1) The ever-so-popular #ifdef __powerpc64__around the cpu_has_feature
> test
> 2) No ifdef in the code itself, but #define CPU_FTR_WHATEVER to be 0
> when !__powerpc64__ in cputable.h so that the cpu_has_feature test will
> always fail for 32-bit.
>
> I'd like to get some opinions on this.  Do folks feel like the
> performance hit of doing the compare is enough to justify going with
> method 1?  Should we be using likely/unlikely with the feature test?
>
> This is just one code example - I suspect there will be others as we
> continue the merge, and the importance of performance may differ
> depending on where in the code we are.
>
> Thanks!
> -B
>

Regards

Pantelis
