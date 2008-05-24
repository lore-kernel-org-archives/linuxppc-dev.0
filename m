Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C7122DE0F4
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 00:32:56 +1000 (EST)
Message-ID: <48382710.9030700@scram.de>
Date: Sat, 24 May 2008 16:32:48 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 2/2] mmc: add OpenFirmware bindings for the mmc_spi
	driver
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>	<20080523182842.GB469@polina.dev.rtsoft.ru>
	<fa686aa40805232219x7e888d80y394958f1c0a0fad0@mail.gmail.com>
In-Reply-To: <fa686aa40805232219x7e888d80y394958f1c0a0fad0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

>> +      - compatible : should be "linux,mmc-spi".
>> +      - linux,modalias  - should be "of_mmc_spi".
> 
> I'm not even sure if the whole linux,modalias is even a good idea.  I
> had kind of thrown it in there as a convenient way to override
> compatible when needed, but I haven't really thought it out very well
> and I think it is rather a hack.
> 
> The real problem is we don't yet have good method (or place) to apply
> a translation table from compatible values to modaliases.  Ideally,
> the translations should be part of the drivers themselves, but that
> causes a chicken and egg problem of needing to load the driver to get
> access to the table to know if it is the correct driver... Of course,
> I'm really not very familiar with the whole module autoloading
> mechanism.  Regardless; binding should be based on compatible, not on
> a hacky and bogus linux,modalias property.

i2c exactly has the same problem. Here the compatible entry is used
in drivers/of/of_i2c.c and mangled into a name to be used as modalias.
It's still sort of hackish, but it seems to be a compromise acceptable
by both OF and i2c folks.

Thanks,
Jochen
