Date: Tue, 27 Mar 2001 08:30:13 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: "Michael R. Zucca" <mrz5149@acm.org>
Cc: phandel@cise.ufl.edu,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage
In-Reply-To: <l03130301b6e64356789c@[24.218.240.205]>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010327082411.54638A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Mar 2001, Michael R. Zucca wrote:

> I'd be willing to bet this is the dbdma bug Iain mentioned. Like the dma
> controller's getting wedged and the driver waits and waits for it to
> complete a transaction. I can wait for the fix.

It sounds exactly like the bmac bug.  So changing pmac_awacs_tx_intr()
from

	while (write_sq.active > 0) {
		...
		if ((stat & ACTIVE) == 0)
			break;	/* this frame is still going */
		...
	}

to

	while (write_sq.active > 0) {
		...
		if ((stat & ACTIVE) == 0) {
			if (cp == bus_to_virt(in_le32(&awacs_txdma->cmdptr)))
				break;
		}
		...
	}

fixes it or something?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
