Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 9F6F3B7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:50:28 +1100 (EST)
Received: by ywh17 with SMTP id 17so4627134ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 14:50:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 15:50:06 -0700
Message-ID: <fa686aa40911221450u21b813d3s6abe84223dc1efab@mail.gmail.com>
Subject: Re: [RFC PATCH 01/19] powerpc: gamecube/wii: usbgecko bootwrapper
	console support
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
> Add support for using the USB Gecko adapter as a bootwrapper console on
> the Nintendo GameCube and Wii video game consoles.
> The USB Gecko is a 3rd party memory card interface adapter that provides
> a EXI (External Interface) to USB serial converter.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/boot/Makefile | =A0 =A02 +-
> =A0arch/powerpc/boot/ugecon.c | =A0128 ++++++++++++++++++++++++++++++++++=
++++++++++
> =A0arch/powerpc/boot/ugecon.h | =A0 25 +++++++++
> =A03 files changed, 154 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/ugecon.c
> =A0create mode 100644 arch/powerpc/boot/ugecon.h
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 7bfc8ad..44bce21 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -66,7 +66,7 @@ src-wlib :=3D string.S crt0.S crtsavres.S stdio.c main.=
c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gunzip_util.c elf_util.c $(zlib) devtree.c=
 oflib.c ofconsole.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c=
.c cuboot.c bamboo.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpm-serial.c stdlib.c mpc52xx-psc.c planet=
core.c uartlite.c \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl-soc.c mpc8xx.c pq2.c
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl-soc.c mpc8xx.c pq2.c ugecon.c
> =A0src-plat :=3D of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85=
xx.c holly.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cuboot-ebony.c cuboot-hotfoot.c treeboot-e=
bony.c prpmc2800.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps3-head.S ps3-hvcall.S ps3.c treeboot-bam=
boo.c cuboot-8xx.c \
> diff --git a/arch/powerpc/boot/ugecon.c b/arch/powerpc/boot/ugecon.c
> new file mode 100644
> index 0000000..704f374
> --- /dev/null
> +++ b/arch/powerpc/boot/ugecon.c
> @@ -0,0 +1,128 @@
> +/*
> + * arch/powerpc/boot/ugecon.c
> + *
> + * USB Gecko bootwrapper console.
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
> +#include <stddef.h>
> +#include "stdio.h"
> +#include "types.h"
> +#include "io.h"
> +#include "ops.h"
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
> +
> +/* virtual address base for input/output, retrieved from device tree */
> +static void *ug_io_base;
> +
> +
> +static u32 ug_io_transaction(u32 in)
> +{
> + =A0 =A0 =A0 u32 *csr_reg =3D ug_io_base + EXI_CSR;
> + =A0 =A0 =A0 u32 *data_reg =3D ug_io_base + EXI_DATA;
> + =A0 =A0 =A0 u32 *cr_reg =3D ug_io_base + EXI_CR;
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
> + =A0 =A0 =A0 data =3D in_be32(data_reg);
> + =A0 =A0 =A0 return data;
> +}
> +
> +static int ug_is_txfifo_ready(void)
> +{
> + =A0 =A0 =A0 return ug_io_transaction(0xc0000000) & 0x04000000;
> +}
> +
> +static void ug_raw_putc(char ch)
> +{
> + =A0 =A0 =A0 ug_io_transaction(0xb0000000 | (ch << 20));
> +}
> +
> +static void ug_putc(char ch)
> +{
> + =A0 =A0 =A0 int count =3D 16;
> +
> + =A0 =A0 =A0 if (!ug_io_base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 while (!ug_is_txfifo_ready() && count--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> + =A0 =A0 =A0 if (count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_raw_putc(ch);
> +}
> +
> +void ug_console_write(const char *buf, int len)
> +{
> + =A0 =A0 =A0 char *b =3D (char *)buf;
> +
> + =A0 =A0 =A0 while (len--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*b =3D=3D '\n')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_putc('\r');
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ug_putc(*b++);
> + =A0 =A0 =A0 }
> +}
> +
> +int ug_is_adapter_present(void)
> +{
> + =A0 =A0 =A0 if (!ug_io_base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return ug_io_transaction(0x90000000) =3D=3D 0x04700000;
> +}
> +
> +int ug_grab_io_base(void)
> +{
> + =A0 =A0 =A0 u32 v;
> + =A0 =A0 =A0 void *devp;
> +
> + =A0 =A0 =A0 devp =3D find_node_by_alias("ugecon");
> + =A0 =A0 =A0 if (devp =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 if (getprop(devp, "virtual-reg", &v, sizeof(v)) !=3D sizeof=
(v))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> +
> + =A0 =A0 =A0 ug_io_base =3D (u8 *)v;
> + =A0 =A0 =A0 return 0;
> +
> +err_out:
> + =A0 =A0 =A0 return -1;
> +}
> diff --git a/arch/powerpc/boot/ugecon.h b/arch/powerpc/boot/ugecon.h
> new file mode 100644
> index 0000000..1fdb590
> --- /dev/null
> +++ b/arch/powerpc/boot/ugecon.h
> @@ -0,0 +1,25 @@
> +/*
> + * arch/powerpc/boot/ugecon.h
> + *
> + * USB Gecko early bootwrapper console.
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
> +#ifndef __UGECON_H
> +#define __UGECON_H
> +
> +extern int ug_grab_io_base(void);
> +extern int ug_is_adapter_present(void);
> +
> +extern void ug_putc(char ch);
> +extern void ug_console_write(const char *buf, int len);
> +
> +#endif /* __UGECON_H */
> +
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
