Date: Wed, 28 Mar 2001 13:26:04 +0100
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>,
	takashi oe <toe@unlserve.unl.edu>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328122602.E5EA8DB9EE@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Paul experienced some problems with the DEC ethernet controller of his old
> PowerBook 3400 for example. It may be useful to flush the dbdma command buffer
> after modifying and invalidate it before it gets modified by the controller...

OK, that's not too difficult - we get a chance to do this before the cmd
block is queued on TX... and after we read the data on RX.

(although we don't *seem* to be seeing a coherency problem here - the
xfer_status is {AFAICT} getting updated properly for dmasound).

I'll figure it into the next lot of changes.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
