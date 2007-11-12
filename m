Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11175DDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 16:07:26 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lAC57Kj3014198
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 23:07:21 -0600
Subject: of_iomap confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 12 Nov 2007 16:07:18 +1100
Message-Id: <1194844038.18185.23.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just noticed this of_iomap() helper thing we have in prom_parse.c
nowadays.

It's a bit confusing as "iomap" is generally what we use to name the new
iomap interface (ioport_map, pci_iomap, ...) and that requires
-different- accessors than memory obtained from ioremap.

This I think this needs to be changed.

We should call it of_ioremap() or of_map_resource() and if we want an
of_iomap(), it should provide an iomap token, not an ioremap address
(they look the same on powerpc, but they shouldn't be mixed up).

Ben.
