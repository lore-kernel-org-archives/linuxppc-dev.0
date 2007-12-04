Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC6CADDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 00:08:43 +1100 (EST)
Date: Tue, 4 Dec 2007 07:08:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
Message-ID: <20071204130841.GA5765@loki.buserror.net>
References: <474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
	<20071203204652.GB4850@loki.buserror.net>
	<47553D31.4080306@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47553D31.4080306@anagramm.de>
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

On Tue, Dec 04, 2007 at 12:42:41PM +0100, Clemens Koller wrote:
> Scott Wood schrieb:
>> That's precisely what we do, via the device tree.  It is not practical to
>> do it with kconfig.
>
> It's propably not practical to do it with kconfig right now,

It's not practical at all.  It forces you to support one and only one target
per kernel image, and the basic structure of it is not nearly flexible
enough.

> but creating a separate configuration repository with strong relation to
> the kernel config is IMO the wrong way to do it.

It has a weak relation to the kernel config, not a strong one.

> > Again putting aside multiplatform kernels for the moment,
>> what would you do in kconfig to describe the addresses of multiple chips
>> without having a fixed-size list of possibilities?
>
> I don't see

?

> > How would you tell the
>> kernel, using kconfig, that there's a "foo" chip at address 0x68 on i2c 
>> bus
>> 0, and a "bar" chip at address 0x68 on i2c bus 1?
>
> I would prefer to not tell the driver for 'foo' that it should attach to 
> 0-0068
> because it should attach to the first i2c bus (0) it finds per default.

Absolutely wrong.  What if foo is on bus 1?

> Then I would need to tell 'bar' to attach to 1-0068. Where is the problem?

OK, now say there's another foo on bus 2, and a pair of bars on buses 3 and
4?

> The 0068 is already redundant in the case of these RTCs because they are 
> fixed.

How do you know I'm even talking about RTCs?  Those chips at 0x68 could be
anything.  There are many chips that don't have a single fixed address.

> There is already an example in the kernel for a very similar configuration
> issue: see CONFIG_RTC_HCTOSYS_DEVICE.

That's not remotely the same.  That's telling a kernel init procedure what
kernel device to use, not describing the layout of hardware.

> The structure for this already present in kconfig, 

It is not.

> and I don't see any road block not to be able to use it. If later on, we
> want to have OF to be able to reconfigure it in the form of a DT
> structure, we could still feed a tool like the dtc with the .config and
> generate one.

Please, feel free to make a patch that does this.  You may find it to be a
bit more difficult than you thought. :-)

And again, there's the multiplatform issue.

> Just let me make the point clear, why I got so upset here: Having two
> different non-independent repositories make the configuration much more
> error-prone, especially if the second one (the DT) is partially redundant
> and not sufficiently documented.

The device tree is not a configuration repository, it is a description of
the hardware.

> Example:
> I need to use the PCF8563 on the MPC8540' I2C as well (*) - it
> was just working in 2.6.22. Now, somebody
>
> a) has to enable it in the kernel config
> b) then add it to the i2c_driver_device struct in fsl_soc.c
> c) then add it to the DTS.
>
> Step b and c are not difficult at all, but completely non-obvious
> and undocumented for non-developers. You actually have to dig in
> the code to find out that you need it and this s****.

Step b is something that only needs to be done once per chip, and step c is
something that only needs to be done once per board.  Why is it unreasonable
for it to be done by a developer?

We really should try to get the table populated with names for all of the
new-style drivers in the kernel, though.

> linux-2.6/Documentation/powerpc$ grep "rtc" *
> only gives on hit in the mpc52xx-device-tree-bindings.txt (from Grant, 
> btw.).
> which could give a clue what's going on here.
> linux-2.6/Documentation/powerpc$ grep "fsl_soc" *
> - nothing -

Uh, did you try grepping for "i2c"?

> The configuration process is away from KISS - I would simply
> state: it's broken - or - it's a regression from 2.6.22.

The transition could have been done more smoothly if the i2c driver model
allowed a driver to be both new-style and old-style at the same time
(subject to a config option to shut off old-style if it's screwing things
up), I'll agree with that much.  But please, try to understand that the
device tree really does help.

-Scott
