Return-Path: <richard_williams@stratexnet.com>
Received: from ExchWENZ02.wenz.global.vpn (unknown [202.27.34.1])
	by ozlabs.org (Postfix) with ESMTP id 5D9002BC0F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2004 15:18:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 21 Oct 2004 18:06:50 +1300
Message-ID: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
From: "Richard Williams" <richard_williams@stratexnet.com>
To: "Jeff Angielski" <jangiels@speakeasy.net>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
Cc: 
Subject: RE: SCC UART stalling/hanging - progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think you might have the same problem that I came across some time =
ago. I posted this but got no reply and never had time to fully =
investigate and test my solution since the problem (noise on receive) =
was fixed in hardware.

http://article.gmane.org/gmane.linux.ports.ppc.embedded/3884/match=3D8xx+=
uart+driver+problems

I think there is a bug in the driver where the interrupt is being =
cleared in the wrong place. My final solution was to move the clearing =
of events to be before receive_chars().=20

		events =3D sccp->scc_scce;
		sccp->scc_scce =3D events;   // <- Clear events here
		if (events & (SCCM_RX | SCCM_BSY)) //Process rx when busy
occurs
			receive_chars(info);
		if (events & SCCM_TX)
			transmit_chars(info);
		// sccp->scc_scce =3D events;     <- Old clear events position

This way any new rx interrupts that occur while transmit_chars() is =
executing will not get lost.

Regards,
Richard


-----Original Message-----
From: linuxppc-dev-bounces@ozlabs.org
[mailto:linuxppc-dev-bounces@ozlabs.org]On Behalf Of Jeff Angielski
Sent: Thursday, October 21, 2004 4:51 PM
To: linuxppc-dev
Subject: SCC UART stalling/hanging - progress



It appears that the SCC UART is stalling when I perform loopback testing
at 230kbps because the bottom half is sometimes not being executed when
the transmit interrupt is received by the ISR.  Because of this, no more
data is being put into the TX buffers and the SCC is sitting there dumb
and happy with nothing to do. =20

Using the BDI2000 I have been able to confirm that at the point when the
SCC stalls, the SCC registers, parameter ram, BDs, and buffers all look
good.  There are no pending events, the flags in the BDs are consistent
with an idle condition, and the tx buffers match the rx buffers which
match the data received by the user space application.

Specifically, problem that I see is that when transmit_chars() is called
from rs_8xx_interrupt(), the TX_WAKEUP flag is not set.  This means that
rs_sched_event() is never called and everything stalls.  The bad thing
is that the TX_WAKEUP is only modified in a handful of places and it is
not obvious as to how a race condition could occur.

Does anybody have any ideas or suggestions on what to look at next?

TIA,
Jeff Angielski







_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
