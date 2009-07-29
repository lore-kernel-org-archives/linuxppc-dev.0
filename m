Return-Path: <mware@elphinstone.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C17B1B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jul 2009 13:46:07 +1000 (EST)
Received: from ipmail04.adl2.internode.on.net (ipmail04.adl2.internode.on.net
	[203.16.214.57]) by ozlabs.org (Postfix) with ESMTP id 5671BDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 13:46:05 +1000 (EST)
Message-ID: <4A6FC5FA.4040405@elphinstone.net>
Date: Wed, 29 Jul 2009 13:46:02 +1000
From: Mark Ware <mware@elphinstone.net>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC/PATCH] powerpc: Don't use alloc_bootmem in cpm_uart_cpm2.c
References: <4A645A27.7040002@elphinstone.net>
	<20090727221601.GC19572@b07421-ec1.am.freescale.net>
In-Reply-To: <20090727221601.GC19572@b07421-ec1.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Mon, Jul 20, 2009 at 09:51:03PM +1000, Mark Ware wrote:
>> This is another alloc_bootmem() -> kzalloc() change, this time to
>> fix the non-fatal badness caused when booting with a cpm2_uart console.
>>
>> Signed-Off-By: Mark Ware <mware@elphinstone.net>
>>
>> ---
>>  drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c 
>> b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
>> index 141c0a3..a9802e7 100644
>> --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
>> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
>> @@ -132,7 +132,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, 
>> unsigned int is_con)
>>  	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
>>  	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
>>  	if (is_con) {
>> -		mem_addr = alloc_bootmem(memsz);
>> +		mem_addr = kzalloc(memsz, GFP_NOWAIT);
>>  		dma_addr = virt_to_bus(mem_addr);
>>  	}
> 
> Hmm, is dma_alloc_coherent() now available this early as well?  If so, we
> could get rid of the separate "is_con" handling altogether.
> 
> -Scott
> 

This was my first thought as well, but calling dma_alloc_coherent() on a console resulted in a hang on boot before any console output.
I have no actual proof, but it seems likely that it is not available at that point in the boot.

Regards,
Mark
