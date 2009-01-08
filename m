Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 8 Jan 2009 11:34:25 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 0/6] ps3vram driver patches
In-Reply-To: <200901072053.06037.arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.0901081120240.25621@vixen.sonytel.be>
References: <4963CDCA.4080802@am.sony.com> <200901071944.45680.arnd@arndb.de>
	<49650128.8020200@am.sony.com> <200901072053.06037.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: David Woodhouse <David.Woodhouse@intel.com>, Jim Paris <jim@jtan.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 7 Jan 2009, Arnd Bergmann wrote:
> On Wednesday 07 January 2009, Geoff Levand wrote:
> > Geert and I were discussing actually removing the direct write to the XDR
> > memory, and so the need for that ioremap, as the mapping is just used in
> > ps3vram_erase(), which seems could be removed.

ps3vram_erase() writes all ones to the memory, as that's what done when
erasing real FLASH. I do not know if the MTD layer can handle it if we don't
"erase" it to ones.

David?

> Ah, I see. I also forgot to mention that the ioremap_flags change should
> only be done for actual memory regions, but *not* for memory mapped I/O
> registers.

This is DDR memory for the RSX.

> > I want to get it converted to a block device, and I will work towards
> > that, but it will take some time. 燗s it is, it is very useful for typical
> > systems that are running full desktops like gmome or KDE and do a lot of
> > swapping. 燤any of the distros now use it, and users want it.
> 
> Yes, fine by me.

One disadvantage of this approach is that it makes life more difficult for
distro maintainers: their userland has to support both the MTD and the block
version.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village 路 Da Vincilaan 7-D1 路 B-1935 Zaventem 路 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 路 RPR Brussels
Fortis 路 BIC GEBABEBB 路 IBAN BE41293037680010
