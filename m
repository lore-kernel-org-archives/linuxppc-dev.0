Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 60EA8DE032
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 00:48:55 +1000 (EST)
Message-ID: <48A05152.7020508@harris.com>
Date: Mon, 11 Aug 2008 10:48:50 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Possible bug in IRQ handling in pata_of_platform  / pata_platform
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think there is a bug in the communications between pata_of_platform
and pata_platform.  I will refer to the master branch of the DENX git
tree, which is roughly v2.6.26.1 at this time.  I am using a Sequoia
board with a PPC440EPx.

In pata_of_platform, we have:

    ret = of_irq_to_resource(dn, 0, &irq_res);
    if (ret == NO_IRQ)
        irq_res.start = irq_res.end = -1;

so if there is no interrupt defined, then start and end are -1. 
However, __pata_platform_probe has:

    if (irq_res && irq_res->start > 0) {
        irq = irq_res->start;
        irq_flags = irq_res->flags;
    }

You might think that the (irq_res->start > 0) test will fail, as it
should in this no-irq case.  But, start is a u64, so the -1 actually
looks like a large positive number in the comparison.  So,
__pata_platform_probe attempts to use an interrupt when there isn't one.

I think the fix would be to change __pata_platform_probe to:

    if (irq_res && irq_res->start != -1) {

but that might have other unintended consequences, so I'll defer to
whomever knows more about the intent of this code.

    Steve
