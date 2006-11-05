Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBF0567CA9
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 09:55:39 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id kA5MtXfl028434
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 16:55:34 -0600
Subject: APUS and IOs question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 06 Nov 2006 09:55:33 +1100
Message-Id: <1162767333.28571.254.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Somebody who understands APUS around ?

In include/asm-ppc/io.h, we have a special definition of the PCI IO
accessors readw,writew,readl and writel for APUS that don't do byteswap
and also don't do barriers.

This seems very bogus to me. Can somebody explain me why it's done that
way so I can then explain why it's broken ? :-)

I will remove those definitions soon, so unless I get a very convincing
argument of why it has to be done that way on APUS, things might break
(APUS-specific drivers relying on those not swapping will have to be
fixed).

Ben.
