Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 11 Jul 2003 12:34:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips
Message-ID: <20030711193435.GC17433@ip68-0-152-218.tc.ph.cox.net>
References: <20030711185050.GB17433@ip68-0-152-218.tc.ph.cox.net> <20030711191903.51587C6D82@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030711191903.51587C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 11, 2003 at 09:18:58PM +0200, Wolfgang Denk wrote:
> In message <20030711185050.GB17433@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > 2.5 untested, so that when 2.6 rolls around there is less pain for all,
> > and 2.4 tested.  This hasn't changed, and is becoming a bit more of a
> > trend even outside of the PPC world.  It's not even that hard to test
> > now, doing 'make ARCH=ppc CROSS_COMPILE=foo arch/ppc/foo/bar.o' will
> > work and is a feature of the new build system.
>
> Does not work for me; even simple core files fail to compile:
>
> -> make ARCH=ppc CROSS_COMPILE=ppc_8xx- arch/ppc/syslib/ppc8xx_pic.o
>   CC      arch/ppc/syslib/ppc8xx_pic.o
> arch/ppc/syslib/ppc8xx_pic.c:172: parse error before `irqreturn_t'
> arch/ppc/syslib/ppc8xx_pic.c:172: `request_irq' declared as function returning a function
> arch/ppc/syslib/ppc8xx_pic.c:172: warning: function declaration isn't a prototype
> arch/ppc/syslib/ppc8xx_pic.c:173: parse error before `unsigned'
> make[1]: *** [arch/ppc/syslib/ppc8xx_pic.o] Error 1
> make: *** [arch/ppc/syslib/ppc8xx_pic.o] Error 2

Are you modifying ppc8xx_pic.c ?  And yes, it does need generic updates.

> > > IIRC the last time we such discussions simply nothing  happened:  see
> > > for example to code for dp_alloc / dp_free that was submitted several
> > > times.
> >
> > google knows nothing of this, can you give a pointer into the thread
> > please?  Thanks.
>
> Sorry, I don't have that much time to go thtough  this  again.  AFAIR

You don't have time to find a pointer to a discussion?  Then I can't say
why nothing happened, but I'll wager a guess that Dan Malek didn't like
it for some reason.

> > > Or see thread "set_rtc_time() cleanup / normalization" in May
> > > this year.
> >
> > I just re-read most of it, and Gabriel Paubert, who wrote most / all of
> > that code, and is the 'maintainer' of sorts objected, a few solutions to
> > make everyone happy were proposed (ppc_md hook or similar, I believe)
> > and no further patch was submitted.
>
> IIRC there was a general disagreement - what patch do you expect then?

If there was a general disagreement (I thought the add a do or don't do
this in an interrupt flag was accepted) I can't go and apply the patch
anyhow.  That's also not something I can help you with[1].

> > As always, send things in functional hunks.  If for example, the 8xx /
> > 8260 enet and serial drivers (Of note: the 4xx enet driver now falls
> > into this catagory) in 2.6 get moved into drivers/serial (And rewritten)
>
> Please explain what "get  moved"  means.  Is  this  planned  but  not
> started  yet?  work  in  progress?  who  is  working  on  it?  who is
> discussing these things? where does such discussion take place?  I've
> seen  nothing  like  this on lkml? what must one do to participate in
> such discussions?

A hypotheical.  Not that the serial drivers shouldn't be moved to the
new serial infrastructure that'll c&p bugs...

> > least as much griping as I've made in the past, if not more.  And when
> > someone comments on the reasoning, logic, or suggests an alternate way
> > of doing things for people which need the current behavior / whatever,
> > re-spin the patch.  All of the patches you've submitted to me like this,
>
> Sorry, but  how  should  anybody  comment  before  being  faced  with
> accomplished facts?

Can you rephrase that?  What I was saying is that frequently Paul has
pointed to something done outside of the 8xx / 8260 world and asked if
we can try doing it in a different way instead, which he believes is
cleaner / better / whatever.  And since Paul is the PPC maintainer, I
(or whomever has been asked) will give it a shot, or explain why that
won't work.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
