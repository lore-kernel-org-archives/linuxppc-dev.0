Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EB4F667B99
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 00:47:35 +1100 (EST)
Date: Wed, 1 Nov 2006 16:47:21 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
Message-ID: <20061101164721.03e79834@vitb.ru.mvista.com>
In-Reply-To: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 1 Nov 2006 15:08:13 +0200 (EET)
Kalle Pokki <kalle.pokki@iki.fi> wrote:

> This is a cleaned-up version of a patch sent on Oct 19th. The patch is 
> fairly straightforward and does not affect other than the compat mode. As 
> not having this patch renders the cpm_uart driver unusable with a frame 
> buffer console, I think this should be included in 2.6.19.
> 
Fine with me.

> ---
> The cpm_uart driver is initialised incorrectly, if there is a frame buffer
> console, and CONFIG_SERIAL_CPM_CONSOLE is defined. The driver fails to 
> call cpm_uart_init_portdesc() and set_lineif() in this case.
> 
> Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

> ---
>   drivers/serial/cpm_uart/cpm_uart.h      |    2 +-
>   drivers/serial/cpm_uart/cpm_uart_core.c |   11 ++++++-----
>   drivers/serial/cpm_uart/cpm_uart_cpm1.c |    2 +-
>   drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
>   4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
> index 3b35cb7..19a6ffe 100644
> --- a/drivers/serial/cpm_uart/cpm_uart.h
> +++ b/drivers/serial/cpm_uart/cpm_uart.h
> @@ -89,7 +89,7 @@ extern struct uart_cpm_port cpm_uart_por
> 
>   /* these are located in their respective files */
>   void cpm_line_cr_cmd(int line, int cmd);
> -int cpm_uart_init_portdesc(void);
> +int __init cpm_uart_init_portdesc(void);
>   int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con);
>   void cpm_uart_freebuf(struct uart_cpm_port *pinfo);
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
> index 8f3b3e5..4047530 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -1349,11 +1349,10 @@ static int cpm_uart_init(void) {
>   		pr_info("cpm_uart: WARNING: no UART devices found on platform bus!\n");
>   		pr_info(
>   		"cpm_uart: the driver will guess configuration, but this mode is no longer supported.\n");
> -#ifndef CONFIG_SERIAL_CPM_CONSOLE
> -		ret = cpm_uart_init_portdesc();
> -		if (ret)
> -			return ret;
> -#endif
> +
> +		/* Don't run this again, if the console driver did it already */
> +		if (cpm_uart_nr == 0)
> +			cpm_uart_init_portdesc();
> 
>   		cpm_reg.nr = cpm_uart_nr;
>   		ret = uart_register_driver(&cpm_reg);
> @@ -1365,6 +1364,8 @@ #endif
>   			int con = cpm_uart_port_map[i];
>   			cpm_uart_ports[con].port.line = i;
>   			cpm_uart_ports[con].port.flags = UPF_BOOT_AUTOCONF;
> +			if (cpm_uart_ports[con].set_lineif)
> +				cpm_uart_ports[con].set_lineif(&cpm_uart_ports[con]);
>   			uart_add_one_port(&cpm_reg, &cpm_uart_ports[con].port);
>   		}
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> index 95afc37..08e55fd 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> @@ -184,7 +184,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
>   }
> 
>   /* Setup any dynamic params in the uart desc */
> -int cpm_uart_init_portdesc(void)
> +int __init cpm_uart_init_portdesc(void)
>   {
>   	pr_debug("CPM uart[-]:init portdesc\n");
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> index ef3bb47..b392aea 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -252,7 +252,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
>   }
> 
>   /* Setup any dynamic params in the uart desc */
> -int cpm_uart_init_portdesc(void)
> +int __init cpm_uart_init_portdesc(void)
>   {
>   	pr_debug("CPM uart[-]:init portdesc\n");
> 
> -- 
> 1.4.1.1
> 
> 


-- 
Sincerely, 
Vitaly
