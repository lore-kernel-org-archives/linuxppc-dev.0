Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1C6A5679FC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 08:34:54 +1000 (EST)
Date: Thu, 2 Jun 2005 15:35:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Message-Id: <20050602153540.53486bde.akpm@osdl.org>
In-Reply-To: <20050601105145.B15351@cox.net>
References: <20050601105145.B15351@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] cpm_uart: Route SCC2 pins for the STx GP3 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> +++ uncommitted/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
> @@ -134,12 +134,21 @@
>  
>  void scc2_lineif(struct uart_cpm_port *pinfo)
>  {
> +	/*
> +	 * STx GP3 uses the SCC2 secondary option pin assignment
> +	 * which this driver doesn't account for in the static
> +	 * pin assignments. This kind of board specific info
> +	 * really has to get out of the driver so boards can
> +	 * be supported in a sane fashion.
> +	 */
> +#ifndef CONFIG_STX_GP3
>  	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
>  	io->iop_pparb |= 0x008b0000;

Silly question: why is this driver using a volatile pointer to
memory-mapped I/O rather than readl and writel?
