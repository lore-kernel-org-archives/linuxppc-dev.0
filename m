Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 05D5DB80AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:22:56 +1100 (EST)
Received: by gxk23 with SMTP id 23so5462422gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:22:55 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:22:35 -0700
Message-ID: <fa686aa40911221522y51eb900bn18433eedeb5aa0c8@mail.gmail.com>
Subject: Re: [RFC PATCH 09/19] powerpc: gamecube/wii: udbg support for
	usbgecko
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Add support for using the USB Gecko adapter via the udbg facility on
> the Nintendo GameCube and Wii video game consoles.
> The USB Gecko is a 3rd party memory card interface adapter that provides
> a EXI (External Interface) to USB serial converter.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/platforms/embedded6xx/Kconfig =A0 =A0 =A0 =A0 | =A0 13 +
> =A0arch/powerpc/platforms/embedded6xx/Makefile =A0 =A0 =A0 =A0| =A0 =A01 =
+
> =A0arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c | =A0285 ++++++++++=
++++++++++
> =A0arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h | =A0 30 ++
> =A04 files changed, 329 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
>
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/pl=
atforms/embedded6xx/Kconfig
> index 31487e4..bfd88be 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -95,3 +95,16 @@ config GAMECUBE_COMMON
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0select NOT_COHERENT_CACHE
>
> +config USBGECKO_UDBG
> + =A0 =A0 =A0 bool "USB Gecko udbg console for the Nintendo GameCube/Wii"
> + =A0 =A0 =A0 depends on GAMECUBE_COMMON
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes to this option, support will be included=
 for the
> + =A0 =A0 =A0 =A0 USB Gecko adapter as an udbg console.
> + =A0 =A0 =A0 =A0 The USB Gecko is a EXI to USB Serial converter that can=
 be plugged
