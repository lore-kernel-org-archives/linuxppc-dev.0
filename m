Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id CF128DDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 06:35:26 +1100 (EST)
Message-ID: <47545A81.90804@anagramm.de>
Date: Mon, 03 Dec 2007 20:35:29 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>	<20071130122055.729dd3f8@i1501.lan.towertech.it>	<47541D70.2040805@anagramm.de>
	<47542A50.1030208@anagramm.de> <47543351.2080904@freescale.com>
	<47543FAD.7040504@anagramm.de> <475445DF.6080202@freescale.com>
In-Reply-To: <475445DF.6080202@freescale.com>
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
 >> Here, the next idea which comes to my mind:
 >> Maybe we should think about a kernel-config -> dts compiler for
 >> the future where the enabled drivers generate their default dts
 >> entries automagically?
 >
 > Sorry, there's just not enough information in .config for that.

If there is really the need to put more information (which I don't
see in the case of the RTCs) to .config, it might be an idea to
extend the current structure for this use instead of duplicating
and maintaining a second repository.

And regarding the DS1337 (or the PCF8563 and similar RTCs):
It's address (0x68) is immutable fixed by the manufacturer
of that device. So, why do we include it in the DT, when we
already told the kernel what driver we want to use?

Even if I have an eeprom which can have varying addresses,
I can simply tell the driver/the kernel .config what address
it should use... If I want to be able to alter that address
for whatever reason by OF, I still don't want to touch a
separate file in the kernel tree.

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
