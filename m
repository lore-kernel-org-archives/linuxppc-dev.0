Date: Thu, 6 Mar 2003 13:23:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: emanuel stiebler <emu@ecubics.com>
Cc: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EPIC_SERIAL_MODE, openpic_initsenses
Message-ID: <20030306202356.GC24584@ip68-0-152-218.tc.ph.cox.net>
References: <3E67A891.4010909@ecubics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E67A891.4010909@ecubics.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 06, 2003 at 12:59:13PM -0700, emanuel stiebler wrote:

> I'm using the serial mode on the EPIC, MPC8245. Some questions about the
> inittialisation, because it seems, that I'm the only one who doesn't use
> it in the IRQ direct mode. My "ttt_openpic_initsenses" table looks like:
> (The DUART interrupts are in twice, for the sake of discussion)

The Motorola LoPEC and Sandpoint X3 do as well.  Please read those files
and the comments surrounding the openpic_* calls there.  Among other
things..:

> static u_char ttt_openpic_initsenses[] __initdata = {
[snip]
> (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 11, CPCI_INTD */
> 0,	/* EPIC IRQ 12, not used */
> 0,	/* EPIC IRQ 13, not used */
> 0,	/* EPIC IRQ 14, not used */
> 0,	/* EPIC IRQ 15, not used */
> 0,	/* EPIC IRQ 16, I2C */
> 0,	/* EPIC IRQ 17, DMA CH0 */
> 0,	/* EPIC IRQ 18, DMA CH1 */
> 0,	/* EPIC IRQ 19, I2O */
> (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 20, DUART 0 */
> (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 21, DUART 1 */
> 0,0,0,0,0,0,0,0,0,0,		 /* 22 - 31  */
> 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 32 - 63  */
> 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 64 - 95  */
> 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 96 - 127 */
[snip]

You do _not_ need to be doing it like this, and this is quite probably
causing you problems.  Look at open_pic_set_sources.

If you're using kernel.org sources, the LoPEC support has made it into
2.4.21-pre4.  Otherwise use the linuxppc_2_4_devel tree
(http://penguinppc.org/dev/kernel.shtml)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
