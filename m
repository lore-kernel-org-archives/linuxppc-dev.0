From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Iain Sandoe <iain@sandoe.co.uk>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
	Takashi Oe <toe@unlserve.unl.edu>
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
Date: Wed, 28 Mar 2001 14:15:47 +0200
Message-Id: <20010328121547.3542@mailhost.mipsys.com>
In-Reply-To: <20010328115447.EE3A9DB9E9@atlas.valhalla.net>
References: <20010328115447.EE3A9DB9E9@atlas.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>At 44k1 (fastest) this would occur every 363us (approx.).  That's a long
>time for the PCI bus to be locked up for (depending on how far ahead the
>controller tries to fetch the next block of data).
>
>anybody able to check?
>
>I don't think it's IRQ-blocking because the residue count in DEAD frames is
>non-zero (if the frame had finished but IRQs were blocked too long - I think
>the residue would have to be zero)...

I've heard about possible bugs in some DBDMA implementations that could cause
the DBDMA to fail is the bus was locked up for more than a few clock cycles.
the IDE DMA may cause such lockups.

Another issue (that may be related to your bmac issue, Takashi). It
appears that
one some older Apple PCI bridges, there could occasionally be some cache
coherency
issues (especially with transfers not aligned on a cache line boundary).
I think
Paul experienced some problems with the DEC ethernet controller of his old
PowerBook 3400 for example. It may be useful to flush the dbdma command buffer
after modifying and invalidate it before it gets modified by the controller...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
