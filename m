Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FF01DDFB6
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 17:29:41 +1000 (EST)
Subject: Re: How to add platform specific data to a of_device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20070716071936.GK1678@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
	<20070716065144.GH1678@pengutronix.de>
	<1184569752.25235.46.camel@localhost.localdomain>
	<20070716071936.GK1678@pengutronix.de>
Content-Type: text/plain
Date: Mon, 16 Jul 2007 17:29:34 +1000
Message-Id: <1184570974.25235.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 09:19 +0200, Robert Schwebel wrote:

> I think it is a fundamental thing: the "we just have to wait long
> enough, until oftree definitions have settled" proposal just isn't
> right. It may be right for big irons, being well defined. But for the
> embedded processors, too less people are working on it, plus we have too
> much things which could be defined. Speaking of the MPC5200, look at how
> often device tree names change, e.g. for mpc5200 vs. mpc52xx vs.
> whatever. As long as things change, you have to keep the three locations
> in sync manually, and that's b 

I wouldn't expect things to change that much. I think MPC52xx is a bad
example of a worst case scenario. Also, as the core group of people
working on linux/ppc get more familiar with the device-tree, we should
get things right more quickly.

In the end, the problem with the device-tree is also it's strongest
advantage: it's extremely flexible :-) So yes, that causes that sort of
problem, but don't ignore the whole lot of problems that it solves by
not having to hard code knowledge of the gazillion ways a given chip can
be setup in drivers or the ability to pass along ancilliary informations
such as MAC addresses, UUIDs, etc... from the firmware to selected
devices in the tree, or the sane interrupt & address mapping (that's
really the two main reasons in fact).

Ben.
