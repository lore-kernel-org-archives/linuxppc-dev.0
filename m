Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <gopi@india.tejasnetworks.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc 8260 performance..
Date: Fri, 31 Jan 2003 06:33:55 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFIEKHEBAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.21.0301311412001.21680-100000@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> interfaces: hdlc interfaces (external hdlc controller connected
> to 8260 which
>             can write to SDRAM directly.  Hence 8260 wont be
> involved in packet copying).
>
> routing:
>                              +------------+
>                   Ethernet   | 8260 based |hdlc
> External world <===========> | embedded   |----- 40 systems
>                              | system     |-----
>                              |            |-----
>                              +------------+
>
> As you can see, the systems on hdlc are connected to external world
> through the 8260 based embedded system.
>
> At peak, 8260 will have to get/send of all the hdlc interfaces and
> route them to external world over Ethernet.

The only processor overhead you should have is inspecting the HDLC packets
and repackaging them for routing purposes. Take some time and learn the
Ethernet and SKB portions of Linux. You should be able to preallocate all
your buffers. The HDLC ASIC will DMA into RAM, the 8260 will DMA out the
Ethernet packets. Achievable CPU utilization should be very low.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
