Message-ID: <3D25E245.70303@embeddededge.com>
Date: Fri, 05 Jul 2002 14:15:33 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Walser, Martin" <mwalser@harris.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: no link changed interrupt
References: <8D4C69676E66D511A1CB00508BBBB1921BCF4D@ranmx1.ran.harris.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Walser, Martin wrote:

> Is there another way to get a link change without a hardware interrupt?

The only way to guarantee a link chnage interrupt is to use a PHY and
board design that supports a hardware interrupt.  Some boards/PHYs do
this, others do not, and it is a board specific design.  While you could
poll the PHY status at regular intervals, it would depend upon the PHY
status registers to properly publish/latch this information.  There isn't
sufficient information in the generic PHY registers to detect link change,
so again this is software that will have to be implemented unique to your
PHY (it's proprietary registers) and board design.

The only reason the FEC (or any 8xx/82xx Ethernet controller) needs to
see a link change is to properly configure full/half duplex.  It will
adapt to the different link speeds and other link attributes.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
