Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-105-friday.nerim.net [62.4.16.105])
	by ozlabs.org (Postfix) with ESMTP id 85756DE12B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:31:23 +1000 (EST)
Date: Fri, 18 May 2007 18:31:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Message-ID: <20070518183140.4644ffc6@hyperion.delvare>
In-Reply-To: <464DCD0E.9000706@freescale.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<8183195dad79296e3986f561bf929067@kernel.crashing.org>
	<464CADBB.9050500@freescale.com>
	<20070518172711.2db7fc92@hyperion.delvare>
	<464DCD0E.9000706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 May 2007 10:58:06 -0500, Scott Wood wrote:
> Jean Delvare wrote:
> > On Thu, 17 May 2007 14:32:11 -0500, Scott Wood wrote:
> > 
> >>(and the 
> >>i2c code in Linux should be fixed to allow drivers to specify multiple 
> >>match names).
> > 
> > 
> > Back when David proposed his new-style i2c code, I had the same
> > objection. But we addressed the need differently. If you look at struct
> > i2c_board_info, you'll see two string fields, driver_name and type. The
> > former specifies the driver name, the second specifies the exact device
> > variant. For drivers which support several device variants, the
> > platform code should fill both fields.
> 
> But that still requires the platform to know the driver name, rather 
> than matching any driver which knows about the type.  This prevents the 
> use of OS-independent device trees (such as in Open Firmware), which 
> cannot know specific Linux driver names, without something hacky like a 
> type-to-driver table in the device tree code.

Oh well, this was also the reason why I objected to David's approach in
the first place. If you dig back in the i2c list archive, you'll find
that I was asking for exactly the same thing you do now: that each i2c
driver would export a list of supported devices, and the i2c-core would
match a device name against that list (independent of the driver name.)
It felt more flexible, but I wondered how useful it would be in
practice, and finally gave up and David had the last word. If you had
shown up back then rather than now...

I am not familiar with Open Firmware. How standard is it? How realistic
would it be to use their device naming in the Linux kernel? Are there
other subsystem doing this? Are there other OSes using it, in
particular for I2C?

We have something which works now, even if that's not what you and I
had in mind, so I don't really want to change it without solid reasons.

-- 
Jean Delvare
