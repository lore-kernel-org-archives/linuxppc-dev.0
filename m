Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D0D0BB7CED
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 01:57:07 +1100 (EST)
Date: Fri, 5 Feb 2010 15:39:23 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 1/4] Add ps3_storage module alias
In-Reply-To: <20100205140350.GL12001@hansolo.jdub.homelinux.org>
Message-ID: <alpine.LRH.2.00.1002051538360.5981@mink.sonytel.be>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205134235.GG12001@hansolo.jdub.homelinux.org>
	<alpine.LRH.2.00.1002051446280.5981@mink.sonytel.be>
	<20100205140350.GL12001@hansolo.jdub.homelinux.org>
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
> On Fri, Feb 05, 2010 at 02:49:14PM +0100, Geert Uytterhoeven wrote:
> >On Fri, 5 Feb 2010, Josh Boyer wrote:
> >> This allows the upgrade path from older kernel releases to work
> >> with the Fedora mkinitrd tool.
> >>=20
> >> ---
> >>=20
> >> --- linux-2.6.22.ppc64/drivers/block/ps3disk.c~=092007-07-25 16:06:16.=
000000000 +0100
> >> +++ linux-2.6.22.ppc64/drivers/block/ps3disk.c=092007-07-26 08:49:44.0=
00000000 +0100
> >> @@ -628,3 +628,4 @@ MODULE_LICENSE("GPL");
> >>  MODULE_DESCRIPTION("PS3 Disk Storage Driver");
> >>  MODULE_AUTHOR("Sony Corporation");
> >>  MODULE_ALIAS(PS3_MODULE_ALIAS_STOR_DISK);
> >> +MODULE_ALIAS("ps3_storage");
> >
> >NAKed-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> >
> >ps3_storage was replaced by 3 drivers: ps3disk, ps3rom, and ps3flash. Th=
ese are
> >automatically loaded by udev.
> >
> >How does mkinitrd determine the driver for the root file system on other
> >systems? Does it really contain a big list of e.g. all SCSI drivers?
>=20
> At one time I believe it did have a list of "odd" drivers to explicitly
> include.  Anaconda didn't (doesn't?) use udev to determine which drivers
> to include in the initrd since the install image is most likely not compo=
sed
> on a machine that includes those drivers.  If the install initrd didn't h=
ave
> the drivers loaded, it wouldn't install on PS3.
>=20
> This is highlighted as a Fedora local change, probably for the reasons yo=
u
> state.  We might have already moved past the point where this is needed,
> so I'm fine with it being NAKed.  I'll probably just drop it from the Fed=
ora
> kernel builds.

It's possible it's (still) needed on Fedora, though (Geoff, do you know?).
But it's definitely not something we want in mainline.

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
