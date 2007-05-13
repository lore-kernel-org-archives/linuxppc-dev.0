Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6580DDEA2
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 23:35:10 +1000 (EST)
Date: Sun, 13 May 2007 14:39:27 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Message-ID: <20070513143927.59ca253e@the-village.bc.nu>
In-Reply-To: <200705130248.22844.arnd@arndb.de>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
	<200705130248.22844.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Easier to use pata_platform I would think ? Just create the OF device and
> > bind it to pata_platform.
> 
> Not sure I understand what you mean. pata_platform expects a platform_device,
> which cannot be cast from an of_device.

Other than the binding and wanting to use the standard ->set_mode they
appear to be identical so a copy of pata_platform ought to turn into a
pata_of very nicely.

> Olof, have you looked at which of the two ->set_mode functions is more
> appropriate for electra? I would guess that you actually want to use
> the ata_generic one.

You almost certainly simply don't want to provide one. I'm not sure the
pata_platform default one is right at all as it will assume the firmware
tuned everything. ata_generic does this purely because it is a "last
resort" driver for chips we can't tune/program at all.

Alan
