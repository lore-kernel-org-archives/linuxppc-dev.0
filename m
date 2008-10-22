Return-Path: <dhowells@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id E36E9474C1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 03:24:55 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20081012054634.GA12535@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] mutex: optimise generic mutex implementations
Date: Wed, 22 Oct 2008 17:24:28 +0100
Message-ID: <22459.1224692668@redhat.com>
Sender: dhowells@redhat.com
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin <npiggin@suse.de> wrote:

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

This seems to work on FRV which uses the mutex-dec generic algorithm, though
you have to take that with a pinch of salt as I don't have SMP hardware for
it.

Acked-by: David Howells <dhowells@redhat.com>
