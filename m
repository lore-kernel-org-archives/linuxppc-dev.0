Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFC4EDDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 17:03:50 +1100 (EST)
Date: Tue, 20 Nov 2007 07:03:46 +0100
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] xmon bitlock fix
Message-ID: <20071120060346.GA31514@wotan.suse.de>
References: <20071120050826.GA18332@wotan.suse.de>
	<18242.28770.6643.679177@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18242.28770.6643.679177@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 20, 2007 at 04:28:02PM +1100, Paul Mackerras wrote:
> Nick Piggin writes:
> 
> > xmon uses a bit lock spinlock but doesn't close the critical section
> > when releasing it. It doesn't seem like a big deal because it will
> > eventually break out of the lock anyway, but presumably that's only
> > in exceptional cases where some error is tolerated, while the lack of a memory
> > barrier could allow incorrect results during normal functioning operation
> > as well.
> > 
> > Convert it to use a regular spinlock instead.
> 
> I'd rather not.  The idea is that xmon is as independent as possible
> of the rest of the kernel, so that it will work even when lots of
> kernel data structures are corrupted.  If spinlocks were simple spin
> loops then maybe, but they're not these days.

Fair enough, I guess you still want lockdep kernels to work.

 
> As for the memory barrier comment, I don't think it is a reason, since
> test_and_set_bit acts as a barrier, and in any case the worst thing

test_and_set_bit is a barrier (although heavier than required to acquire
a lock). But clear_bit isn't strong enough... you do have eieio() in
there, making it probably less problem, but that won't get executed if
nb is 0, and it is still doing the xmon_init_scc() outside the loop. I
just prefer to make it a simple lock that doesn't rely on barriers or
the specific structure of the critical section.


> that could happen is that the characters from different cpu's outputs
> get interleaved (that's one reason why the loop has a timeout, the
> other is for robustness).
> 
> In any case this is in arch/ppc which is dying code.  I don't think
> there are any SMP platforms supported in arch/ppc any more except for
> some (fairly rare) PReP platforms, and I hope to get PReP moved over
> soon.
 
I was just grepping the tree, and trying to reduce code which might
be fragile, broken, or a poor example.


> Finally, why do you say that it doesn't close the critical section?
> Possibly the "locked" variable is badly named (it's zero when we get
> the lock) but AFAICS the code is actually correct.

Well the unlock itself doesn't close it properly because clear_bit
doesn't order previous loads or stores.

How about this?
---

xmon uses a bit lock spinlock but doesn't close the critical section
when releasing it. It doesn't seem like a big deal because it will
eventually break out of the lock anyway, but presumably that's only
in exceptional cases where some error is tolerated, while the lack of a memory
barrier could allow incorrect results during normal functioning operation
as well.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/ppc/xmon/start.c
===================================================================
--- linux-2.6.orig/arch/ppc/xmon/start.c
+++ linux-2.6/arch/ppc/xmon/start.c
@@ -98,7 +98,7 @@ xmon_write(void *handle, void *ptr, int 
 	int lock_wait = 1000000;
 	int locked;
 
-	while ((locked = test_and_set_bit(0, &xmon_write_lock)) != 0)
+	while ((locked = test_and_set_bit_lock(0, &xmon_write_lock)) != 0)
 		if (--lock_wait == 0)
 			break;
 #endif
@@ -124,7 +124,7 @@ xmon_write(void *handle, void *ptr, int 
 
 #ifdef CONFIG_SMP
 	if (!locked)
-		clear_bit(0, &xmon_write_lock);
+		clear_bit_unlock(0, &xmon_write_lock);
 #endif
 	return nb;
 }
