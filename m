Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 513E4DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 04:40:59 +1100 (EST)
Message-ID: <47543FAD.7040504@anagramm.de>
Date: Mon, 03 Dec 2007 18:41:01 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>	<20071130122055.729dd3f8@i1501.lan.towertech.it>	<47541D70.2040805@anagramm.de>
	<47542A50.1030208@anagramm.de> <47543351.2080904@freescale.com>
In-Reply-To: <47543351.2080904@freescale.com>
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

Hello, Scott!

Scott Wood schrieb:
 > Clemens Koller wrote:
 >> [OT+sarcasm on]
 >>
 >> So, the time is over, where you just enable a driver in the kernel
 >> config and
 >> the device gets probed and - if it's probed successfully - it usually
 >> works.
 >
 > The problem is the "probed successfully" bit -- i2c can't be
 > automatically detected like PCI can, and the probing that was being done
 > before was very error-prone.

I think I understood the original purpose of device trees, or it's
intended advantage but don't see much of this yet.

Before (2.6.22) everything was working fine just by enabling the proper
kernel config. But in it's current implementation I primarily see the
an additional, duplicate, badly documented configuration step for
these - in my case - stupid, usually trivial to handle RTC chips.

 > That's the simplest way, but not the only way.  You could also have a
 > wrapper platform that chooses the proper device tree based on something
 > you detect.

Here is the problem:
something it detects = probing (what we planned to avoid)
something I detect = configurating (currently duplicated work).
This wrapper platform doesn't really exist yet in practice.

 >> Hmmm... this just s****!
 >
 > There are some growing pains, but the old method of blindly poking at
 > i2c addresses and hoping that the first driver to ask for a port that
 > something responds to is actually the right driver for that port is just
 > shit.

That's not a good example: Of course, blindly poking is bad...
therefore there is the (kernel.)configuration step to have only
the relevant drivers enabled:
The Philips PCF8563 is on address 0x51 and the DS13x7 on 0x68.
The drivers don't touch foreign addresses at all and they are
fixed. No issues there... proved by 2.6.22.

Well, I don't want to start a flamewar on this since we have had
already enough pro & contra Device Tree discussions. I just want
to point out that the current situation doesn't really follow
the KISS principle at all in my eyes.

Here, the next idea which comes to my mind:
Maybe we should think about a kernel-config -> dts compiler for
the future where the enabled drivers generate their default dts
entries automagically?

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
