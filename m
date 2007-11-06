Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by ozlabs.org (Postfix) with ESMTP id C52E6DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 05:10:41 +1100 (EST)
Date: Tue, 6 Nov 2007 19:10:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-ID: <20071106191039.37cd7053@hyperion.delvare>
In-Reply-To: <4730A617.9040502@freescale.com>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<20071106182953.3c1a57e3@hyperion.delvare>
	<4730A617.9040502@freescale.com>
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

Hi Scott,

On Tue, 06 Nov 2007 11:36:23 -0600, Scott Wood wrote:
> Jean Delvare wrote:
> >>>> We might as well just use i2c_new_device() instead of messing around
> >>>> with bus numbers.  Note that this is technically no longer platform
> >>>> code, so it's harder to justify claiming the static numberspace.
> >>> I was allowing control of the bus number with "cell-index" and
> >>> i2c_add_numbered_adapter().
> >>> Should I get rid of this and switch to i2c_add_adapter()?
> >> Yes.
> > 
> > No! If you don't call i2c_add_numbered_adapter() then new-style i2c
> > clients will never work on your i2c adapter.
> 
> I thought that was what i2c_new_device() was for?

Sorry, I've not been completely clear. Yes, you can use
i2c_new_device() on an adapter that has been added with
i2c_add_adapter(). However, this requires that you have a reference to
that i2c_adapter, which is usually not the case with system-wide I2C
buses. Embedded platforms would rather use i2c_add_numbered_adapter(),
give a list of chips to i2c_register_board_info() and let i2c-core
instantiate them. i2c_new_device was primarily meant for multimedia
adapters.

> By handling all the device tree stuff in the driver, it acts more like 
> an add-on adapter than a platform device.

-- 
Jean Delvare
