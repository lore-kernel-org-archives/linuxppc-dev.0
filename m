Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 1CB15DDFE6
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 17:19:38 +1000 (EST)
Date: Mon, 16 Jul 2007 09:19:36 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to add platform specific data to a of_device
Message-ID: <20070716071936.GK1678@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
	<20070716065144.GH1678@pengutronix.de>
	<1184569752.25235.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1184569752.25235.46.camel@localhost.localdomain>
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

On Mon, Jul 16, 2007 at 05:09:12PM +1000, Benjamin Herrenschmidt wrote:
> As I wrote a couple of times already, it's a perfectly acceptable
> approach to have "constructors" (what you call oftree-interpreter) that
> generate platform devices from the OF tree.

Great!

> > mapping. Is there a reason why there is sooo much interaction of the
> > platform code with the oftree? We usually have the situation that, if
> > something goes wrong, you have to change
> > 
> > 	- the driver
> > 	- the platform code
> > 	- the oftree
> 
> There should generally be no need to change the platform code.

Well, in reality it is, because for example the MPC52xx PSC SPI
controller we are currently working was obviously never tested with
oftree before it hit the mainline ...

> > and they often contain redundant information (like names of oftree
> > nodes, which change more often than some people's panties).
> 
> Well, they aren't supposed to :-) The problem at this point is more due
> to the fact that for things that haven't been specified by official OF
> bindings, people are going all over trying to define their own and
> sometimes conflicting bindings and then changing them.

I think it is a fundamental thing: the "we just have to wait long
enough, until oftree definitions have settled" proposal just isn't
right. It may be right for big irons, being well defined. But for the
embedded processors, too less people are working on it, plus we have too
much things which could be defined. Speaking of the MPC5200, look at how
often device tree names change, e.g. for mpc5200 vs. mpc52xx vs.
whatever. As long as things change, you have to keep the three locations
in sync manually, and that's bad.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
