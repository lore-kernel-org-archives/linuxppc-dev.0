Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E81DDDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 04:47:45 +1100 (EST)
Message-ID: <4730A617.9040502@freescale.com>
Date: Tue, 06 Nov 2007 11:36:23 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>	<472F7247.9070106@freescale.com>	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>	<472F8267.8070106@freescale.com>
	<20071106182953.3c1a57e3@hyperion.delvare>
In-Reply-To: <20071106182953.3c1a57e3@hyperion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jean Delvare wrote:
>>>> We might as well just use i2c_new_device() instead of messing around
>>>> with bus numbers.  Note that this is technically no longer platform
>>>> code, so it's harder to justify claiming the static numberspace.
>>> I was allowing control of the bus number with "cell-index" and
>>> i2c_add_numbered_adapter().
>>> Should I get rid of this and switch to i2c_add_adapter()?
>> Yes.
> 
> No! If you don't call i2c_add_numbered_adapter() then new-style i2c
> clients will never work on your i2c adapter.

I thought that was what i2c_new_device() was for?

By handling all the device tree stuff in the driver, it acts more like 
an add-on adapter than a platform device.

-Scott
