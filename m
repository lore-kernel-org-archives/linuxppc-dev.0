Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 0A57EDDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 07:57:15 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so317626ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 12:57:13 -0800 (PST)
Message-ID: <b5e2fc790811261257x3309e4b1n242d99c6248775d@mail.gmail.com>
Date: Wed, 26 Nov 2008 14:57:13 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <200811251345.11350.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<492C5DC2.9040402@billgatliff.com>
	<1227646490.5404.5.camel@cuplxvomd02.corp.sa.net>
	<200811251345.11350.david-b@pacbell.net>
Cc: Bill Gatliff <bgat@billgatliff.com>, Wolfgang Denx <wd@denx.de>,
	linux-embedded@vger.kernel.org, dvomlehn@cisco.com,
	linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2008 at 3:45 PM, David Brownell <david-b@pacbell.net> wrote:
> No comment from me on $SUBJECT beyond "it seems plausible", but ...
>
> On Tuesday 25 November 2008, David VomLehn wrote:
>> The important point, though, is that device tree is the only
>> thing approaching a standard on any non-x86-based platform for passing
>> structured information from the bootloader to the kernel. The command
>> line is just not sufficient for this.
>
> Me, I'll be happier if I don't have to try using that device tree.
> Having board-specific code in the kernel is a more complete solution,
> and makes it a lot easier to cope with all the hardware goofage.

I disagree.

> Recall that the *original* notion behind OpenBoot (now "OpenFirmware")
> was to have tables for the stuff that was table-friendly, and call
> out to FORTH code (possibly not just at boot time) for the rest.
> (Given the choice of FORTH vs ACPI bytecodes, I'd go for FORTH; but
> the better option is "neither".)

The problem really is that Linux never really cared to run Forth code or even
keep the client interface for OF and 99% of the devices with real device
trees and real client interfaces, have really bad hardware support or methods
implemented that just don't work - not to mention the evil that happens on the
difference between Linux ABI and the OF ABI, the client interface context
switch, real-mode or virtual-mode firmwares.

The most useful thing is the representation of the devices in the device-tree.

I do however agree that sometimes FAR too much is being put into the
device trees,
the massive amount of overly verbose information about devices which do not need
the information there is just redundant. Reading processor registers out of the
device tree (such as the system version register on SoCs) is totally dumb, but
this was suggested at one time.

Once you match the driver with a compatible property, you're set; you know which
driver you're on. You can read out quirks and make inferences from
other parts of
the tree (this is something that most drivers do NOT do since people
think reading
outside the node just matched is some evil) where these are truly board-level
problems.

For instance where the ATA DMA lines are not connected on a 5200B board, this
must be described. Of course whether you decide this from the root
"model" property
and make a guess (all boards of fsl,broken5200  might have the bug) or
specifically
say in /soc/ata that "dma-is-broken" is the big question. In this
event, Grant came
up with a more fun solution which is to specify the maximum modes in
the device tree
therefore not bringing ANY board specific properties into it and
making sure you do not
clutter the driver with board specifics! This is exactly how device
trees should be designed.

Properties such as "fsl5200-clocking" in i2c nodes, is NOT. The
compatible property
of the node has fsl,mpc5200b-i2c, this implies 5200 clocking for the
i2c bus anyway. I
really don't get why this property even exists. It's not like there is
some alternative way
on the chip.. :D

> Right now I see an awful lot of work going into trying to force lots
> of stuff into table format.  Even when it's the sort of one-off or
> board-specific quirkery that was an original motivation for having
> FORTH escapes (tasks that were not table-friendly).

What about drivers where there is no binding for OF or Forth and never was and
never would/will be? There is no Forth escape for that.

Forth - and the client interface - should be used where necessary to
bring the system
up. This be modifying the device tree, implementing methods to boot
(it makes some
sense that if the ATA methods in the client interface work, then Linux
could load it's
own initrd without the help of Yaboot or GRUB, for example, right in
the boot wrapper,
and to the location it sees best to load it, and not what Yaboot
decides for it, and there
would be no need to maintain 4 different filesystem codes in 3
alternative loaders and
the kernel).

But unfortunately most systems have crap CIF support (ours included)
which do not
come up to the task.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
