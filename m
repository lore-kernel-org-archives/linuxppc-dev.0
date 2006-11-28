Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2DF667A3B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 19:46:48 +1100 (EST)
Subject: Re: [PATCH] powerpc: fix OF pci flags parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061127212129.2484d68d@localhost.localdomain>
References: <20061127212129.2484d68d@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 19:46:37 +1100
Message-Id: <1164703597.5350.73.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-27 at 21:21 -0600, Olof Johansson wrote:
> For PCI devices with only io ports, of_bus_pci_get_flags() will fall
> through and still mark the resource as IORESOURCE_MEM.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Oops :-) 

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> This should be fine to hold until 2.6.20, since noone (as far as I
> know) has hit it in the wild.
> 
> 
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 346fb7b..0dfbe1c 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -160,9 +160,11 @@ static unsigned int of_bus_pci_get_flags
>  	switch((w >> 24) & 0x03) {
>  	case 0x01:
>  		flags |= IORESOURCE_IO;
> +		break;
>  	case 0x02: /* 32 bits */
>  	case 0x03: /* 64 bits */
>  		flags |= IORESOURCE_MEM;
> +		break;
>  	}
>  	if (w & 0x40000000)
>  		flags |= IORESOURCE_PREFETCH;
