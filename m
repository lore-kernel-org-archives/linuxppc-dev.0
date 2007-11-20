Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18242.28770.6643.679177@cargo.ozlabs.ibm.com>
Date: Tue, 20 Nov 2007 16:28:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] xmon bitlock fix
In-Reply-To: <20071120050826.GA18332@wotan.suse.de>
References: <20071120050826.GA18332@wotan.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin writes:

> xmon uses a bit lock spinlock but doesn't close the critical section
> when releasing it. It doesn't seem like a big deal because it will
> eventually break out of the lock anyway, but presumably that's only
> in exceptional cases where some error is tolerated, while the lack of a memory
> barrier could allow incorrect results during normal functioning operation
> as well.
> 
> Convert it to use a regular spinlock instead.

I'd rather not.  The idea is that xmon is as independent as possible
of the rest of the kernel, so that it will work even when lots of
kernel data structures are corrupted.  If spinlocks were simple spin
loops then maybe, but they're not these days.

As for the memory barrier comment, I don't think it is a reason, since
test_and_set_bit acts as a barrier, and in any case the worst thing
that could happen is that the characters from different cpu's outputs
get interleaved (that's one reason why the loop has a timeout, the
other is for robustness).

In any case this is in arch/ppc which is dying code.  I don't think
there are any SMP platforms supported in arch/ppc any more except for
some (fairly rare) PReP platforms, and I hope to get PReP moved over
soon.

Finally, why do you say that it doesn't close the critical section?
Possibly the "locked" variable is badly named (it's zero when we get
the lock) but AFAICS the code is actually correct.

Paul.
