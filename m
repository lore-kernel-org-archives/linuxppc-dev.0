Return-Path: <tnt@246tNt.com>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D71B6DDFD3
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:54:24 +1100 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l02MsCPb030232
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 23:54:12 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <459AE21F.9010201@246tNt.com>
Date: Tue, 02 Jan 2007 23:52:15 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: grant.likely@secretlab.ca
Subject: Re: [POWERPC] Fix mpc52xx serial driver to work for arch/ppc again
References: <11677779373025-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11677779373025-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

grant.likely@secretlab.ca wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> The mpc52xx_uart_of_enumerate() function was added when adding 52xx
> support to arch/powerpc, but it must not be called for arch/ppc.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>   
Acked-by: Sylvain Munaut <tnt@246tNt.com>


obvious compile fix.

> ---
>
> Please include for .20; without this patch you cannot build an arch/ppc
> kernel for the lite52xx.
>
>  drivers/serial/mpc52xx_uart.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 9d11a75..3c4b6c2 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -789,7 +789,9 @@ static struct console mpc52xx_console = 
>  static int __init
>  mpc52xx_console_init(void)
>  {
> +#if defined(CONFIG_PPC_MERGE)
>  	mpc52xx_uart_of_enumerate();
> +#endif
>  	register_console(&mpc52xx_console);
>  	return 0;
>  }
>   
