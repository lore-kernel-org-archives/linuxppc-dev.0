Date: Sun, 19 Sep 1999 21:17:07 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: Shaw Terwilliger <sterwill@io.nu>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sound sleep
In-Reply-To: <37E51662.8ACADA16@execpc.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990919205431.1091A-100000@ofey.inebraska.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 19 Sep 1999, Joseph Garcia wrote:

> i have this problem ony my wallstreet/300 also.  I don't know of a fix yet.  A
> temporary way around it would be to make a module of dmasound, and rmmod it
> before sleeping, and insmodding it after, however it seems that this code is
> also broken.  interrupt allocation.  will panic upon a 3rd insmod, or a cat of
> /proc/interrupts while it is not installed.  If this were fixed, i'd think the
> sleeping issue would be a snap.

Try changing the last argument of request_irq() in PMacIrqInit() and
free_irq() in PMacIrqCleanup().  For example, change
	request_irq(awacs_irq, pmac_awacs_intr, 0, "AWACS", 0)
and
	free_irq(awacs_irq, pmac_awacs_intr)
to
	request_irq(awacs_irq, pmac_awacs_intr, 0, "AWACS", (void *)awacs)
and
	free_irq(awacs_irq, (void *)awacs).
I think that's what I did in order to get rid of the panic.

For the wake up problem, does it help if you put the code similar to the
following in awacx_sleep_notify()?

before enable_irq()'s:

	oöout_le32(&awacs_txdma->control, (RUN|WAKE|FLUSH|PAUSE) << 16

after enable_irq()'s:
	st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
	out_le32(&awacs->control, (in_le32(&awacs->control) & ~0x1f00)
		| ((awacs_revision < AWACS_BURGUNDY)? BEEP_SPEED:0) << 8);
	out_le32(&awacs_txdma->cmdptr, virt_to_bus(beep_dbdma_cmd));
	out_le32(&awacs_txdma->control, RUN | (RUN << 16));


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
