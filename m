Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 313F3DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 07:23:48 +1000 (EST)
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710030739k13e05571l7063aa635a8727dc@mail.gmail.com>
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk>
	<fa686aa40710020910u3a679ea2m15b005d0ba5fb054@mail.gmail.com>
	<1191365012.22572.33.camel@pasglop>
	<fa686aa40710022118r170ab652mdd65c216304b3330@mail.gmail.com>
	<1191385456.22572.45.camel@pasglop>
	<fa686aa40710030739k13e05571l7063aa635a8727dc@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 07:21:40 +1000
Message-Id: <1191446500.22572.94.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-03 at 08:39 -0600, Grant Likely wrote:
> Right, okay.  Looking at platform_device_add(), the default parent is
> platform_bus, but it can be overridden.  of_platform_bus devices get
> the hierarchy of the device tree by default.  So in the platform bus
> case, the constructor would need to explicitly set the parent device?
> Correct?
> 
> Also, how do you see the constructor code getting executed?  Called
> explicitly from the platform code, or some form of auto binding?  I
> look at fsl_soc.c and I shudder as each constructor does a pass of the
> whole tree looking for compatible nodes.

My idea was to have some platform code at boot walk the DT and call the
constructors on the way, passing them the parent. Constructors return a
struct device * so it would keep track of who is where.

Drivers or platform code can then register constructors along with of
match tables.

Ben.
 