> + =A0 =A0 =A0 =A0 into a memcard slot in the Nintendo GameCube/Wii.
> +
> + =A0 =A0 =A0 =A0 This driver bypasses the EXI layer completely.
> +
> + =A0 =A0 =A0 =A0 If in doubt, say N here.
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/p=
latforms/embedded6xx/Makefile
> index 0773c08..0ab7492 100644
> --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_STORCENTER) =A0 =A0 =A0 =A0+=3D storcenter.o
> =A0obj-$(CONFIG_PPC_HOLLY) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D holly.o
> =A0obj-$(CONFIG_PPC_PRPMC2800) =A0 =A0+=3D prpmc2800.o
> =A0obj-$(CONFIG_PPC_C2K) =A0 =A0 =A0 =A0 =A0+=3D c2k.o
> +obj-$(CONFIG_USBGECKO_UDBG) =A0 =A0+=3D usbgecko_udbg.o
> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/po=
werpc/platforms/embedded6xx/usbgecko_udbg.c
> new file mode 100644
> index 0000000..49f86e8
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> @@ -0,0 +1,285 @@
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
> +#define EXI_CLK_32MHZ =A0 =A0 =A0 =A0 =A0 5
> +
> +#define EXI_CSR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00
> +#define =A0 EXI_CSR_CLKMASK =A0 =A0 =A0 (0x7<<4)
> +#define =A0 =A0 EXI_CSR_CLK_32MHZ =A0 (EXI_CLK_32MHZ<<4)
> +#define =A0 EXI_CSR_CSMASK =A0 =A0 =A0 =A0(0x7<<7)
> +#define =A0 =A0 EXI_CSR_CS_0 =A0 =A0 =A0 =A0(0x1<<7) =A0/* Chip Select 0=
01 */
> +
> +#define EXI_CR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0c
> +#define =A0 EXI_CR_TSTART =A0 =A0 =A0 =A0 (1<<0)
> +#define =A0 EXI_CR_WRITE =A0 =A0 =A0 =A0 (1<<2)
> +#define =A0 EXI_CR_READ_WRITE =A0 =A0 (2<<2)
> +#define =A0 EXI_CR_TLEN(len) =A0 =A0 =A0(((len)-1)<<4)
> +
> +#define EXI_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x10
> +
> +#define UG_READ_ATTEMPTS =A0 =A0 =A0 100
> +#define UG_WRITE_ATTEMPTS =A0 =A0 =A0100
> +
> +
> +static void __iomem *ug_io_base;
> +
> +/*
> + * Performs one input/output transaction between the exi host and the us=
bgecko.
> + */
> +static u32 ug_io_transaction(u32 in)
> +{
> + =A0 =A0 =A0 u32 __iomem *csr_reg =3D ug_io_base + EXI_CSR;
> + =A0 =A0 =A0 u32 __iomem *data_reg =3D ug_io_base + EXI_DATA;
> + =A0 =A0 =A0 u32 __iomem *cr_reg =3D ug_io_base + EXI_CR;
> + =A0 =A0 =A0 u32 csr, data, cr;
> +
> + =A0 =A0 =A0 /* select */
> + =A0 =A0 =A0 csr =3D EXI_CSR_CLK_32MHZ | EXI_CSR_CS_0;
> + =A0 =A0 =A0 out_be32(csr_reg, csr);
> +
> + =A0 =A0 =A0 /* read/write */
> + =A0 =A0 =A0 data =3D in;
> + =A0 =A0 =A0 out_be32(data_reg, data);
> + =A0 =A0 =A0 cr =3D EXI_CR_TLEN(2) | EXI_CR_READ_WRITE | EXI_CR_TSTART;
> + =A0 =A0 =A0 out_be32(cr_reg, cr);
> +
> + =A0 =A0 =A0 while (in_be32(cr_reg) & EXI_CR_TSTART)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +
> + =A0 =A0 =A0 /* deselect */
> + =A0 =A0 =A0 out_be32(csr_reg, 0);
> +
> + =A0 =A0 =A0 /* result */
> + =A0 =A0 =A0 data =3D in_be32(data_reg);
> +
> + =A0 =A0 =A0 return data;
> +}
> +
> +/*
> + * Returns true if an usbgecko adapter is found.
> + */
> +static int ug_is_adapter_present(void)
> +{
> + =A0 =A0 =A0 if (!ug_io_base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return ug_io_transaction(0x90000000) =3D=3D 0x04700000;
> +}
> +
> +/*
> + * Returns true if the TX fifo is ready for transmission.
> + */
> +static int ug_is_txfifo_ready(void)
> +{
> + =A0 =A0 =A0 return ug_io_transaction(0xc0000000) & 0x04000000;
> +}
> +
> +/*
> + * Tries to transmit a character.
> + * If the TX fifo is not ready the result is undefined.
> + */
> +static void ug_raw_putc(char ch)
> +{
> + =A0 =A0 =A0 ug_io_transaction(0xb0000000 | (ch << 20));
> +}
> +
> +/*
> + * Transmits a character.
> + * It silently fails if the TX fifo is not ready after a number of retri=
es.
> + */
> +static void ug_putc(char ch)
> +{
> + =A0 =A0 =A0 int count =3D UG_WRITE_ATTEMPTS;
> +
> + =A0 =A0 =A0 if (!ug_io_base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (ch =3D=3D '\n')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_putc('\r');
> +
> + =A0 =A0 =A0 while (!ug_is_txfifo_ready() && count--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> + =A0 =A0 =A0 if (count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_raw_putc(ch);
> +}
> +
> +#if 0
> +/*
> + * Trasmits a null terminated character string.
> + */
> +static void ug_puts(char *s)
> +{
> + =A0 =A0 =A0 while (*s)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_putc(*s++);
> +}
> +#endif
> +
> +/*
> + * Returns true if the RX fifo is ready for transmission.
> + */
> +static int ug_is_rxfifo_ready(void)
> +{
> + =A0 =A0 =A0 return ug_io_transaction(0xd0000000) & 0x04000000;
> +}
> +
> +/*
> + * Tries to receive a character.
> + * If a character is unavailable the function returns -1.
> + */
> +static int ug_raw_getc(void)
> +{
> + =A0 =A0 =A0 u32 data =3D ug_io_transaction(0xa0000000);
> + =A0 =A0 =A0 if (data & 0x08000000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (data >> 16) & 0xff;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +}
> +
> +/*
> + * Receives a character.
> + * It fails if the RX fifo is not ready after a number of retries.
> + */
> +static int ug_getc(void)
> +{
> + =A0 =A0 =A0 int count =3D UG_READ_ATTEMPTS;
> +
> + =A0 =A0 =A0 if (!ug_io_base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 while (!ug_is_rxfifo_ready() && count--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> + =A0 =A0 =A0 return ug_raw_getc();
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
> + =A0 =A0 =A0 ug_putc(ch);
> +}
> +
> +/*
> + * Receives a character. Waits until a character is available.
> + */
> +static int ug_udbg_getc(void)
> +{
> + =A0 =A0 =A0 int ch;
> +
> + =A0 =A0 =A0 while ((ch =3D ug_getc()) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> + =A0 =A0 =A0 return ch;
> +}
> +
> +/*
> + * Receives a character. If a character is not available, returns -1.
> + */
> +static int ug_udbg_getc_poll(void)
> +{
> + =A0 =A0 =A0 if (!ug_is_rxfifo_ready())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 return ug_getc();
> +}
> +
> +/*
> + * Retrieves and prepares the virtual address needed to access the hardw=
are.
> + */
> +static void __iomem *ug_udbg_setup_io_base(struct device_node *np)
> +{
> + =A0 =A0 =A0 phys_addr_t paddr;
> + =A0 =A0 =A0 const unsigned int *reg;
> +
> + =A0 =A0 =A0 reg =3D of_get_property(np, "reg", NULL);
> + =A0 =A0 =A0 if (reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 paddr =3D of_translate_address(np, reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (paddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_io_base =3D ioremap(padd=
r, reg[1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ug_io_base;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return NULL;
> +}
> +
> +/*
> + * USB Gecko udbg support initialization.
> + */
> +void __init ug_udbg_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *np =3D NULL;
> + =A0 =A0 =A0 struct device_node *stdout;
> + =A0 =A0 =A0 const char *path;
> +
> + =A0 =A0 =A0 if (!of_chosen) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_printf("%s: missing of_chosen\n", __fu=
nc__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 path =3D of_get_property(of_chosen, "linux,stdout-path", NU=
LL);
> + =A0 =A0 =A0 if (!path) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_printf("%s: missing %s property", __fu=
nc__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "linux,stdout-path"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 stdout =3D of_find_node_by_path(path);
> + =A0 =A0 =A0 if (!stdout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_printf("%s: missing path %s", __func__=
, path);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (np =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 (np =3D of_find_compatible_node(np, NULL, "usbgecko=
,usbgecko"));)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (np =3D=3D stdout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 of_node_put(stdout);
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_printf("%s: stdout is not an usbgecko"=
, __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!ug_udbg_setup_io_base(np)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_printf("%s: failed to setup io base", =
__func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!ug_is_adapter_present()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_printf("usbgecko_udbg: not found\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_io_base =3D NULL;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_putc =3D ug_udbg_putc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_getc =3D ug_udbg_getc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_getc_poll =3D ug_udbg_getc_poll;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_printf("usbgecko_udbg: ready\n");
> + =A0 =A0 =A0 }
> +
> +done:
> + =A0 =A0 =A0 if (np)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 return;
> +}
> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h b/arch/po=
werpc/platforms/embedded6xx/usbgecko_udbg.h
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
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
