Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93CEA67A5E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 02:05:38 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060809140336.9E3C93535D4@atlas.denx.de>
References: <20060809140336.9E3C93535D4@atlas.denx.de>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 18:05:01 +0200
Message-Id: <1155139501.17187.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's just that I think that the DT *sources* should not  be  part  of
> the  U-Boot  soutrce  tree, and that the DT should be in fact part of
> the kernel images that gets booted by U-Boot.

Fair enough, I misunderstood.

> This has been discussed before (see archives), and the agreement  (?)
> was  to  use  U-Boot's multifile image format for this purpose, where
> you can combine a Linux kenrel image with a DT image  into  one  file
> bootable by U-Boot.

Well, I would still like something else. For example, I'm vendor NetFoo
selling network appliances (ADSL modems, routers, wireless APs, ...).

A certain amount of my products are based on a very similar chipset
provided by vendor NarrowCom, same core, same ethernet cell, though my
devices have subtle differences in the various varieties of those chips
used and what other chips are put around on the board.

I want my devices to have a firmware that pass a DT to the kernel. That
DT is bolted into the firmware. In fact, it could be separate flash
blocks (especially if the flash has some small blocks) from the actual
firmware code but that does not really matter.

That way, I can distribute and maintain a single kernel image update
package as part of my software update/maintainance solution.

Now you might argue that the way to work around that is to distribute a
vmlinux + DT files and have the "installer" merge them together at flash
time. I don't disagree... that works... if the kernel is in flash. It's
a bit more annoying once you start having it on a removable support
though...

It's not _the_ only solution but it's something that I think should be
considered.

Now as far as having an official repository for the .dts files of boards
supported by the kernel, I suppose indeed that the kenrel tree is an as
good location as anything else.

Cheers,
Ben.
