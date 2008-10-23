Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C1BADDEF4
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 15:44:20 +1100 (EST)
Subject: Re: [patch] mutex: optimise generic mutex implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20081022155923.GM23060@elte.hu>
References: <20081012054634.GA12535@wotan.suse.de>
	<20081022155923.GM23060@elte.hu>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 15:43:58 +1100
Message-Id: <1224737038.7654.385.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, paulus@samba.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-22 at 17:59 +0200, Ingo Molnar wrote:
> * Nick Piggin <npiggin@suse.de> wrote:
> 
> > Speed up generic mutex implementations.
> > 
> > - atomic operations which both modify the variable and return something imply
> >   full smp memory barriers before and after the memory operations involved
> >   (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
> >   they don't modify the target). See Documentation/atomic_ops.txt.
> >   So remove extra barriers and branches.
> >   
> > - All architectures support atomic_cmpxchg. This has no relation to
> >   __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally
> > 
> > This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
> > to 203 cycles on a ppc970 system.
> > 
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> no objections here. Lets merge these two patches via the ppc tree, so 
> that it gets testing on real hardware as well?
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Allright but in that case it will be after -rc1 unless I manage to sneak
something in tomorrow before linux closes the merge window.

I can't get an update today.

Cheers,
Ben.
