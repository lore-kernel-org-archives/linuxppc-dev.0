Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE003.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 30054DE1E7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 07:30:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Date: Mon, 23 Jun 2008 15:30:35 -0600
In-Reply-To: <20080623150846.40d65f08@zod.rchland.ibm.com>
References: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com>
	<20080623150846.40d65f08@zod.rchland.ibm.com>
From: John Linn <John.Linn@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-ID: <20080623213038.490C110B806B@mail11-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the comments Josh. =


I commented on the others that Stephen didn't comment on.

>> diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
>> index ccaedae..ec57ec9 100644
>> --- a/arch/powerpc/boot/io.h
>> +++ b/arch/powerpc/boot/io.h
>> @@ -99,4 +99,11 @@ static inline void barrier(void)
>>  	asm volatile("" : : : "memory");
>>  }
>> =

>> +static inline void disable_irq(void)
>> +{
>> +	int dummy;
>> +	asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" :
>> +	             "=3Dr" (dummy) : : "memory");
>> +}
>
>As you said, figuring out why this is here and at least adding a
>comment would be good.

Agreed.

>
>>  #endif /* _IO_H */
>> diff --git a/arch/powerpc/boot/virtex.c b/arch/powerpc/boot/virtex.c
>> new file mode 100644
>> index 0000000..5d807c6
>> --- /dev/null
>> +++ b/arch/powerpc/boot/virtex.c
>> @@ -0,0 +1,246 @@
>> +/*
>> + * Old U-boot compatibility for Walnut
>> + *
>> + * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
>You can remove this.  I'm pretty sure I didn't write this file :)
>

Agreed ;)

>> + *
>> + * Copyright 2007 IBM Corporation
>> + *   Based on cuboot-83xx.c, which is:
>> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
modify
>> it
>> + * under the terms of the GNU General Public License version 2 as
>> published
>> + * by the Free Software Foundation.
>> + */
>> +
>> +#include <stddef.h>
>> +#include <stdio.h>
>> +#include "ops.h"
>> +#include "dcr.h"
>> +#include "4xx.h"
>> +#include "io.h"
>> +#include "reg.h"
>> +
>> +BSS_STACK(4096);
>> +
>> +#include "types.h"
>> +#include "gunzip_util.h"
>> +#include <libfdt.h>
>> +#include "../../../include/linux/autoconf.h"
>
>Ew.  We've never included the CONFIG_ variables from Kconfig in the
>bootwrapper.  It's supposed to be independent of the kernel.
>

I'll try to better understand if we can detect the compressed device
tree and if we really have to disable the APU.

What's the reasoning for being independent of the kernel, maybe it's
obvious to everyone but me?

