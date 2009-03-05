Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 5 Mar 2009 08:59:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH/RFC] ps3/block: Add ps3vram-ng driver for accessing video
	RAM as block device
In-Reply-To: <AA44F8E7-5FBC-4378-A86D-C094ECABD625@aepfle.de>
Message-ID: <alpine.LRH.2.00.0903050856490.26681@vixen.sonytel.be>
References: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
	<AA44F8E7-5FBC-4378-A86D-C094ECABD625@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Jim Paris <jim@jtan.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org,
	Vivien Chappelier <vivien.chappelier@free.fr>,
	David Woodhouse <dwmw2@infradead.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Mar 2009, Olaf Hering wrote:
> Am 04.03.2009 um 14:57 schrieb Geert Uytterhoeven:
> >Ideally, we think it would be best if the existing MTD-based ps3vram driver
> >would be replaced by the new block-based ps3vram driver before 2.6.29 is
> >released. This would relieve the burden of supporting two different swap
> >space
> >schemes on PS3 (swap on /dev/mtdblock0 vs. /dev/ps3vram) from the distro
> >maintainer's shoulders, as in that case there would never have been a stable
> >kernel version containing the MTD-based ps3vram driver.
> 
> openSuSE already ships with the ps3vram driver since a two releases.
> A simple name based udev rule could symlink ps3vram to mtdblock0, so an
> upgrade
> will not break existing setups.

OK.

> >+obj-$(CONFIG_PS3_VRAM)		+= ps3vram_ng.o
> 
> Please give the driver the obvious name "ps3vram", that way upgrading will be
> smooth.

Sure, as I said:

| I'll submit a patch to remove the MTD
| ps3vram and add the new driver as ps3vram (instead of ps3vram-ng).

> I see our old mtddriver does not have modalias support for autoloading.

You forgot to backport commit 0a2d15b928e0b1673d4ed5f48d95af211b6fcc06
("mtd/ps3vram: Add modalias support to the ps3vram driver") to the openSuSE
tree?

> Hopefully the new driver has this feature.

Yes, it has.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
