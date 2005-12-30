Return-Path: <oliver.hartkopp@volkswagen.de>
Received: from mailgate1.volkswagen.de (mailgate1.volkswagen.de
	[194.114.62.42]) by ozlabs.org (Postfix) with ESMTP id 0F3F46891B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 05:10:34 +1100 (EST)
Message-ID: <0BC6CCCB3D723E468B124BF3115CC912361D2E@vwagwox00010.vw.vwg>
From: "Hartkopp, Oliver (K-GEFE/E)" <oliver.hartkopp@volkswagen.de>
To: The Linux Socket CAN Framework <socket-can@pengutronix.de>
Date: Fri, 30 Dec 2005 19:00:54 +0100
MIME-Version: 1.0
Content-Type: text/plain
Cc: David Jander <david.jander@protonic.nl>, "Thuermann, Urs,
	Dr. \(K-GEFE/I\)" <urs.thuermann@volkswagen.de>,
	linuxppc-embedded@ozlabs.org, 'Jan Kiszka' <kiszka@rts.uni-hannover.de>
Subject: AW: [Socket-can] Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

> Robert Schwebel wrote:
> > ...
> > In december, we have made a synchronisation meeting with the VW people
> > who made the initial port for 2.4; they are more focussed on having
> > higher level transport protocols ontop of the "raw" socket interface we
> > currently use. During that process we have reviewed the user interface
> > with regard to their use cases, so it will have to be changed a little
> > bit before we have something which is in a state to be posted on lkml.
> > 

To be more correctly: Our focus is more on content-filtering of cyclic
sent and received CAN-messages as well as on CAN-transport-protocols
like ISO-TP (where two CAN-IDs are used to implement a point-to-point
connection via the CAN-Bus by segmenting long (means >8 Byte) PDUs).

The transport protocols and the so called "Broadcast-Manager" (for
content-filtering, cyclic sending, RTR-Handling, Timeout-Handling) are
not ontop the RAW-socket but arranged /next/ to the CAN_RAW-protocol in
the protocol-family PF_CAN. You may find a picture of this 'arrangement'
in the first hit of 'PF_CAN' in google (sorry it's german - figure page 5):

http://www.network-on-wheels.de/downloads/VDE2004_Luebke_Paper.pdf

As we had some problems to publish our software, we shared our ideas with
Robert, Jan and Benedikt who have been working on the same problems in 2004.

We are now bringing our implementations and APIs together, to publish a
real Kernel-proof implementation for PF_CAN. Fortunately our implementations
do not differ in core-things so it's just a bit cosmetic on both sides.
Btw. VW has a Kernel 2.4 implementation and Robert and Benedikt have a
Kernel 2.6 port - so it becomes a win-win-situation for both sides ... :-)

> Jan Kiszka wrote:
>
> Beyond the outstanding comparably minor API adjustments, we furthermore
> discussed first ideas how to define the lowest interface, i.e. the CAN
> network device layer. That should be done in a way which makes porting
> CAN low-level drivers between the standard kernel and a real-time Linux
> CAN stack trivial. That's a unique chance (compared to the situation of
> RTnet e.g.), so we should take it.
> 
> (..) This means we could end up with portable CAN
> applications and drivers, RT and non-RT!
> 

As the RTDM and a 'standard'-netdevice are quite similar (in opposite to
the former used char-devices for CAN-drivers) it should be quite easy to
create some kind of CAN-HW-abstraction layer to fit the bare controller
access into a netdevice and respectively a RTDM-device. As both sides
currently support various CAN-controllers this is a really good chance
to bring not only the socket-API (for the user software) but the low
level can driver API (for the driver developer) together.

> As Robert said, it "just" requires some resources for implementing
> this... ;)

I'm looking forward to create this CAN-HW-abstraction layer with Jan and
Robert, as i assume the required ressources to be melting down after a
initial work that is done together in the approved way. After this is
defined, it shall be very easy for driver developers to make their CAN-HW
work as netdevice / RTDM-device. So every work is just done once.

Finally i wish you a happy new year in advance! May 2006 be the year of
excellent
(and settled) CAN-concepts inside the Linux kernel for all of us ;-)

Best regards,

Oliver
