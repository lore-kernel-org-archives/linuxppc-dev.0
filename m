Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id D323D679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 23:31:12 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4ADZn7v001370
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 16:35:52 +0300 (EEST)
Message-ID: <4280B3CB.8030007@intracom.gr>
Date: Tue, 10 May 2005 16:14:51 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
	<4280985D.80108@intracom.gr>
	<f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
	<20050510062744.A21835@cox.net>
In-Reply-To: <20050510062744.A21835@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Matt Porter wrote:
> On Tue, May 10, 2005 at 08:13:48AM -0400, Dan Malek wrote:
> 
>>On May 10, 2005, at 7:17 AM, Pantelis Antoniou wrote:
>>
>>
>>>This patch replace iopa use with virt_to_phys.
>>
>>Not gonna work .....
>>
>>When you map uncached on 8xx you get a new vmalloc()
>>space.  The virt_to_xxx macros don't work on those addresses.
>>You need to use the dma_consistent() function, stash the
>>real physical address it returns and then use it where
>>appropriate.
> 
> 
> That and the use of virt_to_* and friends is deprecated by
> the DMA API. You'll never get that upstream even if it were
> a case where it did work.  That's a good thing to know for
> anybody doing other drivers...
> 
> -Matt
> 
> 

OK then.

What's the recommended function to call to go from a
virtual -> physical address, but without doing a cache
flush/invalidate?

Regards

Pantelis
