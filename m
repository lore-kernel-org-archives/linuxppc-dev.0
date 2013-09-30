Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C699D2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 08:53:12 +1000 (EST)
Message-ID: <1380581522.6396.20.camel@pasglop>
Subject: Re: Avoiding the dentry d_lock on final dput(), part deux:
 transactional memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 Oct 2013 08:52:02 +1000
In-Reply-To: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
References: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Waiman Long <Waiman.Long@hp.com>, Peter Zijlstra <peterz@infradead.org>,
 "Norton, Scott J" <scott.norton@hp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chandramouleeswaran,
 Aswin" <aswin@hp.com>, Michael Neuling <michael.neuling@au1.ibm.com>,
 George Spelvin <linux@horizon.com>,
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

On Mon, 2013-09-30 at 12:29 -0700, Linus Torvalds wrote:
> 
> But I'm cc'ing the POWER people, because I don't know the POWER8
> interfaces, and I don't want to necessarily call this "xbegin"/"xend"
> when I actually wrap it in some helper functions.

The main problem with powerpc TM is that we need to handle interrupts
happening while in transactional state. We currently only handle that
for userspace.

Mikey, how hard would it be to detect the in-kernel TM case and just
simulate an abort in the exception entry ? (return to tbegin basically)

Transactions in kernel make me nervous because of the PC jumping around
on aborts and how easy we can get that stuff wrong :-) They also have
interesting ordering semantics vs. locks, we need to be a tad careful
(as long as we don't access a lock variable transactionally we should be
ok. If we do, then spin_unlock needs a stronger barrier).

The basic semantic for us is tbegin. [...] tend instructions. If the
transaction fails, control returns to tbegin. (can happen at any point)
which returns a CC code indicating success or failure.

Things get really complicated if you take an interrupt however, the
transaction gets into some special "suspended" state, it doesn't just
die so we need to handle things in our interrupt entry (even if it's
just to make the transaction abort cleanly) and right now we don't when
coming from kernel space.

Cheers,
Ben.
