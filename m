Message-ID: <D73A25AA6E54D511AD74009027B1110F3C05FA@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'acurtis@onz.com'" <acurtis@onz.com>,
	gopi@india.tejasnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: mpc 8260 performance..
Date: Fri, 31 Jan 2003 09:49:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also, if you go to Motorola's web page you can download a CPM performance
tool for the MPC8260.

-----Original Message-----
From: Allen Curtis [mailto:acurtis@onz.com]
Sent: Friday, January 31, 2003 9:34 AM
To: gopi@india.tejasnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: mpc 8260 performance..



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
