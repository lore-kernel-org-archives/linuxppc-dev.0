Date: Mon, 4 Aug 2003 10:24:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: new code for an mpc8xx board (dbox2)
Message-ID: <20030804172428.GD20708@ip68-0-152-218.tc.ph.cox.net>
References: <1059878529.665.50.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1059878529.665.50.camel@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 03, 2003 at 04:42:09AM +0200, Andreas Oberritter wrote:

> Hi,
>
> I'd like to get support for the dbox2, which is a DVB receiver with an
> mpc823 cpu, into the linux kernel, to make it bootable without
> further patching. Since I am new to submitting kernel patches, I don't
> know who to ask best for inclusion. Benjamin Herrenschmidt pointed me to
> this mailing list.
>
> On which kernel tree shall patches be based to get into vanilla 2.4?
>
> The current patchset against linux-2.4.22-pre6 can be viewed via webcvs
> at http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/tuxbox/cdk/Patches/
>
> I will create a new set as soon as I know which tree to use best.

Patches against current 2.4 are the best way for 8xx changes.  However,
it's probably too late to get it into 2.4.22, but I can put these
changes into a tree for 2.4.23-pre1.

> I'd also like to know if there is a better way to handle edge triggered
> interrupts on 8xx than it is done in
> linux-2.4.22-pre6-dbox2-irq.diff. Should CONFIG_DBOX2 be removed in this
> patch or maybe replaced by CONFIG_8xx?

Which interrupt is being generated that requires this change?

> I think linux-2.4.22-pre6-dbox2-board.diff is a trivial patch and will
> not offend any other boards.

If you use PPCBoot / U-Boot, you do not need to fill out an embed_config
routine, and it's OK to let zImage fail.  Aside from that, the patch is
fine, and I can add it to a tree to get Marcelo to pull from for
2.4.23-pre1 if you like.

> linux-2.4.22-pre6-dbox2-watchdog.diff is needed because the
> bootloader of this board enables the watchdog. Since it is a generic
> implementation for handling an 8xx watchdog, I'd add CONFIG_8xx_WATCHDOG
> for it instead of CONFIG_DBOX2, if no one complains.

Since you have to define PITRTCLK, and there's magic numbers (and I
don't have time at the moment to dig into the watchdog docs, cursed
classes..) are you sure this is all generic 8xx code, and that those
numbers wouldn't be board-specific?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
