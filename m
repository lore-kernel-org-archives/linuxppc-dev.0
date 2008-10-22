Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77ED1DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 02:59:38 +1100 (EST)
Date: Wed, 22 Oct 2008 17:59:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] mutex: optimise generic mutex implementations
Message-ID: <20081022155923.GM23060@elte.hu>
References: <20081012054634.GA12535@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081012054634.GA12535@wotan.suse.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Nick Piggin <npiggin@suse.de> wrote:

> Speed up generic mutex implementations.
> 
> - atomic operations which both modify the variable and return something imply
>   full smp memory barriers before and after the memory operations involved
>   (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
>   they don't modify the target). See Documentation/atomic_ops.txt.
>   So remove extra barriers and branches.
>   
> - All architectures support atomic_cmpxchg. This has no relation to
>   __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally
> 
> This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
> to 203 cycles on a ppc970 system.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>

no objections here. Lets merge these two patches via the ppc tree, so 
that it gets testing on real hardware as well?

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
