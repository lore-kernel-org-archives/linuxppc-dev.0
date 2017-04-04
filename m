Return-Path: <srs0=f5xk=3m=gmail.com=linus971@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxqvc73shzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 10:43:08 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vxqvc6B5jz8sxJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 10:43:08 +1000 (AEST)
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vxqvc27SVz9s7s
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2017 10:43:08 +1000 (AEST)
Received: by mail-io0-x229.google.com with SMTP id l7so86262282ioe.3
 for <linuxppc-dev@ozlabs.org>; Mon, 03 Apr 2017 17:43:08 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170404095001.664718b8@roar.ozlabs.ibm.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
 <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
 <20170404095001.664718b8@roar.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Apr 2017 17:43:05 -0700
Message-ID: <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 3, 2017 at 4:50 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> POWER does not have an instruction like pause. We can only set current
> thread priority, and current implementations do something like allocate
> issue cycles to threads based on relative priorities. So there should
> be at least one or two issue cycles at low priority, but ideally we
> would not be changing priority in the busy-wait loop because it can
> impact other threads in the core.
>
> I couldn't think of a good way to improve cpu_relax. Our (open source)
> firmware has a cpu_relax, and it puts a bunch of nops between low and
> normal priority instructions so we get some fetch cycles at low prio.
> That isn't ideal though.
>
> If you have any ideas, I'd be open to them.

So the idea would be that maybe we can just make those things
explicit. IOW, instead of having that magical looping construct that
does other magical hidden things as part of the loop, maybe we can
just have a

   begin_cpu_relax();
   while (!cond)
       cpu_relax();
   end_cpu_relax();

and then architectures can decide how they implement it. So for x86,
the begin/end macros would be empty. For ppc, maybe begin/end would be
the "lower and raise priority", while cpu_relax() itself is an empty
thing.

Or maybe "begin" just clears a counter, while "cpu_relax()" does some
"increase iterations, and lower priority after X iterations", and then
"end" raises the priority again.

The "do magic having a special loop" approach disturbs me. I'd much
rather have more explicit hooks that allow people to do their own loop
semantics (including having a "return" to exit early).

But that depends on architectures having some pattern that we *can*
abstract. Would some "begin/in-loop/end" pattern like the above be
sufficient? The pure "in-loop" case we have now (ie "cpu_relax()"
clearly isn't sufficient.

I think s390 might have issues too, since they tried to have that
"cpu_relax_yield" thing (which is only used by stop_machine), and
they've tried cpu_relax_lowlatency() and other games.

                    Linus