>> +#define UART_DLL		0	/* Out: Divisor Latch Low */
>> +#define UART_DLM		1	/* Out: Divisor Latch High */
>> +#define UART_FCR		2	/* Out: FIFO Control Register */
>> +#define UART_FCR_CLEAR_RCVR 	0x02 	/* Clear the RCVR FIFO
*/
>> +#define UART_FCR_CLEAR_XMIT	0x04 	/* Clear the XMIT FIFO */
>> +#define UART_LCR		3	/* Out: Line Control Register */
>> +#define UART_MCR		4	/* Out: Modem Control Register
>> */
>> +#define UART_MCR_RTS		0x02 	/* RTS complement */
>> +#define UART_MCR_DTR		0x01 	/* DTR complement */
>> +#define UART_LCR_DLAB		0x80 	/* Divisor latch access
bit */
>> +#define UART_LCR_WLEN8		0x03 	/* Wordlength: 8 bits */
>> +
>> +/* This function is only needed when there is no boot loader to
>> +   initialize the UART
>> +*/
>> +static int virtex_ns16550_console_init(void *devp)
>> +{
>> +	int n;
>> +	unsigned long reg_phys;
>> +	unsigned char *regbase;
>> +	u32 regshift, clk, spd;
>> +	u16 divisor;
>> +
>> +	n =3D getprop(devp, "virtual-reg", &regbase, sizeof(regbase));
>> +	if (n !=3D sizeof(regbase)) {
>> +		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
>> +			return -1;
>> +
>> +		regbase =3D (void *)reg_phys + 3;
>> +	}
>> +	regshift =3D 2;
>> +
>> +	n =3D getprop(devp, "current-speed", (void *)&spd, sizeof(spd));
>> +	if (n !=3D sizeof(spd))
>> +		spd =3D 9600;
>> +
>> +	/* should there be a default clock rate?*/
>> +	n =3D getprop(devp, "clock-frequency", (void *)&clk, sizeof(clk));
>> +	if (n !=3D sizeof(clk))
>> +		return -1;
>> +
>> +	divisor =3D clk / (16 * spd);
>> +
>> +	/* Access baud rate */
>> +	out_8(regbase + (UART_LCR << regshift), UART_LCR_DLAB);
>> +
>> +	/* Baud rate based on input clock */
>> +	out_8(regbase + (UART_DLL << regshift), divisor & 0xFF);
>> +	out_8(regbase + (UART_DLM << regshift), divisor >> 8);
>> +
>> +	/* 8 data, 1 stop, no parity */
>> +	out_8(regbase + (UART_LCR << regshift), UART_LCR_WLEN8);
>> +
>> +	/* RTS/DTR */
>> +	out_8(regbase + (UART_MCR << regshift), UART_MCR_RTS |
>> UART_MCR_DTR);
>> +
>> +	/* Clear transmitter and receiver */
>> +	out_8(regbase + (UART_FCR << regshift),
>> +				UART_FCR_CLEAR_XMIT |
>> UART_FCR_CLEAR_RCVR);
>> +	return 0;
>> +}
>> +
>> +/* For virtex, the kernel may be loaded without using a bootloader
and
>> if so
>> +   some UARTs need more setup than is provided in the normal console
>> init
>> +*/
>> +static int virtex_serial_console_init(void)
>> +{
>> +	void *devp;
>> +	char devtype[MAX_PROP_LEN];
>> +	char path[MAX_PATH_LEN];
>> +
>> +	devp =3D finddevice("/chosen");
>> +	if (devp =3D=3D NULL)
>> +		return -1;
>> +
>> +	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0)
>> {
>> +		devp =3D finddevice(path);
>> +		if (devp =3D=3D NULL)
>> +			return -1;
>> +
>> +		if ((getprop(devp, "device_type", devtype,
>> sizeof(devtype)) > 0)
>> +				&& !strcmp(devtype, "serial")
>> +				&& (dt_is_compatible(devp, "ns16550")))
>> +				virtex_ns16550_console_init(devp);
>> +	}
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +static struct gunzip_state gzstate;
>> +#endif
>> +
>> +void platform_init(void)
>> +{
>> +	u32 memreg[4];
>> +	u64 start;
>> +	u64 size =3D 0x2000000;
>> +	int naddr, nsize, i;
>> +	void *root, *memory;
>> +	static const unsigned long line_size =3D 32;
>> +	static const unsigned long congruence_classes =3D 256;
>> +	unsigned long addr;
>> +	unsigned long dccr;
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +	void *dtbz_start;
>> +	u32 dtbz_size;
>> +	void *dtb_addr;
>> +	u32 dtb_size;
>> +	struct fdt_header dtb_header;
>> +	int len;
>> +#endif
>> +
>> +        if((mfpvr() & 0xfffff000) =3D=3D 0x20011000) {
>> +            /* PPC errata 213: only for Virtex-4 FX */
>> +            __asm__("mfccr0  0\n\t"
>> +                    "oris    0,0,0x50000000@h\n\t"
>> +                    "mtccr0  0"
>> +                    : : : "0");
>> +        }
>> +
>> +	/*
>> +	 * Invalidate the data cache if the data cache is turned off.
>> +	 * - The 405 core does not invalidate the data cache on power-up
>> +	 *   or reset but does turn off the data cache. We cannot assume
>> +	 *   that the cache contents are valid.
>> +	 * - If the data cache is turned on this must have been done by
>> +	 *   a bootloader and we assume that the cache contents are
>> +	 *   valid.
>> +	 */
>> +	__asm__("mfdccr %0": "=3Dr" (dccr));
>> +	if (dccr =3D=3D 0) {
>> +		for (addr =3D 0;
>> +		     addr < (congruence_classes * line_size);
>> +		     addr +=3D line_size) {
>> +			__asm__("dccci 0,%0": :"b"(addr));
>> +		}
>> +	}
>> +
>> +#if defined(CONFIG_XILINX_VIRTEX_5_FXT) &&
>> defined(CONFIG_MATH_EMULATION)
>> +	/* Make sure the APU is disabled when using soft FPU emulation
>> */
>> +	mtdcr(5, 0);
>> +#endif
>> +
>> +	disable_irq();
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +
>> +        /** FIXME: flatdevicetrees need the initializer allocated,
>> +            libfdt will fix this. */
>> +	dtbz_start =3D (void *)CONFIG_COMPRESSED_DTB_START;
>> +	dtbz_size =3D CONFIG_COMPRESSED_DTB_SIZE;
>> +	/** get the device tree */
>> +	gunzip_start(&gzstate, dtbz_start, dtbz_size);
>> +	gunzip_exactly(&gzstate, &dtb_header, sizeof(dtb_header));
>> +
>> +	dtb_size =3D dtb_header.totalsize;
>> +	// printf("Allocating 0x%lx bytes for dtb ...\n\r", dtb_size);
>> +
>> +	dtb_addr =3D _end; // Should be allocated?
>> +
>> +	gunzip_start(&gzstate, dtbz_start, dtbz_size);
>> +	len =3D gunzip_finish(&gzstate, dtb_addr, dtb_size);
>> +	if (len !=3D dtb_size)
>> +		fatal("ran out of data!  only got 0x%x of 0x%lx
>> bytes.\n\r",
>> +				len, dtb_size);
>> +	printf("done 0x%x bytes\n\r", len);
>> +	simple_alloc_init(0x800000, size - (unsigned long)0x800000, 32,
>> 64);
>> +	fdt_init(dtb_addr);
>> +#else
>> +        /** FIXME: flatdevicetrees need the initializer allocated,
>> +            libfdt will fix this. */
>> +	simple_alloc_init(_end, size - (unsigned long)_end, 32, 64);
>> +	fdt_init(_dtb_start);
>> +#endif
>> +
>> +	root =3D finddevice("/");
>> +	if (getprop(root, "#address-cells", &naddr, sizeof(naddr)) < 0)
>> +		naddr =3D 2;
>> +	if (naddr < 1 || naddr > 2)
>> +		fatal("Can't cope with #address-cells =3D=3D %d in /\n\r",
>> naddr);
>> +
>> +	if (getprop(root, "#size-cells", &nsize, sizeof(nsize)) < 0)
>> +		nsize =3D 1;
>> +	if (nsize < 1 || nsize > 2)
>> +		fatal("Can't cope with #size-cells =3D=3D %d in /\n\r",
>> nsize);
>> +
>> +	memory =3D finddevice("/memory@0");
>> +	if (! memory) {
>> +		fatal("Need a memory@0 node!\n\r");
>> +	}
>> +	if (getprop(memory, "reg", memreg, sizeof(memreg)) < 0)
>> +		fatal("Need a memory@0 node!\n\r");
>> +
>> +	i =3D 0;
>> +	start =3D memreg[i++];
>> +	if(naddr =3D=3D 2) {
>> +		start =3D (start << 32) | memreg[i++];
>> +	}
>> +	size =3D memreg[i++];
>> +	if (nsize =3D=3D 2)
>> +		size =3D (size << 32) | memreg[i++];
>> +
>> +	// timebase_period_ns =3D 1000000000 / timebase;
>> +	virtex_serial_console_init();
>> +	serial_console_init();
>> +	if (console_ops.open)
>> +		console_ops.open();
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +	printf("Using compressed device tree at 0x%x\n\r",
>> CONFIG_COMPRESSED_DTB_START);
>> +#else
>> +#endif
>> +        printf("booting virtex\n\r");
>> +        printf("memstart=3D0x%llx\n\r", start);
>> +        printf("memsize=3D0x%llx\n\r", size);
>> +}
>
>Shouldn't you be able to detect a compressed device tree based on the
>gzip header?  Or something similar?
>

