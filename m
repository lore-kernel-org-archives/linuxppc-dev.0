Return-Path: <qiang.zhao@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20069.outbound.protection.outlook.com [40.107.2.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfw0w5nXCzDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 13:55:44 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Qiang Zhao <qiang.zhao@nxp.com>, "oss@buserror.net" <oss@buserror.net>,
 "tglx@linutronix.de" <tglx@linutronix.de>
CC: "jason@lakedaemon.net" <jason@lakedaemon.net>, "marc.zyngier@arm.com"
 <marc.zyngier@arm.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v6 1/4] irqchip/qeic: move qeic driver from
 drivers/soc/fsl/qe
Date: Fri, 16 Dec 2016 02:55:38 +0000
Message-ID: <AM3PR04MB1185838FB1092C2334D27EA7919C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1475033103-18192-1-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1475033103-18192-1-git-send-email-qiang.zhao@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Any comments on this patchset?

Best Regards
Zhao Qiang

> -----Original Message-----
> From: Zhao Qiang [mailto:qiang.zhao@nxp.com]
> Sent: Wednesday, September 28, 2016 11:25 AM
> To: oss@buserror.net; tglx@linutronix.de
> Cc: jason@lakedaemon.net; marc.zyngier@arm.com; X.B. Xie
> <xiaobo.xie@nxp.com>; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Qiang Zhao <qiang.zhao@nxp.com>
> Subject: [PATCH v6 1/4] irqchip/qeic: move qeic driver from drivers/soc/f=
sl/qe
>=20
> move the driver from drivers/soc/fsl/qe to drivers/irqchip, merge qe_ic.h=
 and
