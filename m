Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B9AF67CCC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 13:36:26 +1000 (EST)
Subject: Re: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 13:36:03 +1000
Message-Id: <1156304163.8433.19.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2006-08-23 at 10:20 +0800, Zang Roy-r61911 wrote:
> The patch passes the UPIO_TSI flag to general 8259 serial driver

Patch looks damaged to me... appart from that, what it does looks ok to
me.

> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com> 
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
