Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28A5BDE092
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 22:04:22 +1000 (EST)
Date: Wed, 22 Apr 2009 14:04:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
Message-ID: <20090422140401.04a402e9@hyperion.delvare>
In-Reply-To: <18926.58544.374626.696097@cargo.ozlabs.ibm.com>
References: <20090420225659.7b92a184@hyperion.delvare>
	<18924.63578.495727.152443@cargo.ozlabs.ibm.com>
	<s5hzleah5x4.wl%tiwai@suse.de>
	<20090421114853.7a9d82c1@hyperion.delvare>
	<18926.58544.374626.696097@cargo.ozlabs.ibm.com>
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

On Wed, 22 Apr 2009 19:34:40 +1000, Paul Mackerras wrote:
> Jean Delvare writes:
> 
> > Not removing it now has a high risk of developers continuing to ignore
> > the deprecation warnings and adding new legacy drivers, which I then
> > must convert to the new model. This never ends.
> > 
> > I know my behavior may seem a bit rude, but apparently this is the only
> > way to get things to actually happen. I've been waiting for over a year
> > already!
> 
> I sympathize, but throwing disruptive changes into Linus' tree when
> we're past -rc3 is not the way to solve the problem.

We're past -rc3 because people discuss instead of testing my patches.
Otherwise everything would be merged already.

And really, these changes (sound drivers) don't qualify as disruptive.
You might argue about the thermal management driver changes if you
want. But sound drivers, nothing bad will happen if they accidentally
break.

> The way to solve the problem is to (a) publish a branch where you put
> the stuff you're going to ask Linus to pull in the next merge window,
> (b) push a commit there that removes the legacy interfaces, (c) ask
> Stephen Rothwell to include that branch in linux-next.
> 
> The linux-next tree gets built for a wide range of architectures and
> configs, and any breakages get noticed and fixed pretty quickly.
> Getting the removal of the legacy interfaces into linux-next will do
> more in a week than a year's worth of deprecation warnings. :)

What do you think, that I don't know about linux-next? My i2c tree is
already there. It has been since linux-next exists.

But linux-next will only build-test the code. That I have already done,
so it really doesn't buy my anything. Developers (including me) don't
look at warnings in linux-next, and I don't think linux-next gets a lot
of testing.

Also, I can't push all untested patches to linux-next. In particular
the 4 patches that touch thermal management on powermac, need to be
tested successfully by at least one person before I can push them. You
did test the therm_pm72 patch, and I thank you for that, so that one is
in linux-next, but the other 3 ones need testing.

So, really, you're trying to solve the wrong problem. Whether the
patches go to Linus now or in the next merge window, doesn't really
matter. What matters is that the patches can't go anywhere before they
have been tested. So, can the powerpc people please test my
patches? You (powerpc developers, not you Paul in particular) didn't
pay attention to the deprecation warnings. I did warn Ben that this
would become a problem during the Kernel Summit last year in Portland
though, but apparently it did not help. I would expect that you at
least help me with testing once I have done all the conversion work.

Out of the 10 remaining legacy i2c drivers, 9 are powerpc drivers!

> > I don't think the risk is that high, at least not for sound drivers.
> > The conversions are fairly easy and if something really went wrong,
> > fixing it is a matter of minutes.
> 
> We're past -rc3 now.  This is not the time for pushing this sort of
> change into Linus' tree.  Ask Linus if you don't believe me.

And 2.6.31 isn't the kernel to remove an interface which was scheduled
for removal in 2.6.29 and then 2.6.30 and which is blocking the
development of features people need badly. One of these two events will
happen still. The real world isn't as perfect as we'd like.

So, once again, can powermac developers/users please test my patches?

Thanks,
-- 
Jean Delvare
