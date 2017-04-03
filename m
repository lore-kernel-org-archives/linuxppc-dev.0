Return-Path: <srs0=pbdl=3l=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxpkj2rxjzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 09:50:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vxpkj2H3gz8t6N
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 09:50:21 +1000 (AEST)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vxpkh5tM9z9s7q
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2017 09:50:20 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so33057801pgf.0
 for <linuxppc-dev@ozlabs.org>; Mon, 03 Apr 2017 16:50:20 -0700 (PDT)
Date: Tue, 4 Apr 2017 09:50:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard
 <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170404095001.664718b8@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
 <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
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

On Mon, 3 Apr 2017 08:31:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 3, 2017 at 1:13 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > The loops have some restrictions on what can be used, but they are
> > intended to be small and simple so it's not generally a problem:
> >  - Don't use cpu_relax.
> >  - Don't use return or goto.
> >  - Don't use sleeping or spinning primitives.  
> 
> So you're supposed to "break" out of the loop if you want to exit
> early? Or what?

Yes, break (I put that as a comment somewhere).

> One of the issues is that with a do-while/until loop, at least the way
> you've coded it, it's always done at least once.
> 
> Which means that people will have to code the condition as
> 
>     if (cond) {
>         .. fast case..
>         return;
>     }
> 
>     spin_do {
>        ...
>     } spin_until (cond);
>     .. slow case ..
> 
> because "cpu_relax()" itself can be slightly slow.
> 
> And the way you've done it, even if there's a "break" in the loop, the
> cpu_relax() is still done (because it's done at the top).
> 
> So quite frankly, I think "while(cond) ()" semantics would be better
> than "do { } while (cond)".
> 
> Now, a lot of loops *are* of the kind where we've already handled the
> fast case earlier, so by the time we get into the loop we really are
> waiting for the condition to become true (but we knew it started out
> false). But not all.

Yeah that's a good point, I see what you mean. The important cases I've
been looked at (e.g., mutex spinning, bit spinlock, idle loops) are the
slowpath cases. But this would need to be explicit in the API so fastpaths
don't use it.

> Doing a quick
> 
>     git grep -2 cpu_relax
> 
> for existing users of cpu_relax() does imply that most of the current
> users are very much of the "cpu_relax() at the _end_ of the loop
> tests" type.
> 
> So I don't know. I think the interface sucks.

It's a bit clunky.

> What is it that POWER _actually_ wants? Not the loop - the
> "cpu_relax()" kind of thing. Can we abstract *that* better?

POWER does not have an instruction like pause. We can only set current
thread priority, and current implementations do something like allocate
issue cycles to threads based on relative priorities. So there should
be at least one or two issue cycles at low priority, but ideally we
would not be changing priority in the busy-wait loop because it can
impact other threads in the core.

I couldn't think of a good way to improve cpu_relax. Our (open source)
firmware has a cpu_relax, and it puts a bunch of nops between low and
normal priority instructions so we get some fetch cycles at low prio.
That isn't ideal though.

If you have any ideas, I'd be open to them.

I had a secondary motive for defining it as a loop, and that was using
branch hints or even asm goto to arrange the loop and exit branch
nicely. E.g., if we static predict loop exits, then we don't take a
branch miss as first thing when condition changes. This is a second
order concern though.

Thanks,
Nick
