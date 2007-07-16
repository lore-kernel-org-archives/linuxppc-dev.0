Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7A453DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 17:08:03 +1000 (EST)
Date: Mon, 16 Jul 2007 08:51:44 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to add platform specific data to a of_device
Message-ID: <20070716065144.GH1678@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1184446133.6059.284.camel@localhost.localdomain>
Sender: Robert Schwebel <rsc@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 15, 2007 at 06:48:53AM +1000, Benjamin Herrenschmidt wrote:
> Your approach would work I suppose.... though it's a bit ugly.

Speaking of uggly, I'm still wondering why this oftree stuff for powerpc
must be soooo complicated. If you come from the ARM-linux world like we
do, the whole powerpc BSP stuff looks like a completely overengineered
piece of code, introducing complexity where it isn't necessary. But it
may be that it's just me not knowing powerpc kernel requirements deeply
enough :)

For most of the devices on for example the MPC5200B and MPC8260 I would
just model them as platform devices; there could be a simple

	oftree -> oftree-interpreter -> bunch of platform devices

mapping. Is there a reason why there is sooo much interaction of the
platform code with the oftree? We usually have the situation that, if
something goes wrong, you have to change

	- the driver
	- the platform code
	- the oftree

and they often contain redundant information (like names of oftree
nodes, which change more often than some people's panties).

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
