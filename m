Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57510DDFC6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 22:56:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18927.5140.888171.141615@cargo.ozlabs.ibm.com>
Date: Wed, 22 Apr 2009 22:56:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
In-Reply-To: <20090422140401.04a402e9@hyperion.delvare>
References: <20090420225659.7b92a184@hyperion.delvare>
	<18924.63578.495727.152443@cargo.ozlabs.ibm.com>
	<s5hzleah5x4.wl%tiwai@suse.de>
	<20090421114853.7a9d82c1@hyperion.delvare>
	<18926.58544.374626.696097@cargo.ozlabs.ibm.com>
	<20090422140401.04a402e9@hyperion.delvare>
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

Jean Delvare writes:

> > I sympathize, but throwing disruptive changes into Linus' tree when
> > we're past -rc3 is not the way to solve the problem.
> 
> We're past -rc3 because people discuss instead of testing my patches.
> Otherwise everything would be merged already.

Well, no.  The first conversion patch that I saw was posted after the
merge window had already closed, on 8 April.

> And really, these changes (sound drivers) don't qualify as disruptive.
> You might argue about the thermal management driver changes if you
> want. But sound drivers, nothing bad will happen if they accidentally
> break.

That's what we call a "regression". :)

> But linux-next will only build-test the code. That I have already done,
> so it really doesn't buy my anything. Developers (including me) don't
> look at warnings in linux-next, and I don't think linux-next gets a lot
> of testing.

If you remove the legacy interfaces then even a build test will point
out the drivers that still need to be converted. :)

> Also, I can't push all untested patches to linux-next. In particular
> the 4 patches that touch thermal management on powermac, need to be
> tested successfully by at least one person before I can push them. You
> did test the therm_pm72 patch, and I thank you for that, so that one is
> in linux-next, but the other 3 ones need testing.
> 
> So, really, you're trying to solve the wrong problem. Whether the
> patches go to Linus now or in the next merge window, doesn't really
> matter.

It does matter, actually.

> And 2.6.31 isn't the kernel to remove an interface which was scheduled
> for removal in 2.6.29 and then 2.6.30 and which is blocking the
> development of features people need badly.

What's so special about 2.6.30 that it matters whether the legacy
interfaces are still there or not?

As for blocking development, you can remove the legacy interfaces
today in your next branch and get on with development immediately.  So
the "blocking development" argument has zero relevance to what goes
into Linus' tree for 2.6.30.  Even if you got the legacy interfaces
removed for 2.6.30 you still wouldn't be able to get any new features
based on that into 2.6.30.

And this is a particularly bad time to be hastily trying to get
powermac driver changes upstream, since Ben H. is on vacation.

> So, once again, can powermac developers/users please test my patches?

Can we compromise on this?  I'll do everything I reasonably can to
help you get the powermac driver patches tested and working before the
2.6.31 merge window, if you agree to leave the drivers and interfaces
in Linus' tree as they are for 2.6.30.

Paul.
