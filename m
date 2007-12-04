Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B892CDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 22:42:41 +1100 (EST)
Message-ID: <47553D31.4080306@anagramm.de>
Date: Tue, 04 Dec 2007 12:42:41 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474F1B25.8080508@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
	<20071203204652.GB4850@loki.buserror.net>
In-Reply-To: <20071203204652.GB4850@loki.buserror.net>
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
> On Mon, Dec 03, 2007 at 08:35:29PM +0100, Clemens Koller wrote:
>> Even if I have an eeprom which can have varying addresses,
>> I can simply tell the driver/the kernel .config what address
>> it should use...
> 
> That's precisely what we do, via the device tree.  It is not practical to do
> it with kconfig.

It's propably not practical to do it with kconfig right now, but
creating a separate configuration repository with strong relation
to the kernel config is IMO the wrong way to do it.

 > Again putting aside multiplatform kernels for the moment,
> what would you do in kconfig to describe the addresses of multiple chips
> without having a fixed-size list of possibilities?

I don't see

 > How would you tell the
> kernel, using kconfig, that there's a "foo" chip at address 0x68 on i2c bus
> 0, and a "bar" chip at address 0x68 on i2c bus 1?

I would prefer to not tell the driver for 'foo' that it should attach to 0-0068
because it should attach to the first i2c bus (0) it finds per default.
Then I would need to tell 'bar' to attach to 1-0068. Where is the problem?
The 0068 is already redundant in the case of these RTCs because they are fixed.

There is already an example in the kernel for a very similar configuration
issue: see CONFIG_RTC_HCTOSYS_DEVICE.

The structure for this already present in kconfig, and I don't see any
road block not to be able to use it. If later on, we want to have OF to
be able to reconfigure it in the form of a DT structure, we could
still feed a tool like the dtc with the .config and generate one.

Just let me make the point clear, why I got so upset here:
Having two different non-independent repositories make the
configuration much more error-prone, especially if the second
one (the DT) is partially redundant and not sufficiently documented.

Example:
I need to use the PCF8563 on the MPC8540' I2C as well (*) - it
was just working in 2.6.22. Now, somebody

a) has to enable it in the kernel config
b) then add it to the i2c_driver_device struct in fsl_soc.c
c) then add it to the DTS.

Step b and c are not difficult at all, but completely non-obvious
and undocumented for non-developers. You actually have to dig in
the code to find out that you need it and this s****.

linux-2.6/Documentation/powerpc$ grep "rtc" *
only gives on hit in the mpc52xx-device-tree-bindings.txt (from Grant, btw.).
which could give a clue what's going on here.
linux-2.6/Documentation/powerpc$ grep "fsl_soc" *
- nothing -

The configuration process is away from KISS - I would simply
state: it's broken - or - it's a regression from 2.6.22.

(*) Patch will follow, let me see if I guess it right. :-)

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
