Date: Wed, 12 Apr 2000 22:06:32 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
In-Reply-To: <20000412202547.009139@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10004122158001.4942-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Apr 2000, Benjamin Herrenschmidt wrote:

> Browsing the Darwin bmac driver source, I found some interesting comments:
>
>       /*
>        * On the transmit side, we use the chipset interrupt. Using the
> 	   * transmit DMA interrupt (or having multiple transmit DMA entries)
> 	   * would allows us to send the next frame to the chipset prior the
> 	   * transmit fifo going empty.
>        * However, this aggrevates a BMac chipset bug where the next frame
> going
> 	   * out gets corrupted (first two bytes lost) if the chipset had to retry
> 	   * the previous frame.
>        */

Extremely ugly. Does this mean corruption even happens when using the
device interrupt? Anyway, we seem to be using the txdma interrupt so this
bug is what bites us probably.

> 		/*
> 		 * The BMac Ethernet controller appends two bytes to each receive
> 		 * buffer containing the buffer
> 		 * size and receive frame status.
> 		 * We locate these bytes by using the DMA residual counts.
> 		 */

Need to allocate large enough receive buffers here :-) That's already
taken care of:
	/* initialize list of sk_buffs for receiving and set up recv dma
*/
	if (!bp->rx_allocated) {
	        for (i = 0; i < N_RX_RING; i++) {
	                bp->rx_bufs[i] = dev_alloc_skb(RX_BUFLEN+2);
                        if (bp->rx_bufs[i] == NULL) return 0;
	                skb_reserve(bp->rx_bufs[i], 2);
	        }
	        bp->rx_allocated = 1;
	}

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
