In-Reply-To: <Pine.LNX.3.96.1000412105423.25261A-100000@deepspace.mklinux.org>
Date: Wed, 12 Apr 2000 20:25:47 +0200
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
Message-Id: <20000412202547.009139@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Browsing the Darwin bmac driver source, I found some interesting comments:

 /*-------------------------------------------------------------------------
 * Work around a hardware bug where the controller will receive
 * unicast packets not directed to the station. The hardware is
 * erroneously using the hash table to qualify the unicast address.
 * This routine will check that the packet is unicast, and if so,
 * makes sure that the unicast address matches the station's address.
 * Thus function returns true if the packet should be rejected.
 *-------------------------------------------------------------------------*/

(This unicast filter workaround is enabled when the PCI device-id of the
chip is 0x10)


      /*
       * On the transmit side, we use the chipset interrupt. Using the
	   * transmit DMA interrupt (or having multiple transmit DMA entries)
	   * would allows us to send the next frame to the chipset prior the
	   * transmit fifo going empty.
       * However, this aggrevates a BMac chipset bug where the next frame
going
	   * out gets corrupted (first two bytes lost) if the chipset had to retry
	   * the previous frame.
       */

/*-------------------------------------------------------------------------
 * _sendDummyPacket
 * ----------------
 * The BMac receiver seems to be locked until we send our first packet.
 *
 *-------------------------------------------------------------------------*/


		/*
		 * The BMac Ethernet controller appends two bytes to each receive
		 * buffer containing the buffer
		 * size and receive frame status.
		 * We locate these bytes by using the DMA residual counts.
		 */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
