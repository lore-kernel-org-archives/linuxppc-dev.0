Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id F1BBBDDEC4
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 10:48:31 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 02:48:22 +0200
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
In-Reply-To: <20070513005830.38ba8e3b@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705130248.22844.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org,
	paulus@samba.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 13 May 2007, Alan Cox wrote:
> > Why not provide a proper pata_of.c driver based on ata_generic? That
> > will help the next person that has a builtin ata controller and wants
> > to get it running as an of_device.
> 
> Easier to use pata_platform I would think ? Just create the OF device and
> bind it to pata_platform.

Not sure I understand what you mean. pata_platform expects a platform_device,
which cannot be cast from an of_device.

Actually, it might be possible to merge the common parts of pata_platform,
ata_generic and ata_of into one module, and have one driver for each
of the three bus_types on top of it. Currently, the only difference between
ata_generic and pata_platform is the ->set_mode function, which can
probably be made generic (controlled by a flag in the ata_port).

Olof, have you looked at which of the two ->set_mode functions is more
appropriate for electra? I would guess that you actually want to use
the ata_generic one.

	Arnd <><
