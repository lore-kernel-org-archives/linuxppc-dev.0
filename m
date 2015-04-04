Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by lists.ozlabs.org (Postfix) with ESMTP id BFF721A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Apr 2015 08:12:52 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 05 Apr 2015 00:04:29 +0200
From: Stefan Agner <stefan@agner.ch>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] tty: serial: Add const to struct
 =?UTF-8?Q?uart=5Fops=20declarations?=
In-Reply-To: <1428169665.2775.53.camel@perches.com>
References: <1428169665.2775.53.camel@perches.com>
Message-ID: <a938a0e86638588e5ccff85771fa3b95@agner.ch>
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Patrice Chotard <patrice.chotard@st.com>, Pat Gefre <pfg@sgi.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>,
 sparclinux@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>,
 Jiri Slaby <jslaby@suse.cz>, Alexandre Courbot <gnurou@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-serial@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linux-tegra@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>,
 Barry Song <baohua@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Vineet Gupta <vgupta@synopsys.com>, nios2-dev@lists.rocketboards.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joe,

See comment below...

On 2015-04-04 19:47, Joe Perches wrote:
> These structs can be const, so make them const.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> Done with:
> sed -r -i -e 's/\bstruct\s+uart_ops\s+(\w+)\s*=\s*/const struct
> uart_ops \1 = /g' drivers/tty/serial/*.c
> 
> Compiled x86 only, not cross-compiled.  Untested.
> 
>  drivers/tty/serial/21285.c                  | 2 +-
>  drivers/tty/serial/altera_jtaguart.c        | 2 +-
>  drivers/tty/serial/altera_uart.c            | 2 +-
>  drivers/tty/serial/amba-pl010.c             | 2 +-
>  drivers/tty/serial/amba-pl011.c             | 2 +-
>  drivers/tty/serial/apbuart.c                | 2 +-
>  drivers/tty/serial/ar933x_uart.c            | 2 +-
>  drivers/tty/serial/arc_uart.c               | 2 +-
>  drivers/tty/serial/atmel_serial.c           | 2 +-
>  drivers/tty/serial/bcm63xx_uart.c           | 2 +-
>  drivers/tty/serial/bfin_sport_uart.c        | 2 +-
>  drivers/tty/serial/bfin_uart.c              | 2 +-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 +-
>  drivers/tty/serial/dz.c                     | 2 +-
>  drivers/tty/serial/efm32-uart.c             | 2 +-
>  drivers/tty/serial/fsl_lpuart.c             | 4 ++--
>  drivers/tty/serial/icom.c                   | 2 +-
>  drivers/tty/serial/imx.c                    | 2 +-
>  drivers/tty/serial/ioc3_serial.c            | 2 +-
>  drivers/tty/serial/ioc4_serial.c            | 2 +-
>  drivers/tty/serial/ip22zilog.c              | 2 +-
>  drivers/tty/serial/jsm/jsm_tty.c            | 2 +-
>  drivers/tty/serial/lantiq.c                 | 2 +-
>  drivers/tty/serial/lpc32xx_hs.c             | 2 +-
>  drivers/tty/serial/m32r_sio.c               | 2 +-
>  drivers/tty/serial/max3100.c                | 2 +-
>  drivers/tty/serial/men_z135_uart.c          | 2 +-
>  drivers/tty/serial/meson_uart.c             | 2 +-
>  drivers/tty/serial/mpc52xx_uart.c           | 2 +-
>  drivers/tty/serial/mpsc.c                   | 2 +-
>  drivers/tty/serial/msm_serial.c             | 2 +-
>  drivers/tty/serial/mux.c                    | 2 +-
>  drivers/tty/serial/mxs-auart.c              | 2 +-
>  drivers/tty/serial/netx-serial.c            | 2 +-
>  drivers/tty/serial/nwpserial.c              | 2 +-
>  drivers/tty/serial/omap-serial.c            | 2 +-
>  drivers/tty/serial/pch_uart.c               | 2 +-
>  drivers/tty/serial/pmac_zilog.c             | 2 +-
>  drivers/tty/serial/pnx8xxx_uart.c           | 2 +-
>  drivers/tty/serial/pxa.c                    | 2 +-
>  drivers/tty/serial/sa1100.c                 | 2 +-
>  drivers/tty/serial/samsung.c                | 2 +-
>  drivers/tty/serial/serial-tegra.c           | 2 +-
>  drivers/tty/serial/serial_ks8695.c          | 2 +-
>  drivers/tty/serial/serial_txx9.c            | 2 +-
>  drivers/tty/serial/sh-sci.c                 | 2 +-
>  drivers/tty/serial/sirfsoc_uart.c           | 2 +-
>  drivers/tty/serial/sn_console.c             | 2 +-
>  drivers/tty/serial/sprd_serial.c            | 2 +-
>  drivers/tty/serial/st-asc.c                 | 2 +-
>  drivers/tty/serial/sunhv.c                  | 2 +-
>  drivers/tty/serial/sunsab.c                 | 2 +-
>  drivers/tty/serial/sunsu.c                  | 2 +-
>  drivers/tty/serial/sunzilog.c               | 2 +-
>  drivers/tty/serial/timbuart.c               | 2 +-
>  drivers/tty/serial/uartlite.c               | 2 +-
>  drivers/tty/serial/ucc_uart.c               | 2 +-
>  drivers/tty/serial/vr41xx_siu.c             | 2 +-
>  drivers/tty/serial/vt8500_serial.c          | 2 +-
>  drivers/tty/serial/xilinx_uartps.c          | 2 +-
>  drivers/tty/serial/zs.c                     | 2 +-
>  61 files changed, 62 insertions(+), 62 deletions(-)
> 

<snip>

> --- a/drivers/tty/serial/efm32-uart.c
> +++ b/drivers/tty/serial/efm32-uart.c
> @@ -487,7 +487,7 @@ static int efm32_uart_verify_port(struct uart_port *port,
>  	return ret;
>  }
>  
> -static struct uart_ops efm32_uart_pops = {
> +static const struct uart_ops efm32_uart_pops = {
>  	.tx_empty = efm32_uart_tx_empty,
>  	.set_mctrl = efm32_uart_set_mctrl,
>  	.get_mctrl = efm32_uart_get_mctrl,
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 08ce76f..738b5c4 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1494,7 +1494,7 @@ static int lpuart_verify_port(struct uart_port
> *port, struct serial_struct *ser)
>  	return ret;
>  }
>  
> -static struct uart_ops lpuart_pops = {
> +static const const struct uart_ops lpuart_pops = {

Something went wrong in this driver, const is twice...

Probably because we have two struct uart_ops in one driver?

>  	.tx_empty	= lpuart_tx_empty,
>  	.set_mctrl	= lpuart_set_mctrl,
>  	.get_mctrl	= lpuart_get_mctrl,
> @@ -1513,7 +1513,7 @@ static struct uart_ops lpuart_pops = {
>  	.flush_buffer	= lpuart_flush_buffer,
>  };
>  
> -static struct uart_ops lpuart32_pops = {
> +static const const struct uart_ops lpuart32_pops = {
>  	.tx_empty	= lpuart32_tx_empty,
>  	.set_mctrl	= lpuart32_set_mctrl,
>  	.get_mctrl	= lpuart32_get_mctrl,
> diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
> index 45fc323..3915443 100644
> --- a/drivers/tty/serial/icom.c
> +++ b/drivers/tty/serial/icom.c
> @@ -1287,7 +1287,7 @@ static void icom_config_port(struct uart_port
> *port, int flags)
>  	port->type = PORT_ICOM;
>  }
>  

<snip>

--
Stefan
