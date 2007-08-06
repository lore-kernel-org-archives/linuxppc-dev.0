Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E4781DDEBD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:22:46 +1000 (EST)
Message-ID: <46B79F25.50205@s5r6.in-berlin.de>
Date: Tue, 07 Aug 2007 00:22:29 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce
	32bit	DMA	mapping"
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>	
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>	
	<1186272926.938.8.camel@localhost.localdomain>	
	<46B5824B.1000103@s5r6.in-berlin.de>	
	<1186351473.938.21.camel@localhost.localdomain>	
	<20070806135124.GA2900@suse.de>
	<1186436848.938.75.camel@localhost.localdomain>
In-Reply-To: <1186436848.938.75.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robert Hancock <hancockr@shaw.ca>, linuxppc-dev@ozlabs.org,
	stable@kernel.org, linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Oh and, don't do the set_dma_mask() in sbp2, it has nothing to do there.
> It should be in the ohci1394 driver.

That's not quite right.  OHCI-1394 implementations can go beyond 4GB bus
address space.  (Although I don't know if there are such implementations
available.  At least there are two implementations which can set the
so-called Physical Range bigger than 4GB.)

Sbp2 however requires that everything which it DMA-maps resides in the
Physical Range of the controller.  This way the CPU is not involved in
most of the data transfers.  The OHCI-1394 controller acts as bus bridge
between IEEE 1394 bus and local bus, with a 1:1 mapping of IEEE 1394 bus
addresses to and from local bus addresses --- but not in the whole 48
bits white IEEE 1394 bus address range, only in the
implementation-dependent Physical Range.  The minimum Physical Range
that all OHCI-1394 implementations guarantee is 4GB.  I could actually
have set a bigger mask in sbp2 when the controller supports a
programmable bigger range.

So that's the story why that dma_set_mask went into sbp2:  Sbp2 wants
mappings in a _subset_ of the OHCI-1394 controllers DMA range.

Anyway.  For now I will simply go with what 2.6.23-rc has and what
2.6.21 had:  No dma_set_mask anywhere in the 1394 subsystem.  We can
revisit this whenever an actual need arises.
-- 
Stefan Richter
-=====-=-=== =--- --==-
http://arcgraph.de/sr/
