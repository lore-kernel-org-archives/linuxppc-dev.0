Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4C034B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 08:16:07 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57C06DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 08:16:06 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6RMG2RC013637
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 15:16:03 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n6RMGDEm010320
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 17:16:14 -0500 (CDT)
Date: Mon, 27 Jul 2009 17:16:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mark Ware <mware@elphinstone.net>
Subject: Re: [RFC/PATCH] powerpc: Don't use alloc_bootmem in cpm_uart_cpm2.c
Message-ID: <20090727221601.GC19572@b07421-ec1.am.freescale.net>
References: <4A645A27.7040002@elphinstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A645A27.7040002@elphinstone.net>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 20, 2009 at 09:51:03PM +1000, Mark Ware wrote:
> This is another alloc_bootmem() -> kzalloc() change, this time to
> fix the non-fatal badness caused when booting with a cpm2_uart console.
> 
> Signed-Off-By: Mark Ware <mware@elphinstone.net>
> 
> ---
>  drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c 
> b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> index 141c0a3..a9802e7 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -132,7 +132,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, 
> unsigned int is_con)
>  	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
>  	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
>  	if (is_con) {
> -		mem_addr = alloc_bootmem(memsz);
> +		mem_addr = kzalloc(memsz, GFP_NOWAIT);
>  		dma_addr = virt_to_bus(mem_addr);
>  	}

Hmm, is dma_alloc_coherent() now available this early as well?  If so, we
could get rid of the separate "is_con" handling altogether.

-Scott
