Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74820DDE99
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 03:48:31 +1100 (EST)
Message-ID: <47543351.2080904@freescale.com>
Date: Mon, 03 Dec 2007 10:48:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>	<20071130122055.729dd3f8@i1501.lan.towertech.it>	<47541D70.2040805@anagramm.de>
	<47542A50.1030208@anagramm.de>
In-Reply-To: <47542A50.1030208@anagramm.de>
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
> [OT+sarcasm on]
> 
> So, the time is over, where you just enable a driver in the kernel config and
> the device gets probed and - if it's probed successfully - it usually works.

The problem is the "probed successfully" bit -- i2c can't be 
automatically detected like PCI can, and the probing that was being done 
before was very error-prone.

Thus, there needs to be something describing what hardware is actually 
there, not just what the kernel supports.

> Now, the way is like this:
> 
> - enable the desired driver in the kernel.

As always.

> - check that the platform driver fsl_soc.c (in my case) defines the
>    desired rtc-chip in the i2c_board_info

Once the glue code gets consolidated, it'll just be a one-time thing for 
any given chip to be added to the OF I2C table.

I don't know why it was ever done in platform-specific code.

> - check that the rtc is included in the device tree.

This is the substitute for probing.

> - embed the device tree to the kernel (cuImage)

Or get it from the firmware.

> - boot'n'pray.
> 
> That looks really groundbreaking!
> 
> Now, I cannot use one kernel for two almost identical hardware revisions
> anymore because the rtc's on i2c are different? This must be a joke!

Not at all true.  The kernel just needs to know, at runtime, what 
hardware you actually have.  It uses the device tree for this.

With cuImage, you're limited to one device tree in a given build, though 
you can invoke the wrapper manually to create multiple images.  However, 
cuImage is a compatibility measure; if you use a newer u-boot with 
device tree support, the tree does not need to be statically wrapped in 
the kernel image.

> It seems like I first need to have full device tree support included in
> the boot-loader to be able to duplicate my configuration work to allow
> one kernel to boot on both hardware.

That's the simplest way, but not the only way.  You could also have a 
wrapper platform that chooses the proper device tree based on something 
you detect.

> Hmmm... this just s****!

There are some growing pains, but the old method of blindly poking at 
i2c addresses and hoping that the first driver to ask for a port that 
something responds to is actually the right driver for that port is just 
shit.

-Scott
