Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AC1767D06
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 14:30:44 +1000 (EST)
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <526188FB-0FE5-40BA-AB21-EB491BB24911@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
Date: Tue, 22 Aug 2006 23:30:35 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2006, at 9:20 PM, Zang Roy-r61911 wrote:

> The patch passes the UPIO_TSI flag to general 8259 serial driver
>
> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

Maybe, I'm missing something, but why do we need this?  Why doesn't  
iotype == UPIO_MEM work for the TSI?

- kumar

>
> ---
>  arch/powerpc/kernel/legacy_serial.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/legacy_serial.c
> b/arch/powerpc/kernel/legacy_serial.c
> index 359ab89..07c2c00 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -115,6 +115,7 @@ static int __init add_legacy_soc_port(st
>  	u64 addr;
>  	u32 *addrp;
>  	upf_t flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
> +	struct device_node *tsi = of_get_parent(np);
>
>  	/* We only support ports that have a clock frequency properly
>  	 * encoded in the device-tree.
> @@ -134,7 +135,10 @@ static int __init add_legacy_soc_port(st
>  	/* Add port, irq will be dealt with later. We passed a
> translated
>  	 * IO port value. It will be fixed up later along with the irq
>  	 */
> -	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ,
> flags, 0);
> +	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
> +		return add_legacy_port(np, -1, UPIO_TSI, addr, addr,
> NO_IRQ, flags, 0);
> +	else
> +		return add_legacy_port(np, -1, UPIO_MEM, addr, addr,
> NO_IRQ, flags, 0);
>  }
>
>  static int __init add_legacy_isa_port(struct device_node *np,
> @@ -464,7 +468,7 @@ static int __init serial_dev_init(void)
>  			fixup_port_irq(i, np, port);
>  		if (port->iotype == UPIO_PORT)
>  			fixup_port_pio(i, np, port);
> -		if (port->iotype == UPIO_MEM)
> +		if ((port->iotype == UPIO_MEM) || (port->iotype ==
> UPIO_TSI))
>  			fixup_port_mmio(i, np, port);
>  	}
>
> -- 
> 1.4.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
