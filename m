Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F6571007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 05:25:58 +1100 (EST)
In-Reply-To: <1259441037-15725-8-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
	<1259441037-15725-8-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2CEF04D0-29F8-4412-8013-0998C77C1A46@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 07/11] powerpc: gamecube/wii: udbg support for
	usbgecko
Date: Tue, 1 Dec 2009 19:33:21 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Add support for using the USB Gecko adapter via the udbg facility on
> the Nintendo GameCube and Wii video game consoles.
> The USB Gecko is a 3rd party memory card interface adapter that  
> provides
> a EXI (External Interface) to USB serial converter.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

> ---
> v1 -> v2
> - Get rid of 0-#ifdef'ed code. Suggestion by Segher Boessenkool.
> - Probe dinamically for usbgecko. Suggestion by Segher Boessenkool.
> - Adapt to updated device tree.
>
>  arch/powerpc/platforms/embedded6xx/Kconfig         |   13 +
>  arch/powerpc/platforms/embedded6xx/Makefile        |    1 +
>  arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |  272 +++++++++ 
> +++++++++++
>  arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |   30 +++
>  4 files changed, 316 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
>  create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
>
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/ 
> powerpc/platforms/embedded6xx/Kconfig
> index 97a2dbc..464e414 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -94,3 +94,16 @@ config MPC10X_STORE_GATHERING
>  config GAMECUBE_COMMON
>  	bool
>
> +config USBGECKO_UDBG
> +	bool "USB Gecko udbg console for the Nintendo GameCube/Wii"
> +	depends on GAMECUBE_COMMON
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  USB Gecko adapter as an udbg console.
> +	  The USB Gecko is a EXI to USB Serial converter that can be plugged
> +	  into a memcard slot in the Nintendo GameCube/Wii.
> +
> +	  This driver bypasses the EXI layer completely.
> +
> +	  If in doubt, say N here.
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/ 
> powerpc/platforms/embedded6xx/Makefile
> index 0773c08..0ab7492 100644
> --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_STORCENTER)	+= storcenter.o
>  obj-$(CONFIG_PPC_HOLLY)		+= holly.o
>  obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
>  obj-$(CONFIG_PPC_C2K)		+= c2k.o
> +obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/ 
> arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> new file mode 100644
> index 0000000..581ce61
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> @@ -0,0 +1,272 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> + *
> + * udbg serial input/output routines for the USB Gecko adapter.
> + * Copyright (C) 2008-2009 The GameCube Linux Team
> + * Copyright (C) 2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <asm/io.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +
> +#include <mm/mmu_decl.h>
> +
> +#include "usbgecko_udbg.h"
> +
> +
> +#define EXI_CLK_32MHZ           5
> +
> +#define EXI_CSR                 0x00
> +#define   EXI_CSR_CLKMASK       (0x7<<4)
> +#define     EXI_CSR_CLK_32MHZ   (EXI_CLK_32MHZ<<4)
> +#define   EXI_CSR_CSMASK        (0x7<<7)
> +#define     EXI_CSR_CS_0        (0x1<<7)  /* Chip Select 001 */
> +
> +#define EXI_CR                  0x0c
> +#define   EXI_CR_TSTART         (1<<0)
> +#define   EXI_CR_WRITE		(1<<2)
> +#define   EXI_CR_READ_WRITE     (2<<2)
> +#define   EXI_CR_TLEN(len)      (((len)-1)<<4)
> +
> +#define EXI_DATA                0x10
> +
> +#define UG_READ_ATTEMPTS	100
> +#define UG_WRITE_ATTEMPTS	100
> +
> +
> +static void __iomem *ug_io_base;
> +
> +/*
> + * Performs one input/output transaction between the exi host and  
> the usbgecko.
> + */
> +static u32 ug_io_transaction(u32 in)
> +{
> +	u32 __iomem *csr_reg = ug_io_base + EXI_CSR;
> +	u32 __iomem *data_reg = ug_io_base + EXI_DATA;
> +	u32 __iomem *cr_reg = ug_io_base + EXI_CR;
> +	u32 csr, data, cr;
> +
> +	/* select */
> +	csr = EXI_CSR_CLK_32MHZ | EXI_CSR_CS_0;
> +	out_be32(csr_reg, csr);
> +
> +	/* read/write */
> +	data = in;
> +	out_be32(data_reg, data);
> +	cr = EXI_CR_TLEN(2) | EXI_CR_READ_WRITE | EXI_CR_TSTART;
> +	out_be32(cr_reg, cr);
> +
> +	while (in_be32(cr_reg) & EXI_CR_TSTART)
> +		barrier();
> +
> +	/* deselect */
> +	out_be32(csr_reg, 0);
> +
> +	/* result */
> +	data = in_be32(data_reg);
> +
> +	return data;
> +}
> +
> +/*
> + * Returns true if an usbgecko adapter is found.
> + */
> +static int ug_is_adapter_present(void)
> +{
> +	if (!ug_io_base)
> +		return 0;
> +
> +	return ug_io_transaction(0x90000000) == 0x04700000;
> +}
> +
> +/*
> + * Returns true if the TX fifo is ready for transmission.
> + */
> +static int ug_is_txfifo_ready(void)
> +{
> +	return ug_io_transaction(0xc0000000) & 0x04000000;
> +}
> +
> +/*
> + * Tries to transmit a character.
> + * If the TX fifo is not ready the result is undefined.
> + */
> +static void ug_raw_putc(char ch)
> +{
> +	ug_io_transaction(0xb0000000 | (ch << 20));
> +}
> +
> +/*
> + * Transmits a character.
> + * It silently fails if the TX fifo is not ready after a number of  
> retries.
> + */
> +static void ug_putc(char ch)
> +{
> +	int count = UG_WRITE_ATTEMPTS;
> +
> +	if (!ug_io_base)
> +		return;
> +
> +	if (ch == '\n')
> +		ug_putc('\r');
> +
> +	while (!ug_is_txfifo_ready() && count--)
> +		barrier();
> +	if (count)
> +		ug_raw_putc(ch);
> +}
> +
> +/*
> + * Returns true if the RX fifo is ready for transmission.
> + */
> +static int ug_is_rxfifo_ready(void)
> +{
> +	return ug_io_transaction(0xd0000000) & 0x04000000;
> +}
> +
> +/*
> + * Tries to receive a character.
> + * If a character is unavailable the function returns -1.
> + */
> +static int ug_raw_getc(void)
> +{
> +	u32 data = ug_io_transaction(0xa0000000);
> +	if (data & 0x08000000)
> +		return (data >> 16) & 0xff;
> +	else
> +		return -1;
> +}
> +
> +/*
> + * Receives a character.
> + * It fails if the RX fifo is not ready after a number of retries.
> + */
> +static int ug_getc(void)
> +{
> +	int count = UG_READ_ATTEMPTS;
> +
> +	if (!ug_io_base)
> +		return -1;
> +
> +	while (!ug_is_rxfifo_ready() && count--)
> +		barrier();
> +	return ug_raw_getc();
> +}
> +
> +/*
> + * udbg functions.
> + *
> + */
> +
> +/*
> + * Transmits a character.
> + */
> +void ug_udbg_putc(char ch)
> +{
> +	ug_putc(ch);
> +}
> +
> +/*
> + * Receives a character. Waits until a character is available.
> + */
> +static int ug_udbg_getc(void)
> +{
> +	int ch;
> +
> +	while ((ch = ug_getc()) == -1)
> +		barrier();
> +	return ch;
> +}
> +
> +/*
> + * Receives a character. If a character is not available, returns -1.
> + */
> +static int ug_udbg_getc_poll(void)
> +{
> +	if (!ug_is_rxfifo_ready())
> +		return -1;
> +	return ug_getc();
> +}
> +
> +/*
> + * Retrieves and prepares the virtual address needed to access the  
> hardware.
> + */
> +static void __iomem *ug_udbg_setup_exi_io_base(struct device_node  
> *np)
> +{
> +	void __iomem *exi_io_base = NULL;
> +	phys_addr_t paddr;
> +	const unsigned int *reg;
> +
> +	reg = of_get_property(np, "reg", NULL);
> +	if (reg) {
> +		paddr = of_translate_address(np, reg);
> +		if (paddr)
> +			exi_io_base = ioremap(paddr, reg[1]);
> +	}
> +	return exi_io_base;
> +}
> +
> +/*
> + * Checks if a USB Gecko adapter is inserted in any memory card slot.
> + */
> +static void __iomem *ug_udbg_probe(void __iomem *exi_io_base)
> +{
> +	int i;
> +
> +	/* look for a usbgecko on memcard slots A and B */
> +	for (i = 0; i < 2; i++) {
> +		ug_io_base = exi_io_base + 0x14 * i;
> +		if (ug_is_adapter_present())
> +			break;
> +	}
> +	if (i == 2)
> +		ug_io_base = NULL;
> +	return ug_io_base;
> +
> +}
> +
> +/*
> + * USB Gecko udbg support initialization.
> + */
> +void __init ug_udbg_init(void)
> +{
> +	struct device_node *np;
> +	void __iomem *exi_io_base;
> +
> +	if (ug_io_base)
> +		udbg_printf("%s: early -> final\n", __func__);
> +
> +	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-exi");
> +	if (!np) {
> +		udbg_printf("%s: EXI node not found\n", __func__);
> +		goto done;
> +	}
> +
> +	exi_io_base = ug_udbg_setup_exi_io_base(np);
> +	if (!exi_io_base) {
> +		udbg_printf("%s: failed to setup EXI io base\n", __func__);
> +		goto done;
> +	}
> +
> +	if (!ug_udbg_probe(exi_io_base)) {
> +		udbg_printf("usbgecko_udbg: not found\n");
> +		iounmap(exi_io_base);
> +	} else {
> +		udbg_putc = ug_udbg_putc;
> +		udbg_getc = ug_udbg_getc;
> +		udbg_getc_poll = ug_udbg_getc_poll;
> +		udbg_printf("usbgecko_udbg: ready\n");
> +	}
> +
> +done:
> +	if (np)
> +		of_node_put(np);
> +	return;
> +}
> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h b/ 
> arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
> new file mode 100644
> index 0000000..3929de3
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
> @@ -0,0 +1,30 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
> + *
> + * udbg serial input/output routines for the USB Gecko adapter.
> + * Copyright (C) 2008-2009 The GameCube Linux Team
> + * Copyright (C) 2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#ifndef __USBGECKO_UDBG_H
> +#define __USBGECKO_UDBG_H
> +
> +#ifdef CONFIG_USBGECKO_UDBG
> +
> +extern void __init ug_udbg_init(void);
> +
> +#else
> +
> +static inline void __init ug_udbg_init(void)
> +{
> +}
> +
> +#endif /* CONFIG_USBGECKO_UDBG */
> +
> +#endif /* __USBGECKO_UDBG_H */
> -- 
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
