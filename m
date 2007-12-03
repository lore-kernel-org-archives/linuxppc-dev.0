Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A949DDE27
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 08:50:37 +1100 (EST)
Date: Mon, 3 Dec 2007 14:46:52 -0600
From: Scott Wood <scottwood@freescale.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
Message-ID: <20071203204652.GB4850@loki.buserror.net>
References: <474F1B25.8080508@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47545A81.90804@anagramm.de>
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

On Mon, Dec 03, 2007 at 08:35:29PM +0100, Clemens Koller wrote:
> Hello, Scott!
>
> Scott Wood schrieb:
> >> Here, the next idea which comes to my mind:
> >> Maybe we should think about a kernel-config -> dts compiler for
> >> the future where the enabled drivers generate their default dts
> >> entries automagically?
> >
> > Sorry, there's just not enough information in .config for that.
>
> If there is really the need to put more information (which I don't
> see in the case of the RTCs)

It's not uncommon for RTCs to have an alarm IRQ.  It's not uncommon for
multiple not-quite-compatible RTC chips to be driven by the same driver,
which needs to know what it's dealing with.

> to .config, it might be an idea to extend the current structure for this
> use instead of duplicating and maintaining a second repository.

.config is not nearly as flexible in describing hardware as the device tree
is.  Sorry, but even apart from the multiplatform issue, it's the wrong tool
for the job.

> And regarding the DS1337 (or the PCF8563 and similar RTCs):
> It's address (0x68) is immutable fixed by the manufacturer
> of that device. So, why do we include it in the DT, when we
> already told the kernel what driver we want to use?

You did not tell the kernel what driver you wanted to use; you told the
driver which address the chip will be on.  There are other chips that also
use address 0x68, such as DS1374, which is completely incompatible with
DS1337 and uses a different driver.

> Even if I have an eeprom which can have varying addresses,
> I can simply tell the driver/the kernel .config what address
> it should use...

That's precisely what we do, via the device tree.  It is not practical to do
it with kconfig.  Again putting aside multiplatform kernels for the moment,
what would you do in kconfig to describe the addresses of multiple chips
without having a fixed-size list of possibilities?  How would you tell the
kernel, using kconfig, that there's a "foo" chip at address 0x68 on i2c bus
0, and a "bar" chip at address 0x68 on i2c bus 1?

-Scott
