Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3E76F2C0106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 07:54:33 +1000 (EST)
Date: Mon, 15 Jul 2013 23:54:23 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 15/24] serial: mpc512x: OF clock lookup, use the
 'mclk' name
Message-ID: <20130715215423.GU14452@pengutronix.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373924770-22599-1-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373924770-22599-1-git-send-email-gsi@denx.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 15, 2013 at 11:46:01PM +0200, Gerhard Sittig wrote:
> with device tree based clock lookup, the MCLK name no longer
> depends on the PSC index
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/tty/serial/mpc52xx_uart.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
> index 53c1093..221fb89 100644
> --- a/drivers/tty/serial/mpc52xx_uart.c
> +++ b/drivers/tty/serial/mpc52xx_uart.c
> @@ -619,21 +619,17 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
>  static int mpc512x_psc_clock(struct uart_port *port, int enable)
>  {
>  	struct clk *psc_clk;
> -	int psc_num;
> -	char clk_name[10];
>  
>  	if (uart_console(port))
>  		return 0;
>  
> -	psc_num = (port->mapbase & 0xf00) >> 8;
> -	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
> -	psc_clk = clk_get(port->dev, clk_name);
> +	psc_clk = clk_get(port->dev, "mclk");

Same comment applies here as Mark made to the spi driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
