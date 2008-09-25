Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 738F1DDF5A
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 07:41:29 +1000 (EST)
Subject: Re: MPC5200 PCI interrupt routing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080925165423.GA16018@secretlab.ca>
References: <200809221556.34353.jbe@pengutronix.de>
	<48D807C5.4070002@genesi-usa.com>
	<200809231334.19175.jbe@pengutronix.de>
	<200809241716.35285.jbe@pengutronix.de>
	<20080924181542.GA9690@secretlab.ca> <1222291345.8277.92.camel@pasglop>
	<20080925165423.GA16018@secretlab.ca>
Content-Type: text/plain
Date: Fri, 26 Sep 2008 07:41:22 +1000
Message-Id: <1222378882.8277.198.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I hadn't really wanted to go down this route because the calculation of
> the clock, or the decision to use an external clock or calculate an
> internal clock is very board specific.  I'll need to take another look
> to decide if it is reasonable to encode it into the device tree.

Could be done using the feature call mechanism that I have for
powermac... though using a proper clock framework might be better in the
long run.

> > I tend to thing that drivers should deal with their own clocks. In fact
> > it would be nice if one could stop the clocks while the host port is in
> > suspend no ?
> 
> Yeah, but in this case the clock can't actually be turned off.  It's
> just a select bit between internal or external clock and a calculation
> value on the divider.  Since it's a one-time board level setup
> config in a big block of shared chip level registers I'd rather just
> leave it in the domain of firmware.

Ah ok, makes more sense to keep it there then, or in platform init.

Ben.
