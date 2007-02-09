Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E173ADDEB8
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 09:06:32 +1100 (EST)
Subject: Re: Discussion about iopa()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<1170969965.2620.345.camel@localhost.localdomain>
	<0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
Content-Type: text/plain
Date: Sat, 10 Feb 2007 09:06:20 +1100
Message-Id: <1171058780.6578.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-09 at 12:13 -0500, Dan Malek wrote:
> On Feb 8, 2007, at 4:26 PM, Benjamin Herrenschmidt wrote:
> 
> > I'm really not fan of it.
> 
> That's because I think it's a terribly useful function
> and the first step toward some orthogonal VM APIs. :-)

No, I think it's very inefficient to walk the page tables, even worse if
you have PTEs in HIGHMEM. I think it's better to keep track the physical
address from alloc time, something similar than dma_alloc_coherent but
for use with that MURAM thingy.

Cheers,
Ben.
 
