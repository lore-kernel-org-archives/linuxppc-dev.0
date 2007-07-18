Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC011DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 20:18:38 +1000 (EST)
Date: Wed, 18 Jul 2007 12:00:22 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 52/61] cpm_uart: Issue STOP_TX command before
	initializing console.
Message-ID: <20070718120022.1b007937@localhost.localdomain>
In-Reply-To: <20070718013608.GX15238@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013608.GX15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007 20:36:08 -0500
Scott Wood wrote:

> This prevents some bootloader/bootwrapper characters from being lost.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  drivers/serial/cpm_uart/cpm_uart_core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
> b/drivers/serial/cpm_uart/cpm_uart_core.c index 805ca46..7772c87
> 100644 --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -1310,6 +1310,8 @@ static int __init cpm_uart_console_setup(struct
> console *co, char *options) udbg_putc = NULL;
>  #endif
>  
> +	cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
> +

I am recalling exactly the contrary patch that removes stuff to get the non-console UARTs work.
Let's better revalidate this once other pieces will be in before applying.


>  	if (IS_SMC(pinfo)) {
>  		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
>  		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
> @@ -1331,6 +1333,7 @@ static int __init cpm_uart_console_setup(struct
> console *co, char *options) cpm_uart_init_scc(pinfo);
>  
>  	uart_set_options(port, co, baud, parity, bits, flow);
> +	cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
>  
>  	return 0;
>  }


-- 
Sincerely, Vitaly