I'll look into it.

>
>> diff --git a/arch/powerpc/platforms/44x/Kconfig
>> b/arch/powerpc/platforms/44x/Kconfig
>> index 6abe913..b90b33d 100644
>> --- a/arch/powerpc/platforms/44x/Kconfig
>> +++ b/arch/powerpc/platforms/44x/Kconfig
>> @@ -102,6 +102,58 @@ config YOSEMITE
>>  #	help
>>  #	  This option enables support for the IBM PPC440GX evaluation
>> board.
>> =

>> +config XILINX_ML507
>> +	bool "Xilinx ML507 Reference System"
>> +	depends on 44x
>> +	default n
>> +	select XILINX_ML5XX
>> +	select WANT_DEVICE_TREE
>> +	help
>> +	  This option enables support for the Xilinx ML507 board.
>> +
>> +config XILINX_DISABLE_44x_CACHE
>> +	bool "Disable PPC440 caches"
>> +	depends on XILINX_ML507
>> +	help
>> +	  This option allows to disable the caches on the PPC440. Some
>> early
>> +	  PPC440 soft-cores do not work with caches enabled. Also, some
>> early
>> +	  ML507 boards do have a non-functioning cache. If you have any
>> +	  problems running the ML5, try using this option.
>> +
>> +config PPC_FPU
>> +	depends on XILINX_VIRTEX_5_FXT
>> +	bool "Enable Xilinx Soft FPU"
>> +	help
>> +	  This option enables the Xilinx Soft FPU attached to the APU
>> +	  interface of the PPC440 (requires DP_FULL FPU pcore).
>
>There is already a PPC_FPU option in platforms/Kconfig.cputype
>

Agreed, don't see any reason why we can't use the one that already
exists.

>josh
>


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
