Return-Path: <jacmet@sunsite.dk>
Received: from astra.telenet-ops.be (astra.telenet-ops.be [195.130.132.58])
	by ozlabs.org (Postfix) with ESMTP id 2DAEC68340
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 16:54:26 +1000 (EST)
To: glikely@gmail.com
References: <528646bc050910003630c25dca@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 20 Sep 2005 08:26:28 +0200
In-Reply-To: <528646bc050910003630c25dca@mail.gmail.com> (Grant Likely's
	message of "Sat, 10 Sep 2005 01:36:28 -0600")
Message-ID: <87vf0wp84r.fsf@p4.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] Move Virtex-II Pro / ML300 port over to the
 platform bus.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> " " == Grant Likely <glikely@gmail.com> writes:

Hi,

 > This is a large patch that moves the ML300 to the platform bus.
 > It also isolates most of the linux tree from changes to the
 > xparameters.h file.  Ultimately, the goal is to move everything
 > over to the flattened device tree for telling the kernel about
 > devices.  That way xparameters.h can go away entirely for the
 > kernel proper.  (Isolated to the bootloader)

Great!

> Comments are appreciated.

Here you go..

> diff --git a/arch/ppc/platforms/4xx/xilinx_ml300_devices.c
...
> +struct plat_serial8250_port serial_platform_data[] = {
> +#ifdef XPAR_OPB_UART16550_0_BASEADDR
> +	{
> +		.mapbase  = XPAR_OPB_UART16550_0_BASEADDR + 3,
> +		.irq	  = XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR,
> +		.iotype	  = UPIO_MEM,
> +		.uartclk  = XPAR_XUARTNS550_CLOCK_HZ,
> +		.flags	  = UPF_BOOT_AUTOCONF,
> +		.regshift = 2,
> +	},
> +#endif
> +#ifdef XPAR_OPB_UART16550_1_BASEADDR
> +	{
> +		.mapbase  = XPAR_OPB_UART16550_1_BASEADDR + 3,

You forgot the offset of 0x1000 (did you mean
XPAR_UARTNS550_0_BASEADDR) ?

> diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h
...

> +  /* zImage serial port definitions */
> +  #define SERIAL_PORT_DFNS {                                            \
> +        .baud_base       = XPAR_XUARTNS550_CLOCK_HZ/16,                 \
> +        .irq             = XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR, \
> +        .flags           = ASYNC_BOOT_AUTOCONF,                         \
> +        .iomem_base      = (u8 *)XPAR_OPB_UART16550_0_BASEADDR + 3,     \

And again.

Otherwise it looks good.

-- 
Bye, Peter Korsgaard
