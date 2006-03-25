Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B63F667A45
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 23:44:51 +1100 (EST)
Subject: Re: [PATCH] powerpc: legacy_serial loop cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mikey@neuling.org
In-Reply-To: <20060324041727.F131267B56@ozlabs.org>
References: <20060324041727.F131267B56@ozlabs.org>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 23:44:32 +1100
Message-Id: <1143290672.3710.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static void __init setup_legacy_serial_console(int console)
> +{
> +	if (console >= 0) {
> +		struct legacy_serial_info *info =
> +			&legacy_serial_infos[legacy_serial_console];
> +		void __iomem *addr;
> +
> +		if (info->taddr == 0)
> +			return;
> +		addr = ioremap(info->taddr, 0x1000);
> +		if (addr == NULL)
> +			return;
> +		if (info->speed == 0)
> +			info->speed = udbg_probe_uart_speed(addr, info->clock);
> +		DBG("default console speed = %d\n", info->speed);
> +		udbg_init_uart(addr, info->speed, info->clock);
> +	}
> +	return;

Hrm... What is the point of having a function ending with return; ?

What about, instead, something like:

	if (consoles < 0)
		return;
	do shit ...


Ben.
