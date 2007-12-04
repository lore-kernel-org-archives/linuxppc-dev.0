Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A0283DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 02:33:29 +1100 (EST)
Message-ID: <4755731D.4050106@anagramm.de>
Date: Tue, 04 Dec 2007 16:32:45 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
	<20071203204652.GB4850@loki.buserror.net>
	<47553D31.4080306@anagramm.de>
	<20071204130841.GA5765@loki.buserror.net>
In-Reply-To: <20071204130841.GA5765@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi, Scott!

Scott Wood schrieb:
 >>> How would you tell the
 >>> kernel, using kconfig, that there's a "foo" chip at address 0x68 on i2c
 >>> bus
 >>> 0, and a "bar" chip at address 0x68 on i2c bus 1?
 >>
 >> I would prefer to not tell the driver for 'foo' that it should attach to
 >> 0-0068
 >> because it should attach to the first i2c bus (0) it finds per default.
 >
 > Absolutely wrong.

Hmm... Why?

 > What if foo is on bus 1?

Then I would need to tell the driver 'foo' that it should attach
to 1-0068. Sorry, I really don't understand your problem here.
If we have 'foo' on both busses, I need of course tell it
to attach to 0-0068 as well as 1-0068.

Propably you should see the bigger picture here:
We just need to tell what we have, if it's not some default...
statically (kconfig) or dynamically (of/dt) to get it right
because we cannot probe for sure what we have (in contrast to PCI).

I just don't want to be pushed into configuring things twice or on
two different places because that's error prone.

 >> Then I would need to tell 'bar' to attach to 1-0068. Where is the problem?
 >
 > OK, now say there's another foo on bus 2, and a pair of bars on buses 3 and
 > 4?

Okay, let's play that game:
foo -> connect an instance to 0-0068 and 2-0068
bar -> connect an instance to 1-0068 and and 3-0068 and 4-0068

If i.e. bar is a 8-page eeprom which hw-configurable addresses nailed
down to 0x50 and 0x58 to have a contigous eeprom area from 0x50 to 0x5f
it can also look like:
bar -> connect an instance to 1-0050 and 1-0058

I still don't see a conflict here.

You cannot connect more than one device to an address, that would
violate the I2C Spec. If you have different devices with the same
address, you have to nail down which ones belong together.

 >> The 0068 is already redundant in the case of these RTCs because they are
 >> fixed.
 >
 > How do you know I'm even talking about RTCs?

Well, the subject is about RTCs.
But still the same applys for other i2c devices.

 >  Those chips at 0x68 could be
 > anything.  There are many chips that don't have a single fixed address.

Sure. Just to make sure

 >> There is already an example in the kernel for a very similar configuration
 >> issue: see CONFIG_RTC_HCTOSYS_DEVICE.
 >
 > That's not remotely the same.  That's telling a kernel init procedure what
 > kernel device to use, not describing the layout of hardware.

I was trying to tell you that the structure to embed above information
is already there.

 >>> The structure for this already present in kconfig,
 >
 > It is not.

Okay, our point of view is different here.

 > We really should try to get the table populated with names for all of the
 > new-style drivers in the kernel, though.

Yes. That's what's really necessary to put usability back in.

 >> linux-2.6/Documentation/powerpc$ grep "rtc" *
 >> only gives on hit in the mpc52xx-device-tree-bindings.txt (from Grant,
 >> btw.).
 >> which could give a clue what's going on here.
 >> linux-2.6/Documentation/powerpc$ grep "fsl_soc" *
 >> - nothing -
 >
 > Uh, did you try grepping for "i2c"?

No, I've just read the whole file from time to time.

 >> The configuration process is away from KISS - I would simply
 >> state: it's broken - or - it's a regression from 2.6.22.
 >
 > The transition could have been done more smoothly if the i2c driver model
 > allowed a driver to be both new-style and old-style at the same time
 > (subject to a config option to shut off old-style if it's screwing things
 > up), I'll agree with that much.
 >  But please, try to understand that the
 > device tree really does help.

That was discussed already in detail in several threads and there
were already decisions made that the DT went into the kernel - no problem
with that.
I just don't see that it 'really does help' in it's current state if
things are broken in a way they are hard to fix for non DT-familiar
developers, almost impossible to fix for users which just need to
compile their own kernel to achieve their project goal.

Well... let's take it easy. I'll dig into the pcf8563 code now.

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
