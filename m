Return-Path: <vb@vsbe.com>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.195])
	by ozlabs.org (Postfix) with ESMTP id 4D375B7DFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 10:08:33 +1100 (EST)
Received: by pzk14 with SMTP id 14so3938587pzk.28
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Mar 2010 15:03:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
From: vb@vsbe.com
Date: Mon, 1 Mar 2010 15:03:04 -0800
Message-ID: <f608b67d1003011503h57b88742md889ba8d6da652bc@mail.gmail.com>
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sounds very much like this issue:

http://linux.derkeiler.com/Mailing-Lists/Kernel/2010-02/msg09470.html

(interrupt storm on the second port which is hit with breaks).

It's not the uart driver problem per se, the below fixes it:

*** linux/drivers/serial/serial_core.c#1        Wed Feb 24 17:46:22 2010
---  linux/drivers/serial/serial_core.c#2        Mon Mar  1 15:00:29 2010
***************
*** 622,632 ****
        struct uart_port *port =3D state->port;

        if (I_IXOFF(tty)) {
                if (port->x_char)
                        port->x_char =3D 0;
!               else
                        uart_send_xchar(tty, START_CHAR(tty));
        }

        if (tty->termios->c_cflag & CRTSCTS)
                uart_set_mctrl(port, TIOCM_RTS);
--- 622,632 ----
        struct uart_port *port =3D state->port;

        if (I_IXOFF(tty)) {
                if (port->x_char)
                        port->x_char =3D 0;
!               else if (!(tty->flags & (1 << TTY_IO_ERROR)))
                        uart_send_xchar(tty, START_CHAR(tty));
        }

        if (tty->termios->c_cflag & CRTSCTS)
                uart_set_mctrl(port, TIOCM_RTS);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^

I did not get to trying to submit it, but it sure gets rid o the storm.

cheers,
/vb

