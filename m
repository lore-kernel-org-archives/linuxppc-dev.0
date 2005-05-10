Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 5BD80679E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 22:31:59 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4ACabjn023221
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 15:36:39 +0300 (EEST)
Message-ID: <4280A5EB.4000306@intracom.gr>
Date: Tue, 10 May 2005 15:15:39 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
	<4280985D.80108@intracom.gr>
	<f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
In-Reply-To: <f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
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

Dan Malek wrote:
> 
> On May 10, 2005, at 7:17 AM, Pantelis Antoniou wrote:
> 
>> This patch replace iopa use with virt_to_phys.
> 
> 
> Not gonna work .....
> 
> When you map uncached on 8xx you get a new vmalloc()
> space.  The virt_to_xxx macros don't work on those addresses.
> You need to use the dma_consistent() function, stash the
> real physical address it returns and then use it where
> appropriate.
> 

Hmm. Correct. The dma_consistent() function will
do some cache flushing, but we don't really care about that
anyway.

Oh well. Patch will be forthcoming...

>> +    W32(ep, fen_genfcc.fcc_rbase, virt_to_phys(fep->rx_bd_base));
>> +    W32(ep, fen_genfcc.fcc_tbase, virt_to_phys(fep->tx_bd_base));
> 
> 
> I thought you were getting rid of these weirdo macros and
> write normal code for data structure access?  Please .....
> 

This is going to be difficult since the /net/drivers maintainer
insists on using them. I used to have direct data structure
accesses so it won't be difficult to change.

But we must have a consunsus.

> Thanks.
> 
> 
>     -- Dan
> 
> 
> 

Regards

Pantelis
