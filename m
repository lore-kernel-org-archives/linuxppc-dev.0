Message-ID: <3A37A048.46E692A0@mvista.com>
Date: Wed, 13 Dec 2000 11:14:00 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <20001212182856.A8336@brixi.research.canon.com.au> <Pine.GSO.4.21.0012120933330.24199-100000@eos> <20001213121554.B17129@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> This does indeed sound better; the only sticky part I can think of is setting
> the FCC/FEC to keep giving you Rx interrupts even when there are no buffer
> descriptors to put the incoming packets in,


Although I have not yet proven this, I am leaning toward the following.
Allocate a small fixed set of receive buffers (like we used to do)
in the driver and mark them copy-back cached.  The received BDs will
always point to thesed buffers.  Then, copy-and-sum these into IP
aligned skbuffs.  The advantage of Graham's DMA into skbufs isn't that
the driver doesn't copy/sum, it is that later when the IP stack does it
we get burst transfers into cache.  So, we get this advantage plus
the IP packet aligned properly for the remainder of the stack.  Of
course, the downside of this is the receive buffers are one-time
cached.  We blow the cache away to make the TCP benchmark look good,
and the remaining applications suffer.  I still have a problem with
this.....making single focused benchmarks look good isn't necessarily
the best for the overall system application.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
