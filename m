Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by ozlabs.org (Postfix) with ESMTP id 8BA2CDDE33
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 05:17:56 +1100 (EST)
Date: Tue, 6 Nov 2007 19:17:54 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-ID: <20071106191754.6ad2569c@hyperion.delvare>
In-Reply-To: <9e4733910711060945t35284f8atb36c0d6ed35abf71@mail.gmail.com>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<20071106182953.3c1a57e3@hyperion.delvare>
	<9e4733910711060945t35284f8atb36c0d6ed35abf71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Tjernlund <tjernlund@tjernlund.se>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Tue, 6 Nov 2007 12:45:24 -0500, Jon Smirl wrote:
> On 11/6/07, Jean Delvare wrote:
> > I agree with Scott here, I don't want to fork the drivers. It is
> > possible (and easy) to support both methods in the same module, let's
> > just to that. See for example David Brownell's work on the lm75 driver:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021270.html
> 
> I agree that it is easy to make make a chip driver support both new
> and old style.
> 
> But when I call i2c_new_device() on an old style chip driver it exits
> saying that it doesn't work for the old style adapters. Checks for
> is_newstyle_driver() are in the i2c_new_device code. That's what
> caused me to rewrite the rtc-pcf8563 driver for the new style. This
> probably related to probing, I have to pass the address in struct
> i2c_board_info. The old style drivers don't support having their
> address passed in.

I know that. The trick is to register two struct i2c_driver (again see
the lm75 example), one old-style, one new-style. I agree it's not very
elegant, but it works. Hopefully we can get rid of the old-style one
after some time, and it allows for a smooth transition.

> This may be complicated by the fact that the rtc drivers I'm working
> on are not probable. That's why I want to add device tree support for
> them.
> 
> If this is going to work on an old style driver, how do I get the
> address to it?

Old-style drivers probe for supported chips on all possible addresses
(for the chip in question). If the chip can't be probed, then module
parameters must be used. That's not terribly convenient, and new-style
drivers are much preferred in this case.

-- 
Jean Delvare
