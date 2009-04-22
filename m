Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1BDFDE03F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:53:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18926.58544.374626.696097@cargo.ozlabs.ibm.com>
Date: Wed, 22 Apr 2009 19:34:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
In-Reply-To: <20090421114853.7a9d82c1@hyperion.delvare>
References: <20090420225659.7b92a184@hyperion.delvare>
	<18924.63578.495727.152443@cargo.ozlabs.ibm.com>
	<s5hzleah5x4.wl%tiwai@suse.de>
	<20090421114853.7a9d82c1@hyperion.delvare>
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

> Not removing it now has a high risk of developers continuing to ignore
> the deprecation warnings and adding new legacy drivers, which I then
> must convert to the new model. This never ends.
> 
> I know my behavior may seem a bit rude, but apparently this is the only
> way to get things to actually happen. I've been waiting for over a year
> already!

I sympathize, but throwing disruptive changes into Linus' tree when
we're past -rc3 is not the way to solve the problem.

The way to solve the problem is to (a) publish a branch where you put
the stuff you're going to ask Linus to pull in the next merge window,
(b) push a commit there that removes the legacy interfaces, (c) ask
Stephen Rothwell to include that branch in linux-next.

The linux-next tree gets built for a wide range of architectures and
configs, and any breakages get noticed and fixed pretty quickly.
Getting the removal of the legacy interfaces into linux-next will do
more in a week than a year's worth of deprecation warnings. :)

> I don't think the risk is that high, at least not for sound drivers.
> The conversions are fairly easy and if something really went wrong,
> fixing it is a matter of minutes.

We're past -rc3 now.  This is not the time for pushing this sort of
change into Linus' tree.  Ask Linus if you don't believe me.

> I have converted all remaining drivers by now:
> http://i2c.wiki.kernel.org/index.php/Legacy_drivers_to_be_converted
> It's really only a matter of getting them tested in time now. Given
> that most drivers are powermac ones, what I really need here is
> powermac users/maintainers to test my patches and report success or
> failure.

OK, but please work in your next branch and linux-next, not Linus'
tree.

Paul.