> qe_ic.c into irq-qeic.c.
>=20
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- modify the subject and commit msg
> Changes for v3:
> 	- merge .h file to .c, rename it with irq-qeic.c Changes for v4:
> 	- modify comments
> Changes for v5:
> 	- disable rename detection
> Changes for v6:
> 	- rebase
>=20
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} |  95 +++++++++++++=
+++++-
>  drivers/soc/fsl/qe/Makefile                        |   2 +-
>  drivers/soc/fsl/qe/qe_ic.h                         | 103 ---------------=
------
>  4 files changed, 94 insertions(+), 107 deletions(-)  rename
> drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} (85%)  delete mode 1=
00644
> drivers/soc/fsl/qe/qe_ic.h
>=20
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> 4c203b6..face608 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -71,3 +71,4 @@ obj-$(CONFIG_MVEBU_ODMI)		+=3D irq-mvebu-
> odmi.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+=3D irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+=3D irq-eznps.o
>  obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-vic.o
> +obj-$(CONFIG_QUICC_ENGINE)		+=3D irq-qeic.o
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/irqchip/irq-qeic.c simi=
larity
> index 85% rename from drivers/soc/fsl/qe/qe_ic.c rename to
> drivers/irqchip/irq-qeic.c index ec2ca86..48ceded 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/irqchip/irq-qeic.c
> @@ -1,7 +1,7 @@
>  /*
> - * arch/powerpc/sysdev/qe_lib/qe_ic.c
> + * drivers/irqchip/irq-qeic.c
>   *
> - * Copyright (C) 2006 Freescale Semiconductor, Inc.  All rights reserved=
.
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.  All rights reserved=
.
>   *
>   * Author: Li Yang <leoli@freescale.com>
>   * Based on code from Shlomi Gridish <gridish@freescale.com> @@ -30,7
> +30,96 @@  #include <asm/io.h>  #include <soc/fsl/qe/qe_ic.h>
>=20
> -#include "qe_ic.h"
> +#define NR_QE_IC_INTS		64
> +
> +/* QE IC registers offset */
> +#define QEIC_CICR		0x00
> +#define QEIC_CIVEC		0x04
> +#define QEIC_CRIPNR		0x08
> +#define QEIC_CIPNR		0x0c
> +#define QEIC_CIPXCC		0x10
> +#define QEIC_CIPYCC		0x14
> +#define QEIC_CIPWCC		0x18
> +#define QEIC_CIPZCC		0x1c
> +#define QEIC_CIMR		0x20
> +#define QEIC_CRIMR		0x24
> +#define QEIC_CICNR		0x28
> +#define QEIC_CIPRTA		0x30
> +#define QEIC_CIPRTB		0x34
> +#define QEIC_CRICR		0x3c
> +#define QEIC_CHIVEC		0x60
> +
> +/* Interrupt priority registers */
> +#define CIPCC_SHIFT_PRI0	29
> +#define CIPCC_SHIFT_PRI1	26
> +#define CIPCC_SHIFT_PRI2	23
> +#define CIPCC_SHIFT_PRI3	20
> +#define CIPCC_SHIFT_PRI4	13
> +#define CIPCC_SHIFT_PRI5	10
> +#define CIPCC_SHIFT_PRI6	7
> +#define CIPCC_SHIFT_PRI7	4
> +
> +/* CICR priority modes */
> +#define CICR_GWCC		0x00040000
> +#define CICR_GXCC		0x00020000
> +#define CICR_GYCC		0x00010000
> +#define CICR_GZCC		0x00080000
> +#define CICR_GRTA		0x00200000
> +#define CICR_GRTB		0x00400000
> +#define CICR_HPIT_SHIFT		8
> +#define CICR_HPIT_MASK		0x00000300
> +#define CICR_HP_SHIFT		24
> +#define CICR_HP_MASK		0x3f000000
> +
> +/* CICNR */
> +#define CICNR_WCC1T_SHIFT	20
> +#define CICNR_ZCC1T_SHIFT	28
> +#define CICNR_YCC1T_SHIFT	12
> +#define CICNR_XCC1T_SHIFT	4
> +
> +/* CRICR */
> +#define CRICR_RTA1T_SHIFT	20
> +#define CRICR_RTB1T_SHIFT	28
> +
> +/* Signal indicator */
> +#define SIGNAL_MASK		3
> +#define SIGNAL_HIGH		2
> +#define SIGNAL_LOW		0
> +
> +struct qe_ic {
> +	/* Control registers offset */
> +	volatile u32 __iomem *regs;
> +
> +	/* The remapper for this QEIC */
> +	struct irq_domain *irqhost;
> +
> +	/* The "linux" controller struct */
> +	struct irq_chip hc_irq;
> +
> +	/* VIRQ numbers of QE high/low irqs */
> +	unsigned int virq_high;
> +	unsigned int virq_low;
> +};
> +
> +/*
> + * QE interrupt controller internal structure  */ struct qe_ic_info {
> +	/* location of this source at the QIMR register. */
> +	u32	mask;
> +
> +	/* Mask register offset */
> +	u32	mask_reg;
> +
> +	/*
> +	 * for grouped interrupts sources - the interrupt
> +	 * code as appears at the group priority register
> +	 */
> +	u8	pri_code;
> +
> +	/* Group priority register offset */
> +	u32	pri_reg;
> +};
>=20
>  static DEFINE_RAW_SPINLOCK(qe_ic_lock);
>=20
> diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile in=
dex
> 2031d38..51e4726 100644
> --- a/drivers/soc/fsl/qe/Makefile
> +++ b/drivers/soc/fsl/qe/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for the linux ppc-specific parts of QE  # -obj-
> $(CONFIG_QUICC_ENGINE)+=3D qe.o qe_common.o qe_ic.o qe_io.o
> +obj-$(CONFIG_QUICC_ENGINE)+=3D qe.o qe_common.o qe_io.o
>  obj-$(CONFIG_CPM)	+=3D qe_common.o
>  obj-$(CONFIG_UCC)	+=3D ucc.o
>  obj-$(CONFIG_UCC_SLOW)	+=3D ucc_slow.o
> diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h dele=
ted file
> mode 100644 index 926a2ed..0000000
> --- a/drivers/soc/fsl/qe/qe_ic.h
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -/*
> - * drivers/soc/fsl/qe/qe_ic.h
> - *
> - * QUICC ENGINE Interrupt Controller Header
> - *
> - * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
> - *
> - * Author: Li Yang <leoli@freescale.com>
> - * Based on code from Shlomi Gridish <gridish@freescale.com>
> - *
> - * This program is free software; you can redistribute  it and/or modify=
 it
> - * under  the terms of  the GNU General  Public License as published by =
the
> - * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> - * option) any later version.
> - */
> -#ifndef _POWERPC_SYSDEV_QE_IC_H
> -#define _POWERPC_SYSDEV_QE_IC_H
> -
> -#include <soc/fsl/qe/qe_ic.h>
> -
> -#define NR_QE_IC_INTS		64
> -
> -/* QE IC registers offset */
> -#define QEIC_CICR		0x00
> -#define QEIC_CIVEC		0x04
> -#define QEIC_CRIPNR		0x08
> -#define QEIC_CIPNR		0x0c
> -#define QEIC_CIPXCC		0x10
> -#define QEIC_CIPYCC		0x14
> -#define QEIC_CIPWCC		0x18
> -#define QEIC_CIPZCC		0x1c
> -#define QEIC_CIMR		0x20
> -#define QEIC_CRIMR		0x24
> -#define QEIC_CICNR		0x28
> -#define QEIC_CIPRTA		0x30
> -#define QEIC_CIPRTB		0x34
> -#define QEIC_CRICR		0x3c
> -#define QEIC_CHIVEC		0x60
> -
> -/* Interrupt priority registers */
> -#define CIPCC_SHIFT_PRI0	29
> -#define CIPCC_SHIFT_PRI1	26
> -#define CIPCC_SHIFT_PRI2	23
> -#define CIPCC_SHIFT_PRI3	20
> -#define CIPCC_SHIFT_PRI4	13
> -#define CIPCC_SHIFT_PRI5	10
> -#define CIPCC_SHIFT_PRI6	7
> -#define CIPCC_SHIFT_PRI7	4
> -
> -/* CICR priority modes */
> -#define CICR_GWCC		0x00040000
> -#define CICR_GXCC		0x00020000
> -#define CICR_GYCC		0x00010000
> -#define CICR_GZCC		0x00080000
> -#define CICR_GRTA		0x00200000
> -#define CICR_GRTB		0x00400000
> -#define CICR_HPIT_SHIFT		8
> -#define CICR_HPIT_MASK		0x00000300
> -#define CICR_HP_SHIFT		24
> -#define CICR_HP_MASK		0x3f000000
> -
> -/* CICNR */
> -#define CICNR_WCC1T_SHIFT	20
> -#define CICNR_ZCC1T_SHIFT	28
> -#define CICNR_YCC1T_SHIFT	12
> -#define CICNR_XCC1T_SHIFT	4
> -
> -/* CRICR */
> -#define CRICR_RTA1T_SHIFT	20
> -#define CRICR_RTB1T_SHIFT	28
> -
> -/* Signal indicator */
> -#define SIGNAL_MASK		3
> -#define SIGNAL_HIGH		2
> -#define SIGNAL_LOW		0
> -
> -struct qe_ic {
> -	/* Control registers offset */
> -	volatile u32 __iomem *regs;
> -
> -	/* The remapper for this QEIC */
> -	struct irq_domain *irqhost;
> -
> -	/* The "linux" controller struct */
> -	struct irq_chip hc_irq;
> -
> -	/* VIRQ numbers of QE high/low irqs */
> -	unsigned int virq_high;
> -	unsigned int virq_low;
> -};
> -
> -/*
> - * QE interrupt controller internal structure
> - */
> -struct qe_ic_info {
> -	u32	mask;	  /* location of this source at the QIMR register. */
> -	u32	mask_reg; /* Mask register offset */
> -	u8	pri_code; /* for grouped interrupts sources - the interrupt
> -			     code as appears at the group priority register */
> -	u32	pri_reg;  /* Group priority register offset */
> -};
> -
> -#endif /* _POWERPC_SYSDEV_QE_IC_H */
> --
> 2.1.0.27.g96db324
