Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A8474B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 04:21:29 +1100 (EST)
Message-ID: <4D94B810.4000107@goop.org>
Date: Thu, 31 Mar 2011 10:21:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmotm threatens ppc preemption again
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>	
	<1300665188.2402.64.camel@pasglop>	
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>	
	<1300672207.2402.205.camel@pasglop>	
	<alpine.LSU.2.00.1103201901340.7257@sister.anvils>	
	<1300674150.2402.207.camel@pasglop>	
	<20110330135332.9c322e40.akpm@linux-foundation.org>	
	<4D939B88.5020707@goop.org> <1301532729.2407.16.camel@pasglop>
In-Reply-To: <1301532729.2407.16.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2011 05:52 PM, Benjamin Herrenschmidt wrote:
> We deal with preemption already since the PTL turns into a mutex on -rt,
> so we could bring that patch into mainline. The easiest approach however
> for now would be to not do the kernel batched updates on kernel
> (solution 4), and I can sort it out later if I want to enable it.
>
> The problem is that it's hard for me to "fix" that with the current
> accessors as arch_enter_lazy_mmu_mode() don't get any argument that
> could point me to which mm is being operated on.
>
> Jeremy, I haven't had a chance to look at your patches in detail, do
> you just use those accessors or do you create new ones for batching
> kernel updates in which case powerpc could just make them do nothing ?
>
> Else, we could have one patch that adds an mm argument accross the tree,
> it shouldn't be too hard.

No, its the same accessors for both, since the need to distinguish them
hasn't really come up.  Could you put a "if (preemptable()) return;"
guard in your implementations?

Otherwise I have no objections to passing the mm in (we'll probably just
continue to ignore the arg in x86-land).

Thanks,
    J
