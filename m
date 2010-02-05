Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1806FB8267
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 01:06:10 +1100 (EST)
Date: Fri, 5 Feb 2010 14:49:14 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 1/4] Add ps3_storage module alias
In-Reply-To: <20100205134235.GG12001@hansolo.jdub.homelinux.org>
Message-ID: <alpine.LRH.2.00.1002051446280.5981@mink.sonytel.be>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205134235.GG12001@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 5 Feb 2010, Josh Boyer wrote:
> This allows the upgrade path from older kernel releases to work
> with the Fedora mkinitrd tool.
>=20
> ---
>=20
> --- linux-2.6.22.ppc64/drivers/block/ps3disk.c~=092007-07-25 16:06:16.000=
000000 +0100
> +++ linux-2.6.22.ppc64/drivers/block/ps3disk.c=092007-07-26 08:49:44.0000=
00000 +0100
> @@ -628,3 +628,4 @@ MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("PS3 Disk Storage Driver");
>  MODULE_AUTHOR("Sony Corporation");
>  MODULE_ALIAS(PS3_MODULE_ALIAS_STOR_DISK);
> +MODULE_ALIAS("ps3_storage");

NAKed-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3_storage was replaced by 3 drivers: ps3disk, ps3rom, and ps3flash. These=
 are
automatically loaded by udev.

How does mkinitrd determine the driver for the root file system on other
systems? Does it really contain a big list of e.g. all SCSI drivers?

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
