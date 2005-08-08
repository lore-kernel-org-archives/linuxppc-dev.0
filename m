Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 883EB67E30
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 02:59:16 +1000 (EST)
In-Reply-To: <8E342283C2100540AAC5D10309705477749C5F@rcexc.racoms.loc>
References: <8E342283C2100540AAC5D10309705477749C5F@rcexc.racoms.loc>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <99DF4154-7A02-4CE1-8DE7-4BB71570B06D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 8 Aug 2005 11:59:18 -0500
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] cpm_uart_core.c GCC4.x compilation fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter,

Patch looks good.  Can't believe we lost the '=' in the  
initialization.  Will queue this up with a few other CPM_UART related  
patches.

- kumar

On Aug 8, 2005, at 8:57 AM, Schaefer-Hutter, Peter wrote:

> cpm_uart_core.c: needs some love to compile with GCC4.0.1.
>
> Signed-off-by: Peter Schaefer-Hutter
> <peter.schaefer-hutter@tfk-racoms.com>
>
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c    2005-08-08
> 15:49:16.725292392 +0200
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c    2005-08-08
> 15:33:47.691526992 +0200
> @@ -1134,14 +1134,14 @@
>      return 0;
>  }
>
> -extern struct uart_driver cpm_reg;
> +static struct uart_driver cpm_reg;
>  static struct console cpm_scc_uart_console = {
> -    .name        "ttyCPM",
> -    .write        cpm_uart_console_write,
> -    .device        uart_console_device,
> -    .setup        cpm_uart_console_setup,
> -    .flags        CON_PRINTBUFFER,
> -    .index        -1,
> +    .name        = "ttyCPM",
> +    .write        = cpm_uart_console_write,
> +    .device        = uart_console_device,
> +    .setup        = cpm_uart_console_setup,
> +    .flags        = CON_PRINTBUFFER,
> +    .index        = -1,
>      .data        = &cpm_reg,
>  };
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
