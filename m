From: gopi@india.tejasnetworks.com
Date: Fri, 31 Jan 2003 15:13:41 +0000 (GMT)
To: Allen Curtis <acurtis@onz.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: mpc 8260 performance..
In-Reply-To: <NCBBIINEHIPFGJPLBEIFIEKHEBAA.acurtis@onz.com>
Message-ID: <Pine.LNX.4.21.0301311456080.22077-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I understand a bit of Eth and skb code of linux.  One of my concerns
was interrupts.

In this case, the system can potentially be interrupted too
often(assuming an interrupt per frame received and transmitted,
it comes to nearly interrupt every few 10s of uSecs).  So, though the
packet processing doesnt take much time(involving movement of skbs
and modifying few fields), there is a hidden cost of context
swaps(kernel isr, bh, user space)

I am not sure of the effect of this on performance..

thanx
gopi

On Fri, 31 Jan 2003, Allen Curtis wrote:

> > interfaces: hdlc interfaces (external hdlc controller connected
> > to 8260 which
> >             can write to SDRAM directly.  Hence 8260 wont be
> > involved in packet copying).
> >
> > routing:
> >                              +------------+
> >                   Ethernet   | 8260 based |hdlc
> > External world <===========> | embedded   |----- 40 systems
> >                              | system     |-----
> >                              |            |-----
> >                              +------------+
> >
> > As you can see, the systems on hdlc are connected to external world
> > through the 8260 based embedded system.
> >
> > At peak, 8260 will have to get/send of all the hdlc interfaces and
> > route them to external world over Ethernet.
>
> The only processor overhead you should have is inspecting the HDLC packets
> and repackaging them for routing purposes. Take some time and learn the
> Ethernet and SKB portions of Linux. You should be able to preallocate all
> your buffers. The HDLC ASIC will DMA into RAM, the 8260 will DMA out the
> Ethernet packets. Achievable CPU utilization should be very low.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
