Return-Path: <benh@kernel.crashing.org>
Subject: TSI ethernet PHY question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tie-fei.zang@freescale.com, alexandre.bounine@tundra.com
Content-Type: text/plain
Date: Wed, 23 May 2007 17:03:17 +1000
Message-Id: <1179903798.32247.918.camel@localhost.localdomain>
Mime-Version: 1.0
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
 
