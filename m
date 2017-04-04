Return-Path: <srs0=bjuu=3m=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxv0r2VmxzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 13:02:52 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vxv0r1T4sz8sxT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 13:02:52 +1000 (AEST)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vxv0q4pc8z9s82
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2017 13:02:51 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g2so33862875pge.2
 for <linuxppc-dev@ozlabs.org>; Mon, 03 Apr 2017 20:02:51 -0700 (PDT)
Date: Tue, 4 Apr 2017 13:02:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard
 <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170404130233.1f45115b@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
 <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
 <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 3 Apr 2017 17:43:05 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 3, 2017 at 4:50 PM, Nicholas Piggin <npiggin@gmail.com> wrote:

> > If you have any ideas, I'd be open to them.  
> 
> So the idea would be that maybe we can just make those things
> explicit. IOW, instead of having that magical looping construct that
> does other magical hidden things as part of the loop, maybe we can
> just have a
> 
>    begin_cpu_relax();
>    while (!cond)
>        cpu_relax();
>    end_cpu_relax();
> 
> and then architectures can decide how they implement it. So for x86,
> the begin/end macros would be empty. For ppc, maybe begin/end would be
> the "lower and raise priority", while cpu_relax() itself is an empty
> thing.
> 
> Or maybe "begin" just clears a counter, while "cpu_relax()" does some
> "increase iterations, and lower priority after X iterations", and then
> "end" raises the priority again.
> 
> The "do magic having a special loop" approach disturbs me. I'd much
> rather have more explicit hooks that allow people to do their own loop
> semantics (including having a "return" to exit early).

I guess so. Users will still have to read the documentation rather than
just throw it in ad hoc because it seems like a good idea.

For example powerpc must not use any other primitives that might change
SMT priority in the idle loop. For x86 if you do too much work, the rep
; nop component becomes relatively small and you lose benefit (10 cycles
latency pre-skylake).

I would suggest keeping standalone cpu_relax() for incidental code in
drivers and things (powerpc may add some extra nops between SMT low
and SMT normal priorities to improve it a little), and this would
be used by important core code and primitives.

> But that depends on architectures having some pattern that we *can*
> abstract. Would some "begin/in-loop/end" pattern like the above be
> sufficient?

Yes. begin/in/end would be sufficient for powerpc SMT priority, and
for x86, and it looks like sparc64 too. So we could do that if you
prefer.

After this, I might look at optimizing the loop code itself (optimizing
exit condition, de-pipelining, etc). That would require spin loop
primitives like this again. BUT they would not have funny restrictions
on exit conditions because they wouldn't do SMT priority. If I get
positive numbers for that, would you be opposed to having such
primitives (just for the important core spin loops)?

> I think s390 might have issues too, since they tried to have that
> "cpu_relax_yield" thing (which is only used by stop_machine), and
> they've tried cpu_relax_lowlatency() and other games.

There are some considerations with hv/guest yielding, yes. I'm not
touching that yet, but it needs to be looked at. Generic code has no
chance of looking at primitives available and deciding which should
be best used (not least because they aren't documented).

I think for the most part, busy loops shouldn't be done if they tend
to be more expensive than a context switch + associated cache costs,
so hypervisors are okay there. It's just rare cases where we *have*
to spin. Directed spinning or yielding for a resource is possibly more
general pattern and something to look at adding to these spin APIs, but
for now they should be okay to just remain within the loop body.

Summary: hypervisor guests should not be affected by the new
APIs, but we could look at augmenting them later with some hv hints.

Thanks,
Nick
