Date: Mon, 29 Dec 2003 03:50:10 -0600
From: Chris Zimman <chris@cryptoapps.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Question]DMA problem in Sil0680A...
Message-ID: <20031229095009.GA13346@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 29, 2003 at 01:16:17PM +0900, ?????? wrote:
>
> I'm trying to recognize IDE drive via Sil0680A driver
> in embedded linux enviroments. see below.
>
> * OS : denx(http://www.denx.de) linuxppc_devel_2.4 (2.4.23)
> * board : custom board for DVR
> * bootloader : u-boot 0.4.0
> * chipset : sil0680a(Siliconimage ultra ATA/133 PCI to ATA Host Controller)

[ snip ]

This could be one of at least a few things.  First, make sure that you're
actually getting the interrupt signaling the end of DMA.  See
drivers/ide/ide-dma.c:ide_dma_intr().

Without knowing how you have things wired up on the board, it's hard to give
definite suggestions about what might be wrong.  But in general, if you're
not getting the interrupt, check the interrupt routing etc. (found in
platforms/sycamore.c or whatever you called it if you've made a custom
setup for your board).

What external IRQ is the sil680 using?

By the looks of your PCI table, you also have a QLogic SCSI controller
on the board.  Have you tried that to see if it works?

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
