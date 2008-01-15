Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CACFDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 01:21:35 +1100 (EST)
Message-Id: <1CFD37C9-F06C-4C7E-836D-31C94EF464DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <119992170854-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [SERIAL] qe-uart: add support for Freescale QUICCEngine
	UART
Date: Tue, 15 Jan 2008 08:21:24 -0600
References: <11999217062265-git-send-email-timur@freescale.com>
	<11999217072674-git-send-email-timur@freescale.com>
	<119992170854-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2008, at 5:35 PM, Timur Tabi wrote:

> Add file ucc_uart.c, a serial device driver for the Freescale  
> QUICCEngine.
> Update the Kconfig and Makefile accordingly.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> drivers/serial/Kconfig    |   10 +
> drivers/serial/Makefile   |    1 +
> drivers/serial/ucc_uart.c | 1507 ++++++++++++++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 1518 insertions(+), 0 deletions(-)
> create mode 100644 drivers/serial/ucc_uart.c
>


>
> diff --git a/drivers/serial/ucc_uart.c b/drivers/serial/ucc_uart.c
> new file mode 100644
> index 0000000..6fe4cfc
> --- /dev/null
> +++ b/drivers/serial/ucc_uart.c
> @@ -0,0 +1,1507 @@
> +/*
> + * Freescale QUICC Engine UART device driver
> + *
> + * Author: Timur Tabi <timur@freescale.com>
> + *
> + * Copyright 2007 Freescale Semiconductor, Inc.  This file is  
> licensed under
> + * the terms of the GNU General Public License version 2.  This  
> program
> + * is licensed "as is" without any warranty of any kind, whether  
> express
> + * or implied.
> + *
> + * This driver adds support for UART devices via Freescale's QUICC  
> Engine
> + * found on some Freescale SOCs.
> + *
> + * If Soft-UART support is needed but not already present, then  
> this driver
> + * will request and upload the "Soft-UART" microcode upon probe.  The
> + * filename of the microcode should be fsl_qe_ucode_uart_X_YZ.bin,  
> where "X"
> + * is the name of the SOC (e.g. 8323), and YZ is the revision of  
> the SOC,
> + * (e.g. "11" for 1.1).
> + */
> +


what is the define for?  you commented all the others :)
>
> +#define UCC_WAIT_CLOSING 100
> +
> +struct ucc_uart_pram {
> +	struct ucc_slow_pram common;
> +	u8 res1[8];     	/* reserved */
> +	__be16 maxidl;  	/* Maximum idle chars */
> +	__be16 idlc;    	/* temp idle counter */
> +	__be16 brkcr;   	/* Break count register */
> +	__be16 parec;   	/* receive parity error counter */
> +	__be16 frmec;   	/* receive framing error counter */
> +	__be16 nosec;   	/* receive noise counter */
> +	__be16 brkec;   	/* receive break condition counter */
> +	__be16 brkln;   	/* last received break length */
> +	__be16 uaddr[2];	/* UART address character 1 & 2 */
> +	__be16 rtemp;   	/* Temp storage */
> +	__be16 toseq;   	/* Transmit out of sequence char */
> +	__be16 cchars[8];       /* control characters 1-8 */
> +	__be16 rccm;    	/* receive control character mask */
> +	__be16 rccr;    	/* receive control character register */
> +	__be16 rlbc;    	/* receive last break character */
> +	__be16 res2;    	/* reserved */
> +	__be32 res3;    	/* reserved, should be cleared */
> +	u8 res4;		/* reserved, should be cleared */
> +	u8 res5[3];     	/* reserved, should be cleared */
> +	__be32 res6;    	/* reserved, should be cleared */
> +	__be32 res7;    	/* reserved, should be cleared */
> +	__be32 res8;    	/* reserved, should be cleared */
> +	__be32 res9;    	/* reserved, should be cleared */
> +	__be32 res10;   	/* reserved, should be cleared */
> +	__be32 res11;   	/* reserved, should be cleared */
> +	__be32 res12;   	/* reserved, should be cleared */
> +	__be32 res13;   	/* reserved, should be cleared */
> +/* The rest is for Soft-UART only */
> +	__be16 supsmr;  	/* 0x90, Shadow UPSMR */
> +	__be16 res92;   	/* 0x92, reserved, initialize to 0 */
> +	__be32 rx_state;	/* 0x94, RX state, initialize to 0 */
> +	__be32 rx_cnt;  	/* 0x98, RX count, initialize to 0 */
> +	u8 rx_length;   	/* 0x9C, Char length, set to 1+CL+PEN+1+SL */
> +	u8 rx_bitmark;  	/* 0x9D, reserved, initialize to 0 */
> +	u8 rx_temp_dlst_qe;     /* 0x9E, reserved, initialize to 0 */
> +	u8 res14[0xBC - 0x9F];  /* reserved */
> +	__be32 dump_ptr;	/* 0xBC, Dump pointer */
> +	__be32 rx_frame_rem;    /* 0xC0, reserved, initialize to 0 */
> +	u8 rx_frame_rem_size;   /* 0xC4, reserved, initialize to 0 */
> +	u8 tx_mode;     	/* 0xC5, mode, 0=AHDLC, 1=UART */
> +	u16 tx_state;   	/* 0xC6, TX state */

__be16?

>
> +	u8 res15[0xD0 - 0xC8];  /* reserved */
> +	__be32 resD0;   	/* 0xD0, reserved, initialize to 0 */
> +	u8 resD4;       	/* 0xD4, reserved, initialize to 0 */
> +	__be16 resD5;   	/* 0xD5, reserved, initialize to 0 */
> +} __attribute__ ((packed));
> +
>
>


> +/*
> + * Set the modem control lines
> + *
> + * We currently don't support setting modem control lines, but this  
> function
> + * needs to exist, otherwise the kernel will panic.
> + */
> +void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +}

What's the issue w/support of this?  (maybe a comment related to why  
its not supported -- if not here in the git commit message)

> +/*
> + * Enable status change interrupts
> + *
> + * We don't support status change interrupts, but we need to define  
> this
> + * function otherwise the kernel will panic.
> + */
> +static void qe_uart_enable_ms(struct uart_port *port)
> +{

same question as above.

- k
