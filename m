Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 8123D68A78
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 20:29:23 +1100 (EST)
Received: from tq-mailsrv.tq-net.de (tq-mailsrv.tqs.de [172.20.1.2])
	by mail.tqs.de (Postfix) with ESMTP id 2C1DA2605
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 10:29:24 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Voyager Video support color depths?
Date: Wed, 8 Feb 2006 10:29:33 +0100
Message-ID: <47F3F98010FF784EBEE6526EAAB078D1C06003@tq-mailsrv.tq-net.de>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Russ,

linuxppc-embedded-bounces@ozlabs.org wrote on :
> I had a question about the various video support that has been tested
> with the 2.4.25 DENX Kernel.
>=20
> To date I have had pretty good luck with by making sure I have
> compiled the kernel with the Voyager.h file set at 32 BPP mode.
>=20
> For speed optimization I wanted to cut it back to 16 BPP mode,
> however I couldn't hardly get it to boot the machine after I did this
> change by changing '#define SCREEN_BPP 16'. Most attempts the kernel

You are using an old driver. Please try the current top of git one.

The driver now supports kernel parameters. To set the color depth during
booting you could use for example:

video=3Dvoyager:bpp=3D16

> would lock up before a login prompt was available. When I tried
> SCREEN_BPP at 8 then it booted fine, however QT/Embedded had terrible
> colors.

Support for 8 bpp mode should be improved in the current driver.

> I was wondering if I should be looking for the trouble in some other
> code, or perhaps hardware, or if this is a known bug in the SM501 /
> Voyager driver, or perhaps the linux frame buffer driver.

How is your SM501 connected to your CPU? Which board are you using?
The default configuration of the driver assumes tht the SM501 is
connected via the SH4-Interface, not PCI.

Regards,
Martin
