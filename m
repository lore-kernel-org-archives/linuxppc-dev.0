Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C790679EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 04:14:38 +1000 (EST)
In-Reply-To: <4280B3CB.8030007@intracom.gr>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
	<4280985D.80108@intracom.gr>
	<f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
	<20050510062744.A21835@cox.net> <4280B3CB.8030007@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5c6ff84e194812ef41499dced5f7e29f@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 10 May 2005 14:14:23 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  03/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 10, 2005, at 9:14 AM, Pantelis Antoniou wrote:

> What's the recommended function to call to go from a
> virtual -> physical address, but without doing a cache
> flush/invalidate?

It doesn't have anything to do with cache flush/invalidate,
it has to do with the way the memory is mapped to a different
VM space.  You do not (and in some cases can't) perform
invalidate/flush on uncached addresses.

What we need to do is fix up the CPM allocation functions,
so when it does the dma_alloc_consistent (or whatever the
name is today) it keeps both the physical and virtual addresses.
When we call cpm_hostalloc(), it has to return both the physical
and virtual addresses, and the driver must take note of them.
I had this in the drivers at one time in 2.4, I don't know where
it went ......

The drivers themselves must do the dma_consistent_alloc
on large buffers, and also keep track of both physical and
virtual addresses.  Again, this was done once before ....


Thanks.


	-- Dan
