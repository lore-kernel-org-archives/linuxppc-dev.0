Return-Path: <Alexandre.Bounine@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	by ozlabs.org (Postfix) with ESMTP id 03927DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 23:59:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: TSI ethernet PHY question
Date: Wed, 23 May 2007 09:43:43 -0400
Message-ID: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
In-Reply-To: <1179903798.32247.918.camel@localhost.localdomain>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

The BCM PHY workaround is exactly for the Holly board with BCM5461A on
it.  The BCM54xx option which is confusing in this context originally
was used with board type option (other boards used BCM PHY). The
workaround added for Holly is caused by use of BCM5461A
Quality/TXC_RXC_DELAY pin.

This pin is a dual function pin. In normal operation, it is used to
drive an LED to indicate signal quality. The LED connected to this pin
acts as a pull up to VCC.

On power up, because this pin is pulled high by the LED, the
TXC_RXC_DELAY mode is enabled, causing a 1.9ns delay between the clock
and data on the GMII interface. Tsi109 could not operate properly with
this delay. The TXC_RXC_DELAY mode has to be disabled by software.

If the Quality/TXC_RXC_DELAY pin is left not connected PHY will work in
normal mode without delay and therefore the workaround is not required.
=20
>>In addition I'd like to know if the driver is known to be used in
>>situations where the PHY ID cannot be probed via MDIO ?=20

No.

>>I'm basically contemplating moving the driver to the generic phylib,
>>which would mean adding a phylib specific driver for that broadcom
chip
>>that contains that workaround, but I need to know which exact chip=20=20
>>revision needs it.

I think that for situations like one on the Holly board we may need
board-specific hooks which modify normal initialization. As in our case:
no LED - no trouble.

I have put into my plans switching Tsi108/9 driver to common PHY lib
(after Josh released his patch for Holly) but it looks like you will
beat me here - I still have to close some other tasks. Let me know if I
can help with anything around Tsi109.

Alex.


=20
-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Wednesday, May 23, 2007 3:03 AM
To: tie-fei.zang@freescale.com; Alexandre Bounine
Cc: linuxppc-dev list; David Gibson
Subject: TSI ethernet PHY question

Hi Folks !

While investigating some trouble we've had with networking on an Holly
eval board (TSI109 with IBM 750CL and Broadcom 5461A), I've had a look
at the PHY management code. There, it has a little workaround for
BCM54xx PHYs writing some hard coded values to some broadcom private
registers.

It's my experience that every revision of broadcom PHY around needs
different workarounds in different places though. Thus, I'd like to
better understand:

 - What is this workaround necessary for ?
 - What exact PHY model & version is it for ?

In addition I'd like to know if the driver is known to be used in
situations where the PHY ID cannot be probed via MDIO ?

I'm basically contemplating moving the driver to the generic phylib,
which would mean adding a phylib specific driver for that broadcom chip
that contains that workaround, but I need to know which exact chip
revision needs it. There are lots of BCM 54xx and I'm pretty sure for
example that this won't be needed on a BCM 5411 for example (or a
different one). In fact, I do intend to port sungem to phylib as well
which mean that I'll dump a whole load of BCM PHY specific drivers in
there.

Cheers,
Ben.
=20


---=0D
=0D
Important Notice: This message is intended for the use of the individual to=
 whom it is addressed and may contain information which is privileged, conf=
idential and/or exempt from disclosure under applicable law. If the reader =
of this message is not the intended recipient, or is not the employee or ag=
ent responsible for delivering the message to the intended recipient, you a=
re hereby notified that any dissemination, distribution, or copying of this=
 communication is strictly prohibited. If you have received this communicat=
ion in error, please notify the sender immediately by telephone or return e=
-mail and delete the original message from your systems. Thank you. =0D
