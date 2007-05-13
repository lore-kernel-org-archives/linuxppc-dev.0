Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84663DDED0
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 21:18:55 +1000 (EST)
In-Reply-To: <20070513061954.GA16623@lixom.net>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
	<200705130248.22844.arnd@arndb.de>
	<1179022810.32247.54.camel@localhost.localdomain>
	<20070513061954.GA16623@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <82c4101a83362d2ce78713a70df535d4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 13:17:57 +0200
To: olof@lixom.net (Olof Johansson)
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Also, in this particular case, the bindings are not standardized, and
> there's a good chance that whatever new platform uses a similar device
> will need to do something slightly different.

Yeah, everyone else will do the sane thing, and describe
the two register ranges the IDE uses, not a much bigger
range full of register shadows like you have.  It is one
thing for the hardware to do partial address decoding;
the device tree shouldn't normally expose this though.

But that's what you've got now, so you have your own
special OF device matching code, which is exactly as it
should be.  No need to have "generic" ide OF matching
code until device trees containing such devices show
up :-)


Segher
