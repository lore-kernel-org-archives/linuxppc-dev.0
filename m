Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 4E1E6DE017
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 09:14:10 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
Date: Tue, 4 Dec 2007 23:13:57 +0100
References: <11967907173600-git-send-email-timur@freescale.com>
In-Reply-To: <11967907173600-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712042313.58252.arnd@arndb.de>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 December 2007, Timur Tabi wrote:
> Add support for UART serial ports using a Freescale QUICC Engine
> (found on some MPC83xx and MPC85xx SOCs).
> 
> Because of a silicon bug in some QE-enabled SOCs (e.g. 8323 and 8360), a new
> microcode is required. This microcode implements UART via a work-around,
> hence it's called "Soft-UART".  This driver can use QE firmware upload feature
> to upload the correct microcode to the QE.

Can you use the driver on CPUs without this particular bug when it's built
in Soft-UART mode?

> +
> +#ifdef CONFIG_SERIAL_QE_SOFT_UART_UPLOAD
> +#include <linux/firmware.h>
> +#include <asm/reg.h>
> +#endif
> +
> +#ifdef CONFIG_SERIAL_QE_SOFT_UART
> +/*
> + * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
> + * but Soft-UART is a hack and we want to keep everything related to it in
> + * this file.
> + */
> +#define UCC_SLOW_GUMR_H_SUART   	0x00004000      /* Soft UART */
> +
> +/*
> + * firmware_loaded is 1 if the firmware has been loaded, 0 otherwise.
> + */
> +#ifdef CONFIG_SERIAL_QE_SOFT_UART_UPLOAD
> +static int firmware_loaded;
> +#endif

Try to reduce the number of #ifdefs in your code. In particular, you should
not do conditional #includes and #defines, as they often lead to subtle bugs.

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
> +#ifdef CONFIG_SERIAL_QE_SOFT_UART
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
> +	u8 res15[0xD0 - 0xC8];  /* reserved */
> +	__be32 resD0;   	/* 0xD0, reserved, initialize to 0 */
> +	u8 resD4;       	/* 0xD4, reserved, initialize to 0 */
> +	__be16 resD5;   	/* 0xD5, reserved, initialize to 0 */
> +#endif
> +} __attribute__ ((packed));

The structure is perfectly packed even without your __attribute__ ((packed)),
so you should leave out the attribute in order to get more efficient code
accessing it.

> +
> +#ifdef DEBUG
> +static void dump_ucc_uart_pram(struct ucc_uart_pram __iomem *uccup)
> +{
> +	unsigned int i;

Do you really need the debugging function like this in the code?
Usually they are rather pointless once the code works, and will
suffer from bitrot because nobody enables the code.

> +
> +#ifdef CONFIG_SERIAL_QE_SOFT_UART
> +#define UCC_UART_SUPSMR_SL      	0x8000
> +#define UCC_UART_SUPSMR_RPM_MASK	0x6000
> +#define UCC_UART_SUPSMR_RPM_ODD 	0x0000
> +#define UCC_UART_SUPSMR_RPM_LOW 	0x2000

again, the #ifdef should be left out if it can.

> + * Given the virtual address for a character buffer, this function returns
> + * the physical (DMA) equivalent.
> + */
> +static inline dma_addr_t cpu2qe_addr(void *addr, struct uart_qe_port *qe_port)
> +{
> +	if (likely((addr >= qe_port->bd_virt)) &&
> +	    (addr < (qe_port->bd_virt + qe_port->bd_size)))
> +		return qe_port->bd_phys + (addr - qe_port->bd_virt);
> +
> +	/* something nasty happened */
> +	printk(KERN_ERR "%s: addr=%p\n", __FUNCTION__, addr);
> +	BUG();
> +	return 0;
> +}

I'm guessing that you don't really mean dma_addr_t here, but rather
phys_addr_t, which is something different.

> +
> +/*
> + * Physical to virtual address translation.
> + *
> + * Given the physical (DMA) address for a character buffer, this function
> + * returns the virtual equivalent.
> + */
> +static inline void *qe2cpu_addr(dma_addr_t addr, struct uart_qe_port *qe_port)

same here.

	Arnd <><
