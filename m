Message-ID: <3A2322FB.ECCD2CA2@mvista.com>
Date: Mon, 27 Nov 2000 22:14:03 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
References: <Pine.GSO.4.21.0011271651000.493-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:


> Does Linux support the CTX-1170 MII?  The arch/ppc/8260_io/fcc_enet.c
> source code talks about the QS6612.  Will I need to extended fcc_enet.c to
> support the CTX-1170?

That driver either "supports" any PHY, or none at all, depending upon
your perspective.  None of the command/status MII interface is in
place to do anything.  None of those functions are called in the
driver.  The QS6612 comment is left over from the 860T FEC driver I
copied to get the framework for the FCC driver.

The Linux 8260 FCC driver works with the supplied EST hardware and the
CTX-1170 I have.  I know it doesn't work on some others, and I don't
know if they use the same Ethernet PHY or the deal of the week.

>From looking at the drivers, it appears they are a little out of
date.  I have a newer one (that I was certain I checked in) that will
interrogate the PHY.  In any case, this driver should work fine on
any half duplex Ethernet, and you should see transmit packets in any
case.

> I know that the hardware can work, because the VxWorks boot rom loads
> Linux successfully via this interface and MII.

Then the driver must not be configuring the I/O lines correctly for
some unknown reason, or you are running full duplex without the FCC
initialized to do that.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
