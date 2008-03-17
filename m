Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 3AC1FDDF60
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 06:47:38 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1213557ana.81
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 12:47:36 -0700 (PDT)
Message-ID: <fa686aa40803171247j709bc554pe709628c46205600@mail.gmail.com>
Date: Mon, 17 Mar 2008 13:47:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <john.linn@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: Boot: Fix 16550 UART initialization
In-Reply-To: <20080317164202.7E8A41A3806F@mail213-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317164202.7E8A41A3806F@mail213-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 10:41 AM, John Linn <john.linn@xilinx.com> wrote:
> The UART 16550 initialization was not setting up the registers
>  correctly. Code was added to pull the frequency and speed from
>  the device tree and initialize the registers using those values.
>
>  The boot code was not and is still not using the cmd line
>  to setup up the uart. The frequency of the clock driving the
>  UART must be specified in the device tree so that the baud
>  rate generator can be setup.

The bootwrapper makes the assumption that the firmware has already
initialized the serial device and it should not be fiddled with so
that there is less chance of messing up a working output
configuration.

For platforms such as the virtex which don't have firmware the serial
port should be setup earlier in the boot process (in the appropriate
platform_init() function).

Cheers,
g.

>
>  ---
>
>  Please pull this patch for 2.6.26.
>  ---
>   arch/powerpc/boot/ns16550.c |   69 +++++++++++++++++++++++++++++++++---------
>   1 files changed, 54 insertions(+), 15 deletions(-)
>
>  diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
>  index f8f1b2f..d8edd48 100644
>  --- a/arch/powerpc/boot/ns16550.c
>  +++ b/arch/powerpc/boot/ns16550.c
>  @@ -15,23 +15,47 @@
>   #include "io.h"
>   #include "ops.h"
>
>  -#define UART_DLL       0       /* Out: Divisor Latch Low */
>  -#define UART_DLM       1       /* Out: Divisor Latch High */
>  -#define UART_FCR       2       /* Out: FIFO Control Register */
>  -#define UART_LCR       3       /* Out: Line Control Register */
>  -#define UART_MCR       4       /* Out: Modem Control Register */
>  -#define UART_LSR       5       /* In:  Line Status Register */
>  -#define UART_LSR_THRE  0x20    /* Transmit-hold-register empty */
>  -#define UART_LSR_DR    0x01    /* Receiver data ready */
>  -#define UART_MSR       6       /* In:  Modem Status Register */
>  -#define UART_SCR       7       /* I/O: Scratch Register */
>  -
>  -static unsigned char *reg_base;
>  -static u32 reg_shift;
>  +#define UART_DLL               0       /* Out: Divisor Latch Low */
>  +#define UART_DLM               1       /* Out: Divisor Latch High */
>  +#define UART_FCR               2       /* Out: FIFO Control Register */
>  +#define UART_FCR_CLEAR_RCVR    0x02    /* Clear the RCVR FIFO */
>  +#define UART_FCR_CLEAR_XMIT    0x04    /* Clear the XMIT FIFO */
>  +#define UART_LCR               3       /* Out: Line Control Register */
>  +#define UART_MCR               4       /* Out: Modem Control Register */
>  +#define UART_MCR_RTS           0x02    /* RTS complement */
>  +#define UART_MCR_DTR           0x01    /* DTR complement */
>  +#define UART_LSR               5       /* In:  Line Status Register */
>  +#define UART_LSR_THRE          0x20    /* Transmit-hold-register empty */
>  +#define UART_LSR_DR            0x01    /* Receiver data ready */
>  +#define UART_LCR_DLAB          0x80    /* Divisor latch access bit */
>  +#define UART_LCR_WLEN8         0x03    /* Wordlength: 8 bits */
>  +#define UART_MSR               6       /* In:  Modem Status Register */
>  +#define UART_SCR               7       /* I/O: Scratch Register */
>  +
>  +volatile static unsigned char *reg_base;
>  +volatile static u32 reg_shift;
>  +volatile static u16 divisor;
>
>   static int ns16550_open(void)
>   {
>  -       out_8(reg_base + (UART_FCR << reg_shift), 0x06);
>  +
>  +       /* Access baud rate */
>  +       out_8(reg_base + (UART_LCR << reg_shift), UART_LCR_DLAB);
>  +
>  +       /* Baud rate based on input clock */
>  +       out_8(reg_base + (UART_DLL << reg_shift), divisor & 0xFF);
>  +       out_8(reg_base + (UART_DLM << reg_shift), divisor >> 8);
>  +
>  +       /* 8 data, 1 stop, no parity */
>  +       out_8(reg_base + (UART_LCR << reg_shift), UART_LCR_WLEN8);
>  +
>  +       /* RTS/DTR */
>  +       out_8(reg_base + (UART_MCR << reg_shift), UART_MCR_RTS | UART_MCR_DTR);
>  +
>  +       /* Clear transmitter and receiver */
>  +       out_8(reg_base + (UART_FCR << reg_shift),
>  +                               UART_FCR_CLEAR_XMIT | UART_FCR_CLEAR_RCVR);
>  +
>         return 0;
>   }
>
>  @@ -56,6 +80,7 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>   {
>         int n;
>         unsigned long reg_phys;
>  +       u32 clk, spd;
>
>         n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
>         if (n != sizeof(reg_base)) {
>  @@ -65,9 +90,23 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>                 reg_base = (void *)reg_phys;
>         }
>
>  -       n = getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
>  +       n = getprop(devp, "reg-shift", (void *)&reg_shift, sizeof(reg_shift));
>         if (n != sizeof(reg_shift))
>                 reg_shift = 0;
>  +
>  +       /* the base address has to change for devices with odd reg spacing */
>  +       reg_base = reg_base + ((1 << reg_shift) - 1);
>  +
>  +       n = getprop(devp, "current-speed", (void *)&spd, sizeof(spd));
>  +       if (n != sizeof(spd))
>  +               spd = 9600;
>  +
>  +       /* should there be a default clock rate?*/
>  +       n = getprop(devp, "clock-frequency", (void *)&clk, sizeof(clk));
>  +       if (n != sizeof(clk))
>  +               return -1;
>  +
>  +       divisor = clk / (16 * spd);
>
>         scdp->open = ns16550_open;
>         scdp->putc = ns16550_putc;
>  --
>  1.5.2.1
>
>
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
