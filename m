Message-ID: <3A37B08A.3FE08AF7@ssh.com>
Date: Wed, 13 Dec 2000 19:23:22 +0200
From: Arto Vuori <avuori@ssh.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Graham Stoney <greyham@research.canon.com.au>,
        Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <20001212182856.A8336@brixi.research.canon.com.au> <Pine.GSO.4.21.0012120933330.24199-100000@eos> <20001213121554.B17129@brixi.research.canon.com.au> <3A37A048.46E692A0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
> Although I have not yet proven this, I am leaning toward the following.
> Allocate a small fixed set of receive buffers (like we used to do)
> in the driver and mark them copy-back cached.  The received BDs will
> always point to thesed buffers.  Then, copy-and-sum these into IP
> aligned skbuffs.  The advantage of Graham's DMA into skbufs isn't that
> the driver doesn't copy/sum, it is that later when the IP stack does it
> we get burst transfers into cache.  So, we get this advantage plus
> the IP packet aligned properly for the remainder of the stack.  Of
> course, the downside of this is the receive buffers are one-time
> cached.  We blow the cache away to make the TCP benchmark look good,
> and the remaining applications suffer.  I still have a problem with
> this.....making single focused benchmarks look good isn't necessarily
> the best for the overall system application.

That might help on TCP performance with single benchmark application,
but i can't see much practical use for this. I have done some tweaking
on 8260 ethernet drivers and we implemented that DMA into skbufs
optimization. It gives significant performance boost when we are routing
packets. Actually we have gone so far favoring routing performance that
I disabled per packet RX & TX interrupts and poll FCC interface by using
timer interrupts. That gives some constant overhead, but also improves
routing performace if you are routing a lot of small packets. I think
that it reduces interrupt load and IP routing code runs in nice small
cache friendly loops moving data from one queue to another.

We also found and fixed some problems including:
* FCC driver leaked memory when there was too much incoming data.
* Some error conditions caused FCC to stop receiving and restart didin't
work.
* Both PHY and FCC must have same full/half Duplex mode settings. ie
Autonegotion result must be read using MII Managament interface.

When i have some time to clean up the code and make it work with some
standard board, i could send patches if anybody is interested.

	-Arto

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
