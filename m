Return-Path: <linus971@gmail.com>
Received: from mail-vc0-x231.google.com (mail-vc0-x231.google.com
 [IPv6:2607:f8b0:400c:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E21F2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 10:56:19 +1000 (EST)
Received: by mail-vc0-f177.google.com with SMTP id hv10so4296844vcb.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 17:56:15 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <23118.1380587771@ale.ozlabs.ibm.com>
References: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
 <1380581522.6396.20.camel@pasglop>
 <23118.1380587771@ale.ozlabs.ibm.com>
Date: Mon, 30 Sep 2013 17:56:15 -0700
Message-ID: <CA+55aFwi5sZK4mFxs3PT1wU4_vNzsLOFiocqi3g14fPamKXYsw@mail.gmail.com>
Subject: Re: Avoiding the dentry d_lock on final dput(), part deux:
 transactional memory
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: Waiman Long <Waiman.Long@hp.com>, Peter Zijlstra <peterz@infradead.org>,
 George Spelvin <linux@horizon.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chandramouleeswaran,
 Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 30, 2013 at 5:36 PM, Michael Neuling <mikey@neuling.org> wrote:
>
> The scary part is that we to make all register volatile.  You were not
> that keen on doing this as there are a lot of places in exception
> entry/exit where we only save/restore a subset of the registers.  We'd
> need to catch all these.

Ugh. It's very possible it's not worth using for the kernel then. The
example I posted is normally fine *without* any transactional support,
since it's a very local per-dentry lock, and since we only take that
lock when the last reference drops (so it's not some common directory
dentry, it's a end-point file dentry). In fact, on ARM they just made
the cmpxchg much faster by making it entirely non-serializing (since
it only updates a reference count, there is no locking involved apart
from checking that the lock state is unlocked)

So there is basically never any contention, and the transaction needs
to basically be pretty much the same cost as a "cmpxchg". It's not
clear if the intel TSX is good enough for that, and if you have to
save a lot of registers in order to use transactions on POWER8, I
doubt it's worthwhile.

We have very few - if any - locks where contention or even cache
bouncing is common or normal. Sure, we have a few particular loads
that can trigger it, but even that is becoming rare. So from a
performance standpoint, the target always needs to be "comparable to
hot spinlock in local cache".

>> They also have interesting ordering semantics vs. locks, we need to be
>> a tad careful (as long as we don't access a lock variable
>> transactionally we should be ok. If we do, then spin_unlock needs a
>> stronger barrier).
>
> Yep.

Well, just about any kernel transaction will at least read the state
of a lock. Without that, it's generally totally useless. My dput()
example sequence very much verified that the lock was not held, for
example.

I'm not sure how that affects anything. The actual transaction had
better not be visible inside the locked region (ie as far as any lock
users go, transactions better all happen fully before or after the
lock, if they read the lock and see it being unlocked).

That said, I cannot see how POWER8 could possibly violate that rule.
The whole "transactions are atomic" is kind of the whole and only
point of a transaction. So I'm not sure what odd lock restrictions
POWER8 could have.

> FWIW eg.
>
>      tbegin
>      beq abort /* passes first time through */
>      ....
>      transactional stuff
>      ....
>      tend
>      b pass
>
> abort:
>
> pass:

That's fine, and matches the x86 semantics fairly closely, except
"xbegin" kind of "contains" that "jump to abort address". But we could
definitely use the same models. Call it
"transaction_begin/abort/end()", and it should be architecture-neutral
naming-wise.

Of course, if tbegin then acts basically like some crazy
assembly-level setjmp (I'm guessing it does exactly, and presumably
precisely that kind of compiler support - ie a function with
"__attribute((returns_twice))" in gcc-speak), the overhead of doing it
may kill it.

            Linus
