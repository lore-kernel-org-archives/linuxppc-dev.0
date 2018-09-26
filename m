Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kxfb4vvTzF3Jl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 22:13:11 +1000 (AEST)
In-Reply-To: <20180925093647.23723-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 aneesh.kumar@linux.vnet.ibm.com, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/tm: Avoid possible userspace r1 corruption on reclaim
Message-Id: <42Kxfb3P3Pz9s5c@ozlabs.org>
Date: Wed, 26 Sep 2018 22:13:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-09-25 at 09:36:47 UTC, Michael Neuling wrote:
> Current we store the userspace r1 to PACATMSCRATCH before finally
> saving it to the thread struct.
> 
> In theory an exception could be taken here (like a machine check or
> SLB miss) that could write PACATMSCRATCH and hence corrupt the
> userspace r1. The SLB fault currently doesn't touch PACATMSCRATCH, but
> others do.
> 
> We've never actually seen this happen but it's theoretically
> possible. Either way, the code is fragile as it is.
> 
> This patch saves r1 to the kernel stack (which can't fault) before we
> turn MSR[RI] back on. PACATMSCRATCH is still used but only with
> MSR[RI] off. We then copy r1 from the kernel stack to the thread
> struct once we have MSR[RI] back on.
> 
> Suggested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/96dc89d526ef77604376f06220e3d2

cheers
