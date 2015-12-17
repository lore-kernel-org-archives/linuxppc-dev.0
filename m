Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E7AC1A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:30 +1100 (AEDT)
In-Reply-To: <1448421919-30426-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/4] powerpc/kernel: Drop HMT_MEDIUM_PPR_DISCARD
Message-Id: <20151217115730.0BA221402A8@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-11 at 03:25:16 UTC, Michael Ellerman wrote:
> HMT_MEDIUM_PPR_DISCARD is a macro which is present at the start of most
> of our first level exception handlers. It conditionally executes a
> HMT_MEDIUM instruction, which sets the processor priority to medium.
> 
> On on modern systems, ie. Power7 and later, it is nop'ed out at boot.
> All it does is make the exception vectors more cramped, and consume 4
> bytes of icache.
> 
> On old systems it has the effect of boosting the processor priority at
> the start of exception processing. If we were previously in the idle
> loop for example, we may be at low or very low priority. This is
> desirable as we want to process the exception as fast as possible.
> 
> However looking closely at the generated code, we see that in all cases
> we execute another HMT_MEDIUM just four instructions later. With code
> patching applied, the final code on an old (Power6) system will look
> like, eg:
> 
>   c000000000000300 <data_access_pSeries>:
>   c000000000000300:	7c 42 13 78	mr	r2,r2		<-
>   c000000000000304:	7d b2 43 a6	mtsprg	2,r13
>   c000000000000308:	7d b1 42 a6	mfsprg	r13,1
>   c00000000000030c:	f9 2d 00 80	std	r9,128(r13)
>   c000000000000310:	60 00 00 00	nop
>   c000000000000314:	7c 42 13 78	mr	r2,r2		<-
> 
> So I suggest that the added code complexity of HMT_MEDIUM_PPR_DISCARD is
> not justified by the benefit of boosting the processor priority for the
> duration of four instructions, and therefore we drop it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/d6265aeaf815801ad53a95f11c

cheers
