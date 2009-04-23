Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A526DE0F0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 19:55:09 +1000 (EST)
Date: Thu, 23 Apr 2009 11:54:51 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
Message-ID: <20090423115451.70d5cb2e@hyperion.delvare>
In-Reply-To: <18927.5140.888171.141615@cargo.ozlabs.ibm.com>
References: <20090420225659.7b92a184@hyperion.delvare>
	<18924.63578.495727.152443@cargo.ozlabs.ibm.com>
	<s5hzleah5x4.wl%tiwai@suse.de>
	<20090421114853.7a9d82c1@hyperion.delvare>
	<18926.58544.374626.696097@cargo.ozlabs.ibm.com>
	<20090422140401.04a402e9@hyperion.delvare>
	<18927.5140.888171.141615@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

On Wed, 22 Apr 2009 22:56:52 +1000, Paul Mackerras wrote:
> Jean Delvare writes:
> > We're past -rc3 because people discuss instead of testing my patches.
> > Otherwise everything would be merged already.
> 
> Well, no.  The first conversion patch that I saw was posted after the
> merge window had already closed, on 8 April.

I had the hope that the developers/maintainers involved would not
ignore the warnings and had patches ready, that would go to Linus
during the merge window. This didn't happen, call me naive if you want.
So right after rc1 I started working on the conversion myself. 

> > And really, these changes (sound drivers) don't qualify as disruptive.
> > You might argue about the thermal management driver changes if you
> > want. But sound drivers, nothing bad will happen if they accidentally
> > break.
> 
> That's what we call a "regression". :)

Regressions happen all the time, no matter how hard we all try to avoid
them. As long as they are fixed before -final, this isn't a big problem
though.

> > But linux-next will only build-test the code. That I have already done,
> > so it really doesn't buy my anything. Developers (including me) don't
> > look at warnings in linux-next, and I don't think linux-next gets a lot
> > of testing.
> 
> If you remove the legacy interfaces then even a build test will point
> out the drivers that still need to be converted. :)

I don't consider breaking the linux-next build a good practice, sorry.
I suspect this tree doesn't get a lot of testing, breaking it isn't
going to improve the situation. Not to mention that this will make
Stephen's life harder, which isn't my goal. I do have a list of drivers
that aren't yet converted upstream, I don't need linux-next to tell me.
Except for new drivers, of course, there I agree your strategy has
value (but has a flaw, see below.)

> > Also, I can't push all untested patches to linux-next. In particular
> > the 4 patches that touch thermal management on powermac, need to be
> > tested successfully by at least one person before I can push them. You
> > did test the therm_pm72 patch, and I thank you for that, so that one is
> > in linux-next, but the other 3 ones need testing.
> > 
> > So, really, you're trying to solve the wrong problem. Whether the
> > patches go to Linus now or in the next merge window, doesn't really
> > matter.
> 
> It does matter, actually.
> 
> > And 2.6.31 isn't the kernel to remove an interface which was scheduled
> > for removal in 2.6.29 and then 2.6.30 and which is blocking the
> > development of features people need badly.
> 
> What's so special about 2.6.30 that it matters whether the legacy
> interfaces are still there or not?

3 months ago, people told me "what's so special about 2.6.29". The
result is that we made very little progress and the legacy interface
was still used by 10 (non-staging) drivers in 2.6.30-rc1. There's
nothing special about 2.6.30 other than the fact that I am fed up
waiting for all drivers to drop using a deprecated API so that I can
remove it. Again, further i2c developments are blocked by the existence
of this deprecated API.

> As for blocking development, you can remove the legacy interfaces
> today in your next branch and get on with development immediately.

No, I can't, that would break the linux-next build, as explained above.
I would also have to include all the driver conversion patches there.
The problem is that this still touches drivers/macintosh,
drivers/media/video and sound/ppc at the moment, each of which is
supposed to be maintained in a different tree. If I include these
patches in my i2c tree, chances of collisions with other trees are big,
which means more work for Stephen. If the patches are instead included
in their respective trees (as Takashi just did for sound/ppc), you
avoid the collisions, but then I can't remove the legacy API in
linux-next, because the i2c tree is listed relatively early, so
bisecting (or just incrementally building) linux-next would fail
horribly.

So, as you can see, the problem you think is so easily solved by
linux-next, isn't. The only thing I can do at this point is keep the
patches in a local tree and point other interested developers thereto.
Basically I'll tell them "you need to use linux-next plus a number of
public patches that can't go to linux-next plus the development patches
we are discussing." This makes the work and discussions about further
developments much more difficult, and results in zero testing outside
the development group, which makes it unclear if they will be ready for
2.6.31.

Compare this with the case where all driver conversions are already in
Linus' tree (even without removing the legacy interface): I can put the
legacy interface removal and all the development patches in linux-next
and interested people can test just this, and this is build tested on
several architectures, and possibly even runtime-tested by a few random
users. This is way less work for everyone and a much better quality in
the end.

> So
> the "blocking development" argument has zero relevance to what goes
> into Linus' tree for 2.6.30.  Even if you got the legacy interfaces
> removed for 2.6.30 you still wouldn't be able to get any new features
> based on that into 2.6.30.

But I would be able to get the new features in 2.6.31. With your plan,
I doubt this can happen.

> And this is a particularly bad time to be hastily trying to get
> powermac driver changes upstream, since Ben H. is on vacation.

Yes, that I admit is pretty bad luck :(

> > So, once again, can powermac developers/users please test my patches?
> 
> Can we compromise on this?  I'll do everything I reasonably can to
> help you get the powermac driver patches tested and working before the
> 2.6.31 merge window, if you agree to leave the drivers and interfaces
> in Linus' tree as they are for 2.6.30.

"Before the 2.6.31 merge window" is way too late if I want any i2c
development to make it into 2.6.31 as well. The conversions must go in
linux-next as soon as possible. Even that isn't ideal as I explained
above, but that's the bare minimum to make sure everything (driver
conversions, interface removal and i2c developments) has a chance to be
ready for 2.6.31.

Note that I did get some more test results meanwhile. Johannes Berg
was able to test the windfarm drivers conversion, and Andreas Schwab
tested the therm_adt746x conversion, both successfully. So the only two
drivers which didn't get any testing at this point are keywest
(snd-powermac) and therm_windtunnel. That being said, more testing for
every driver is certainly welcome. You can check the current status at:
http://i2c.wiki.kernel.org/index.php/Legacy_drivers_to_be_converted

I agree to stop pushing driver conversions to Linus for 2.6.30, which
means the legacy API will stay there. Some drivers have already been
converted though (go7007 in rc3) and some conversions are scheduled to
go to Linus already (sound drivers in rc4, Takashi said.) This means 7
remaining unconverted drivers in 2.6.30 (6 powermac thermal management
drivers, and ir-kbd-i2c.)

-- 
Jean Delvare
