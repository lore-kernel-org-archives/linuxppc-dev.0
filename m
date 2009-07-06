Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D22E9B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 02:19:54 +1000 (EST)
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 3AB9CDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 02:19:53 +1000 (EST)
Message-ID: <4A522420.9040307@harris.com>
Date: Mon, 06 Jul 2009 12:19:44 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: Subject: [PATCH v8] spi: Add PPC4xx SPI driver
References: <4A44F643.3050505@harris.com>
	<200907021744.27636.david-b@pacbell.net>
In-Reply-To: <200907021744.27636.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Friday 26 June 2009, Steven A. Falco wrote:
>> +
>> +       /*
>> +        * If there are no chip selects at all, or if this is the special
>> +        * case of a non-existent (dummy) chip select, do nothing.
>> +        */
>> +
>> +       if (!hw->master->num_chipselect || hw->gpios[cs] == -EEXIST)
>> +               return;
>> +
> 
> I'm going to send this in, but please send a followup
> patch making all this "non-existent (dummy) chip select"
> stuff use the SPI_NO_CS flag.
> 

Not sure yet how this will work.  GPIOs are detected during probe.
of_get_gpio_flags() will return EEXIST for devices without a CS,
and will return the gpio number for devices with a CS, but probe
doesn't (currently) know anything about "struct spi_device".

In fact, the devices don't exist until spi_bitbang_start is called,
near the end of the probe.  So, I've not figured out how the probe
routine will set the new SPI_NO_CS flag on a per-device basis.

There is one example of a ppc board calling spi_register_board_info,
but even that board doesn't really use it, if a device tree exists.

> 
>> +       /*
>> +        * A count of zero implies a single SPI device without any chip-select.
>> +        * Note that of_gpio_count counts all gpios assigned to this spi master.
>> +        * This includes both "null" gpio's and real ones.
>> +        */
> 
> 
> 
