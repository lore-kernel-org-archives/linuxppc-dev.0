Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3D9ADDEA3
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 08:41:56 +1000 (EST)
Message-ID: <463E59C7.9030309@genesi-usa.com>
Date: Sun, 06 May 2007 23:42:15 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
References: <1178142818.32136.51.camel@ld0161-tx32>	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>	<1178207725.17201.33.camel@ld0161-tx32>	<20070503161000.GA31881@lixom.net>
	<1178209046.17201.55.camel@ld0161-tx32>
In-Reply-To: <1178209046.17201.55.camel@ld0161-tx32>
Content-Type: text/plain; charset=UTF-8
Cc: Olof Johansson <olof@lixom.net>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Jon Loeliger wrote:
> On Thu, 2007-05-03 at 11:10, Olof Johansson wrote:
> 
>> This sounds like something that firmware should take care of, not
>> hardcoded in the board code.  Seems like the device is just a PCI device
>> that doesn't have a device tree entry.
> 
> Well, it's not a PCI device at all.

A PCI Express southbridge - not much difference really is there?

>> Why not do this in u-boot instead?
> 
> Why do it there?  We'd have to do it _again_ in Linux
> if we didn't come in from U-Boot anyway.

Because the firmware should configure the board specifics if possible,
Linux should only be tweaking Northbridge/Southbridge settings if it
is truly configurable at runtime or boot. If the difference is between
whether an AC97 or Azalia codec is installed and soldered to the board,
and it is not possible to have both, really the firmware should be
setting up the chip so that only one is obviously usable.

Ostensibly Linux and any drivers should be able to check which is
enabled on the board - one revision may have AC97 and one may have
Azalia HD audio. If this can be swapped by simply having each driver
check the enabled codec mode on init, and dropping out if not correct,
then it's starting to get to be Plug And Play.

The alternative is that every revision of the board has it Hardcoded
Into A Board Support Package, with different device trees and strange
quirks which may or may not be easily determined, cluttering Kconfigs
and so on.

In theory; the firmware should do it, and if not, it should be done
as early in Linux boot (platform init, device tree fixup) as possible.
That's how we agreed to do it on the Efika after much, much discussion
and argument :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
