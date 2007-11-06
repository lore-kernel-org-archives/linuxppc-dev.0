Return-Path: <jonsmirl@gmail.com>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.177])
	by ozlabs.org (Postfix) with ESMTP id 00440DDDD5
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 04:45:26 +1100 (EST)
Received: by ro-out-1112.google.com with SMTP id p7so2662634roc
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 09:45:25 -0800 (PST)
Message-ID: <9e4733910711060945t35284f8atb36c0d6ed35abf71@mail.gmail.com>
Date: Tue, 6 Nov 2007 12:45:24 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <20071106182953.3c1a57e3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<20071106182953.3c1a57e3@hyperion.delvare>
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

On 11/6/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Scott, Jon,
>
> On Mon, 05 Nov 2007 14:51:51 -0600, Scott Wood wrote:
> > Jon Smirl wrote:
> > > How about renaming the old driver file and leaving it hooked to ppc?
> > > Then it would get deleted when ppc goes away. That would let work
> > > progress on the powerpc version.
> >
> > Or we could have one driver that has two probe methods.  I don't like
> > forking the driver.
>
> I agree with Scott here, I don't want to fork the drivers. It is
> possible (and easy) to support both methods in the same module, let's
> just to that. See for example David Brownell's work on the lm75 driver:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021270.html

I agree that it is easy to make make a chip driver support both new
and old style.

But when I call i2c_new_device() on an old style chip driver it exits
saying that it doesn't work for the old style adapters. Checks for
is_newstyle_driver() are in the i2c_new_device code. That's what
caused me to rewrite the rtc-pcf8563 driver for the new style. This
probably related to probing, I have to pass the address in struct
i2c_board_info. The old style drivers don't support having their
address passed in.

This may be complicated by the fact that the rtc drivers I'm working
on are not probable. That's why I want to add device tree support for
them.

If this is going to work on an old style driver, how do I get the address to it?

-- 
Jon Smirl
jonsmirl@gmail.com
