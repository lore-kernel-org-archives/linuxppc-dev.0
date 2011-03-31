Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 945EAB6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 11:53:00 +1100 (EST)
Subject: Re: mmotm threatens ppc preemption again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <4D939B88.5020707@goop.org>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>
	<1300672207.2402.205.camel@pasglop>
	<alpine.LSU.2.00.1103201901340.7257@sister.anvils>
	<1300674150.2402.207.camel@pasglop>
	<20110330135332.9c322e40.akpm@linux-foundation.org>
	<4D939B88.5020707@goop.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 11:52:09 +1100
Message-ID: <1301532729.2407.16.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2011-03-30 at 14:07 -0700, Jeremy Fitzhardinge wrote:
> 
>    1. Change the locking rules for kernel updates to also require a pte lock
>    2. Special-case batched kernel updates to include a pte lock
>    3. Make Power deal with preemption during a batched kernel update
>    4. Never do batched kernel updates on Power
>    5. Never do batched kernel updates (the current state) 

We deal with preemption already since the PTL turns into a mutex on -rt,
so we could bring that patch into mainline. The easiest approach however
for now would be to not do the kernel batched updates on kernel
(solution 4), and I can sort it out later if I want to enable it.

The problem is that it's hard for me to "fix" that with the current
accessors as arch_enter_lazy_mmu_mode() don't get any argument that
could point me to which mm is being operated on.

Jeremy, I haven't had a chance to look at your patches in detail, do
you just use those accessors or do you create new ones for batching
kernel updates in which case powerpc could just make them do nothing ?

Else, we could have one patch that adds an mm argument accross the tree,
it shouldn't be too hard.

Later on, I can bring in the stuff from -rt stuff to enable lazy
batching of kernel pages on power if I wish to do so.

Cheers,
Ben