On Fri, Feb 26, 2010 at 11:25 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Sending a break on the SOC UARTs found in some MPC83xx/85xx/86xx
> chips seems to cause a short lived IRQ storm (/proc/interrupts
> typically shows somewhere between 300 and 1500 events). =A0Unfortunately
> this renders SysRQ over the serial console completely inoperable.
> Testing with obvious things like ACKing the event doesn't seem to
> change anything vs. a completely dumb approach of just ignoring
> it and waiting for it to stop, so that is what is implemented here.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>
> This is a refresh of a patch I'd done earlier -- I've tried to make
> the bug support as generic as possible to minimize having board
> specific ifdef crap in 8250.c -- any suggestions on how to further
> improve it are welcome.
>
> =A0drivers/serial/8250.c =A0 =A0 =A0| =A0 =A06 ++++++
> =A0drivers/serial/8250.h =A0 =A0 =A0| =A0 20 ++++++++++++++++++++
> =A0drivers/serial/Kconfig =A0 =A0 | =A0 14 ++++++++++++++
> =A0include/linux/serial_reg.h | =A0 =A02 ++
> =A04 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index e9b15c3..850b0e9 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -1531,6 +1531,11 @@ static void serial8250_handle_port(struct uart_825=
0_port *up)
>
> =A0 =A0 =A0 =A0status =3D serial_inp(up, UART_LSR);
>
> + =A0 =A0 =A0 if ((up->bugs & UART_BUG_PPC) && (status =3D=3D UART_LSR_RF=
E_ERROR_BITS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flag=
s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0DEBUG_INTR("status =3D %x...", status);
>
> =A0 =A0 =A0 =A0if (status & (UART_LSR_DR | UART_LSR_BI))
> @@ -1948,6 +1953,7 @@ static int serial8250_startup(struct uart_port *por=
t)
>
> =A0 =A0 =A0 =A0up->capabilities =3D uart_config[up->port.type].flags;
> =A0 =A0 =A0 =A0up->mcr =3D 0;
> + =A0 =A0 =A0 up->bugs |=3D UART_KNOWN_BUGS;
>
> =A0 =A0 =A0 =A0if (up->port.iotype !=3D up->cur_iotype)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_io_from_upio(port);
> diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
> index 6e19ea3..2074ce1 100644
> --- a/drivers/serial/8250.h
> +++ b/drivers/serial/8250.h
> @@ -49,6 +49,7 @@ struct serial8250_config {
> =A0#define UART_BUG_TXEN =A0(1 << 1) =A0 =A0 =A0 =A0/* UART has buggy TX =
IIR status */
> =A0#define UART_BUG_NOMSR (1 << 2) =A0 =A0 =A0 =A0/* UART has buggy MSR s=
tatus bits (Au1x00) */
> =A0#define UART_BUG_THRE =A0(1 << 3) =A0 =A0 =A0 =A0/* UART has buggy THR=
E reassertion */
> +#define UART_BUG_PPC =A0 (1 << 4) =A0 =A0 =A0 =A0/* UART has buggy PPC b=
reak IRQ storm */
>
> =A0#define PROBE_RSA =A0 =A0 =A0(1 << 0)
> =A0#define PROBE_ANY =A0 =A0 =A0(~0)
> @@ -78,3 +79,22 @@ struct serial8250_config {
> =A0#else
> =A0#define ALPHA_KLUDGE_MCR 0
> =A0#endif
> +
> +/*
> + * The following UART bugs are currently dynamically detected and not
> + * required to be contingent on any particular compile time options.
> + */
> +#define HAS_BUG_QUOT =A0 0 =A0 =A0 =A0 /* assign UART_BUG_QUOT to enable=
 */
> +#define HAS_BUG_TXEN =A0 0 =A0 =A0 =A0 /* assign UART_BUG_TXEN to enable=
 */
> +#define HAS_BUG_NOMSR =A00 =A0 =A0 =A0 /* assign UART_BUG_NOMSR to enabl=
e */
> +#define HAS_BUG_THRE =A0 0 =A0 =A0 =A0 /* assign UART_BUG_THRE to enable=
 */
> +
> +#ifdef CONFIG_SERIAL_8250_PPC_BUG
> +#define HAS_BUG_PPC =A0 =A0UART_BUG_PPC
> +#else
> +#define HAS_BUG_PPC =A0 =A00
> +#endif
> +
> +#define UART_KNOWN_BUGS (HAS_BUG_QUOT | HAS_BUG_TXEN | HAS_BUG_NOMSR | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HAS_BUG_THRE | HAS_BUG_PPC)
> +
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9ff47db..e01a411 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -70,6 +70,20 @@ config SERIAL_8250_CONSOLE
>
> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>
> +config SERIAL_8250_PPC_BUG
> + =A0 =A0 =A0 bool "Fix 8250/16550 to handle IRQ storm after receipt of a=
 break"
> + =A0 =A0 =A0 depends on SERIAL_8250 && PPC32
> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 =A0 If you say Y here, addional checks will be added in the=
 handling of
> + =A0 =A0 =A0 =A0 interrupts on the serial ports which will prevent ill e=
ffects of
> + =A0 =A0 =A0 =A0 an interrupt storm triggered by a break on the serial l=
ine. Without
> + =A0 =A0 =A0 =A0 this enabled, a Sysrq via the serial console can be unu=
sable on
> + =A0 =A0 =A0 =A0 some systems.
> +
> + =A0 =A0 =A0 =A0 This is commonly observed on PPC32 MPC83xx/85xx/86xx ba=
sed boards.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> =A0config FIX_EARLYCON_MEM
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0depends on X86
> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> index cf9327c..010174f 100644
> --- a/include/linux/serial_reg.h
> +++ b/include/linux/serial_reg.h
> @@ -111,6 +111,7 @@
> =A0#define UART_MCR_DTR =A0 =A0 =A0 =A0 =A0 0x01 /* DTR complement */
>
> =A0#define UART_LSR =A0 =A0 =A0 5 =A0 =A0 =A0 /* In: =A0Line Status Regis=
ter */
> +#define UART_LSR_RFE =A0 =A0 =A0 =A0 =A0 0x80 /* Rx FIFO Error (BE, FE, =
or PE) */
> =A0#define UART_LSR_TEMT =A0 =A0 =A0 =A0 =A00x40 /* Transmitter empty */
> =A0#define UART_LSR_THRE =A0 =A0 =A0 =A0 =A00x20 /* Transmit-hold-registe=
r empty */
> =A0#define UART_LSR_BI =A0 =A0 =A0 =A0 =A0 =A00x10 /* Break interrupt ind=
icator */
> @@ -119,6 +120,7 @@
> =A0#define UART_LSR_OE =A0 =A0 =A0 =A0 =A0 =A00x02 /* Overrun error indic=
ator */
> =A0#define UART_LSR_DR =A0 =A0 =A0 =A0 =A0 =A00x01 /* Receiver data ready=
 */
> =A0#define UART_LSR_BRK_ERROR_BITS =A0 =A0 =A0 =A00x1E /* BI, FE, PE, OE =
bits */
> +#define UART_LSR_RFE_ERROR_BITS =A0 =A0 =A0 =A00xF1 /* RFE, TEMT, THRE, =
BI, DR bits */
>
> =A0#define UART_MSR =A0 =A0 =A0 6 =A0 =A0 =A0 /* In: =A0Modem Status Regi=
ster */
> =A0#define UART_MSR_DCD =A0 =A0 =A0 =A0 =A0 0x80 /* Data Carrier Detect *=
/
> --
> 1.6.5.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
