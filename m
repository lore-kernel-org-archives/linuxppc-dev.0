Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-232-tuesday.dmz.nerim.net
	[195.5.254.232]) by ozlabs.org (Postfix) with ESMTP id 85D1BDDE20
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 04:30:01 +1100 (EST)
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id AD4D02635C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 18:29:51 +0100 (CET)
Date: Tue, 6 Nov 2007 18:29:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-ID: <20071106182953.3c1a57e3@hyperion.delvare>
In-Reply-To: <472F8267.8070106@freescale.com>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott, Jon,

On Mon, 05 Nov 2007 14:51:51 -0600, Scott Wood wrote:
> Jon Smirl wrote:
> > How about renaming the old driver file and leaving it hooked to ppc?
> > Then it would get deleted when ppc goes away. That would let work
> > progress on the powerpc version.
> 
> Or we could have one driver that has two probe methods.  I don't like 
> forking the driver.

I agree with Scott here, I don't want to fork the drivers. It is
possible (and easy) to support both methods in the same module, let's
just to that. See for example David Brownell's work on the lm75 driver:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021270.html

> > i2c_new_device() doesn't work with legacy-style client drivers.
> 
> No, but they should still work the old way.

Definitely.

> > This is not hard to do but the i2c people will have to agree. I need
> > to change the i2c_driver structure to include the additional names.
> 
> I got a fair bit of resistance from them on the topic of multiple match 
> names for i2c clients.

Really? All I said is that you were a bit late in the game because this
had been discussed before. I know that David Brownell doesn't agree
with you (he designed what we have now), but me, I am still open to
discussing the matter, especially when more people complain about the
situation every month.

> >> We might as well just use i2c_new_device() instead of messing around
> >> with bus numbers.  Note that this is technically no longer platform
> >> code, so it's harder to justify claiming the static numberspace.
> > 
> > I was allowing control of the bus number with "cell-index" and
> > i2c_add_numbered_adapter().
> > Should I get rid of this and switch to i2c_add_adapter()?
> 
> Yes.

No! If you don't call i2c_add_numbered_adapter() then new-style i2c
clients will never work on your i2c adapter.

-- 
Jean Delvare
