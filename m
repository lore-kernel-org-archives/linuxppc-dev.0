Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E10FB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Feb 2010 06:42:42 +1100 (EST)
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
Date: Fri, 26 Feb 2010 13:42:39 -0600
Message-Id: <EB2B2912-24C3-46C9-B894-0A84D593570F@kernel.crashing.org>
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 26, 2010, at 1:25 PM, Paul Gortmaker wrote:

> Sending a break on the SOC UARTs found in some MPC83xx/85xx/86xx
> chips seems to cause a short lived IRQ storm (/proc/interrupts
> typically shows somewhere between 300 and 1500 events).  Unfortunately
> this renders SysRQ over the serial console completely inoperable.
> Testing with obvious things like ACKing the event doesn't seem to
> change anything vs. a completely dumb approach of just ignoring
> it and waiting for it to stop, so that is what is implemented here.
>=20
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>=20
> This is a refresh of a patch I'd done earlier -- I've tried to make
> the bug support as generic as possible to minimize having board
> specific ifdef crap in 8250.c -- any suggestions on how to further
> improve it are welcome.
>=20
> drivers/serial/8250.c      |    6 ++++++
> drivers/serial/8250.h      |   20 ++++++++++++++++++++
> drivers/serial/Kconfig     |   14 ++++++++++++++
> include/linux/serial_reg.h |    2 ++
> 4 files changed, 42 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index e9b15c3..850b0e9 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -1531,6 +1531,11 @@ static void serial8250_handle_port(struct =
uart_8250_port *up)
>=20
> 	status =3D serial_inp(up, UART_LSR);
>=20
> +	if ((up->bugs & UART_BUG_PPC) && (status =3D=3D =
UART_LSR_RFE_ERROR_BITS)) {
> +		spin_unlock_irqrestore(&up->port.lock, flags);
> +		return;
> +	}
> +
> 	DEBUG_INTR("status =3D %x...", status);
>=20
> 	if (status & (UART_LSR_DR | UART_LSR_BI))
> @@ -1948,6 +1953,7 @@ static int serial8250_startup(struct uart_port =
*port)
>=20
> 	up->capabilities =3D uart_config[up->port.type].flags;
> 	up->mcr =3D 0;
> +	up->bugs |=3D UART_KNOWN_BUGS;
>=20
> 	if (up->port.iotype !=3D up->cur_iotype)
> 		set_io_from_upio(port);
> diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
> index 6e19ea3..2074ce1 100644
> --- a/drivers/serial/8250.h
> +++ b/drivers/serial/8250.h
> @@ -49,6 +49,7 @@ struct serial8250_config {
> #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status =
*/
> #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR =
status bits (Au1x00) */
> #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE =
reassertion */
> +#define UART_BUG_PPC	(1 << 4)	/* UART has buggy PPC break IRQ =
storm */
>=20
> #define PROBE_RSA	(1 << 0)
> #define PROBE_ANY	(~0)
> @@ -78,3 +79,22 @@ struct serial8250_config {
> #else
> #define ALPHA_KLUDGE_MCR 0
> #endif
> +
> +/*
> + * The following UART bugs are currently dynamically detected and not
> + * required to be contingent on any particular compile time options.
> + */
> +#define HAS_BUG_QUOT	0	/* assign UART_BUG_QUOT to enable */
> +#define HAS_BUG_TXEN	0	/* assign UART_BUG_TXEN to enable */
> +#define HAS_BUG_NOMSR	0	/* assign UART_BUG_NOMSR to =
enable */
> +#define HAS_BUG_THRE	0	/* assign UART_BUG_THRE to enable */
> +
> +#ifdef CONFIG_SERIAL_8250_PPC_BUG
> +#define HAS_BUG_PPC	UART_BUG_PPC
> +#else
> +#define HAS_BUG_PPC	0
> +#endif
> +
> +#define UART_KNOWN_BUGS (HAS_BUG_QUOT | HAS_BUG_TXEN | HAS_BUG_NOMSR =
| \
> +			HAS_BUG_THRE | HAS_BUG_PPC)
> +
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9ff47db..e01a411 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -70,6 +70,20 @@ config SERIAL_8250_CONSOLE
>=20
> 	  If unsure, say N.
>=20
> +config SERIAL_8250_PPC_BUG
> +	bool "Fix 8250/16550 to handle IRQ storm after receipt of a =
break"
> +	depends on SERIAL_8250 && PPC32
> +	---help---
> +	  If you say Y here, addional checks will be added in the =
handling of
> +	  interrupts on the serial ports which will prevent ill effects =
of
> +	  an interrupt storm triggered by a break on the serial line. =
Without
> +	  this enabled, a Sysrq via the serial console can be unusable =
on
> +	  some systems.
> +
> +	  This is commonly observed on PPC32 MPC83xx/85xx/86xx based =
boards.
> +
> +	  If unsure, say N.
> +

is there harm caused if we have SERIAL_8250_PPC_BUG set and dont need =
it?

- k=
