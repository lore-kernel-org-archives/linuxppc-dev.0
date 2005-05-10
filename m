Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0875B679E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 22:14:12 +1000 (EST)
In-Reply-To: <4280985D.80108@intracom.gr>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
	<4280985D.80108@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 10 May 2005 08:13:48 -0400
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


On May 10, 2005, at 7:17 AM, Pantelis Antoniou wrote:

> This patch replace iopa use with virt_to_phys.

Not gonna work .....

When you map uncached on 8xx you get a new vmalloc()
space.  The virt_to_xxx macros don't work on those addresses.
You need to use the dma_consistent() function, stash the
real physical address it returns and then use it where
appropriate.

> +	W32(ep, fen_genfcc.fcc_rbase, virt_to_phys(fep->rx_bd_base));
> +	W32(ep, fen_genfcc.fcc_tbase, virt_to_phys(fep->tx_bd_base));

I thought you were getting rid of these weirdo macros and
write normal code for data structure access?  Please .....

Thanks.


	-- Dan
