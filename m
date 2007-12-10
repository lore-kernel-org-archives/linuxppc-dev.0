Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06EB5DE0C7
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:34:09 +1100 (EST)
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071210164255.GA4497@loki.buserror.net>
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
	<1197234799.6563.19.camel@pasglop>
	<9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
	<1197236326.6563.22.camel@pasglop>
	<20071210164255.GA4497@loki.buserror.net>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 07:32:09 +1100
Message-Id: <1197318729.8692.5.camel@pasglop>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-10 at 10:42 -0600, Scott Wood wrote:
> On Mon, Dec 10, 2007 at 08:38:46AM +1100, Benjamin Herrenschmidt wrote:
> > The more I think about it, the more I tend to agree that tagging isn't
> > necessary and you are right. We should just match the name against the
> > "compatible" property of the OF nodes (which mean we need to support
> > multiple matches though since "compatible" is a list of strings).
> 
> It may not be strictly necessary, but I think it's a good idea not just for
> safety reasons, but as an indication to the driver what additional
> information it has access to.  We could put a match data pointer in the i2c
> device, and have it be a valid node pointer if the match was an OF one (and
> a device-specific struct for a straight platform device, etc).  This could
> be useful if a device needs to have more properties than standard
> address/type/interrupt for some reason.

You don't need that much... On ppc64, all devices have an optional
device node pointer in struct device via the archdata, an we should do
that on ppc32 too (and will soon in order to merge some of the PCI & DMA
stuff anyway).

Ben.
