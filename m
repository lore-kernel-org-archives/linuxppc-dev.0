Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 611BEDE20A
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 04:40:10 +1100 (EST)
Date: Sat, 11 Oct 2008 02:40:03 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
Message-ID: <20081010174003.GC10579@linux-sh.org>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
	<48EED4D1.2040506@billgatliff.com>
	<Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
	<48EF5FAC.1060807@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48EF5FAC.1060807@billgatliff.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linux-embedded@vger.kernel.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 08:59:08AM -0500, Bill Gatliff wrote:
> There isn't a lot of traffic on linux-embedded, and I'm not sure how many people
> who read linux-arm-kernel also read linuxppc-dev.  Lkml's topic coverage is
> huge, so I don't know how many hardcore embedded developers I would encounter
> there.  I was hoping for a round of feedback at a lower level before pushing
> anything upstream like that.
> 
This isn't your problem. If people are interested in general embedded
topics, they should be subscribed to the list. If they aren't, it's their
loss. Cross posting to every potentially relevant list is a complete
waste of time, and only helps to split out the discussion so nothing
actually gets accomplished in a centralized location.

> Hasn't been a problem so far.  I posted the first version of the code on l-a-k,
> and got some feedback on the pwm_device API and a lot of feedback on the way
> users wanted to use the API to realize applications.  I incorporated all of it,
> and in this "release" I broadened the exposure per recommendations received from
> l-a-k.
> 
This is precisely the problem. Stuff that gets "reviewed" on
linux-arm-kernel gets reviewed for ARM only. There has been way too much
crap that has been pushed into the kernel under the guise of being
generic and "reviewed" that has broken _every_ architecture _except_ ARM.
If you want to refute this, go look at the recent fiasco with musb, which
still hasn't been solved properly, primarily because the ARM people
couldn't be bothered using grep. This crap happens all the time, because
stuff is reviewed and merged in private, and the only time anyone else
notices is when their platform suddenly stops building.

Your first version should have been to linux-embedded and linux-kernel.
If you want to alert the linux-arm-kernel people to the fact that a
discussion is going on in this area, then feel free to post a
notification to the list with references to the relevant lists. There is
no reason why public lists should have to dig in to private archives to
try and play catch up.

> So, you're saying the same thing as me, basically.  But leaving out the lists
> with very high ratios of device-specific domain knowledge, which is important
> for the backend parts of what I'm proposing.  Blackfin's PWM-capable peripherals
> work differently from those commonly found in ARM and PPC, for example.  I
> haven't run anything by the MIPS or AVR guys, but I'm guessing they would have
> something to add, too.
> 
> I'm beginning to appreciate what everyone must have had to deal with for GPIO.  :)
> 
The GPIO mess was broken in different ways, which we're still trying to
fix today. The GPIO discussion did happen out on public lists though, so
all of the discussion on that was visible, even if the end result left
something to be desired.

If you're trying to pitch a generic API and doing your review on a
private list, you've already lost. If you're talking about things that
only effect arch/arm, feel free to do whatever you want. As soon as you
step outside of that structure, you have to follow common convention, or
you risk breaking things all over the place. I can't remember the last
time I saw a "generic" API reviewed on linux-arm-kernel that didn't end
up breaking every other architecture in existence. This is true for
drivers, also. Better yet, don't bother dropping the ARM depedency until
you've posted to a public list.

Some of us are pretty damn tired of cleaning up after the ARM people.
