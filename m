Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0997B2BDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Oct 2004 09:32:16 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041022175923.21b11f18.colin@colino.net>
References: <20041022173046.003bf2ea.colin@colino.net>
	<20041022175923.21b11f18.colin@colino.net>
Content-Type: text/plain
Message-Id: <1098487856.19462.93.camel@gaston>
Mime-Version: 1.0
Date: Sat, 23 Oct 2004 09:30:56 +1000
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: hda errors on iBook G4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-10-23 at 01:59, Colin Leroy wrote:
> On 22 Oct 2004 at 17h10, Colin Leroy wrote:
> 
> Hi, 
> 
> > I noticed hda status errors in my iBook G4's dmesg quite a long time
> > ago, but never looked any more... Today I just ran tests with hdparm
> > and this looks like really reproduceable:
> 
> I found one strange thing in drivers/ide/ppc/pmac.c:
> 
> pmac_ide_do_setfeature(ide_drive_t *drive, u8 command) {...}
> 
> pmac_ide_udma_enable(ide_drive_t *drive, u16 mode)
> {...
> 	ret = pmac_ide_do_setfeature(drive, mode);
> ...}
> 
> We really want to pass u16 to the function taking an u8 arg?
> (just a wild shot, it's probably wanted, but i thought i'd share).

It's a thinko, but it's always a u8 anyway

Ben.
