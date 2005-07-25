Return-Path: <kate@katix.org>
Received: from ns.iti.fi (unknown [195.218.81.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB32367D2D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 19:30:20 +1000 (EST)
Received: from ns.iti.fi (localhost.localdomain [127.0.0.1])
	by ns.iti.fi (8.12.8/8.12.8) with ESMTP id j6P8cnED014628
	for <linuxppc-embedded@ozlabs.org>; Mon, 25 Jul 2005 11:38:49 +0300
Message-ID: <4159.192.100.124.219.1122280726.squirrel@www.iti.fi>
Date: Mon, 25 Jul 2005 11:38:46 +0300 (EEST)
From: "Kate Alhola" <kate@katix.org>
To: <linuxppc-embedded@ozlabs.org>
In-Reply-To: <f9aee3d7921497b1309fb9c67caa914c@embeddededge.com>
References: <528646bc05072307074e8fce3e@mail.gmail.com>
	<20050723142210.GA24313@gate.ebshome.net>
	<f9aee3d7921497b1309fb9c67caa914c@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Re: [PATCH 1/3] SPI bus core infrastructure
Reply-To: kate@katix.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
> On Jul 23, 2005, at 10:22 AM, Eugene Surovegin wrote:

> ...  and there is more.  Some devices, even when not selected, still use
> the SPI clock for clocking internal logic.  You have to ensure with such
> devices you don't ever run the SPI faster than their spec.  This is
> application specific, but something that has to be considered when there
> are multiple devices on the SPI bus.
>
> Also, many boards use external logic for the assertion of the
> device select, which is necessary if there is more than one device on
> the bus.  Sometimes it's a multiplexer that routes the controller SPI
> select, other times the multiplexer drives the selects directly. In my
> review of the patch, I didn't see anything that would provide for this.

I already made one SPI subsystem implementation. I published
it in end of 2004 with GPL ( http://www.katix.org/spi.php ).
There is still work to done for it but least basic functionality
has been working since.

There is picture how i resolved the CS problem with separeating host,
target driver and CS driver to separate modules.

In this architecture target driver like ( tsc2301 ) requests chipselect
from SPI subsystem and board specefic CS module assigns it. Then the
other SPI host driver like mpc5200psc or mpc5200spi does the actual
SPI transfer.

In this way, only the CS module need to be changed if same processor is
used with diferent boards that use separate PIO lines for SPI CS lines.



Kate
