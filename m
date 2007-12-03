Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1522DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 05:07:26 +1100 (EST)
Message-ID: <475445DF.6080202@freescale.com>
Date: Mon, 03 Dec 2007 12:07:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>	<20071130122055.729dd3f8@i1501.lan.towertech.it>	<47541D70.2040805@anagramm.de>
	<47542A50.1030208@anagramm.de> <47543351.2080904@freescale.com>
	<47543FAD.7040504@anagramm.de>
In-Reply-To: <47543FAD.7040504@anagramm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clemens Koller wrote:
> Scott Wood schrieb:
>  > The problem is the "probed successfully" bit -- i2c can't be
>  > automatically detected like PCI can, and the probing that was being done
>  > before was very error-prone.
> 
> I think I understood the original purpose of device trees, or it's
> intended advantage but don't see much of this yet.
> 
> Before (2.6.22) everything was working fine just by enabling the proper
> kernel config.

Just because it worked fine *for you* doesn't mean it worked fine in 
general.

1. This means that you can't use the same kernel with different 
hardware, which is precisely what you were complaining that you couldn't do.
2. What if you have two i2c devices at the same address on different 
buses?  Or if you have two devices, these devices can reside on a 
variety of ports, and the driver for one tries to probe the port of the 
other?  .config doesn't help you now.
3. What if you need to pass in extra information to the driver, such as 
the exact chip type when more than one is handled by the same driver, or 
the IRQ line if the chip uses one, etc?

> Well, I don't want to start a flamewar on this since we have had
> already enough pro & contra Device Tree discussions. I just want
> to point out that the current situation doesn't really follow
> the KISS principle at all in my eyes.

It should be as simple as it can be and still work, but no simpler. 
Before, it was too simple to work.

> Here, the next idea which comes to my mind:
> Maybe we should think about a kernel-config -> dts compiler for
> the future where the enabled drivers generate their default dts
> entries automagically?

Sorry, there's just not enough information in .config for that.

-Scott
