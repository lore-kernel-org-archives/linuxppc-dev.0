Return-Path: <linus971@gmail.com>
Received: from mail-vc0-x22d.google.com (mail-vc0-x22d.google.com
 [IPv6:2607:f8b0:400c:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1E5F2C00CB
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 05:08:19 +1100 (EST)
Received: by mail-vc0-f173.google.com with SMTP id lh4so4034374vcb.4
 for <linuxppc-dev@ozlabs.org>; Sun, 03 Nov 2013 10:08:15 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20131103151704.GJ19466@laptop.lan>
References: <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <20131031064015.GV4126@linux.vnet.ibm.com>
 <20131101145634.GH19466@laptop.lan>
 <20131102173239.GB3947@linux.vnet.ibm.com>
 <20131103144017.GA25118@linux.vnet.ibm.com>
 <20131103151704.GJ19466@laptop.lan>
Date: Sun, 3 Nov 2013 10:08:14 -0800
Message-ID: <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 3, 2013 at 7:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Nov 03, 2013 at 06:40:17AM -0800, Paul E. McKenney wrote:
>> If there was an smp_tmb(), I would likely use it in rcu_assign_pointer().
>
> Well, I'm obviously all for introducing this new barrier, for it will
> reduce a full mfence on x86 to a compiler barrier. And ppc can use
> lwsync as opposed to sync afaict. Not sure ARM can do better.
>
> ---
> Subject: arch: Introduce new TSO memory barrier smp_tmb()

This is specialized enough that I would *really* like the name to be
more descriptive. Compare to the special "smp_read_barrier_depends()"
maco: it's unusual, and it has very specific semantics, so it gets a
long and descriptive name.

Memory ordering is subtle enough without then using names that are
subtle in themselves. mb/rmb/wmb are conceptually pretty simple
operations, and very basic when talking about memory ordering.
"acquire" and "release" are less simple, but have descriptive names
and have very specific uses in locking.

In contrast "smp_tmb()" is a *horrible* name, because TSO is a
description of the memory ordering, not of a particular barrier. It's
also not even clear that you can have a "tso barrier", since the
ordering (like acquire/release) presumably is really about one
particular *store*, not about some kind of barrier between different
operations.

So please describe exactly what the semantics that barrier has, and
then name the barrier that way.

I assume that in this particular case, the semantics RCU wants is
"write barrier, and no preceding reads can move past this point".

Calling that "smp_tmb()" is f*cking insane, imnsho.

              Linus
