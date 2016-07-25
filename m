Return-Path: <jason@lakedaemon.net>
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryrmX5CbgzDrJM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 05:24:44 +1000 (AEST)
Date: Mon, 25 Jul 2016 19:23:33 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, xiaobo.xie@nxp.com
Subject: Re: [Patch v3 1/3] irqchip/qeic: move qeic driver from
 drivers/soc/fsl/qe
Message-ID: <20160725192333.GB4541@io.lakedaemon.net>
References: <1469437196-38003-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469437196-38003-1-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zhao Qiang,

On Mon, Jul 25, 2016 at 04:59:54PM +0800, Zhao Qiang wrote:
> move the driver from drivers/soc/fsl/qe to drivers/irqchip,
> merge qe_ic.h and qe_ic.c into irq-qeic.c.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- modify the subject and commit msg
> Changes for v3:
> 	- merge .h file to .c, rename it with irq-qeic.c
> 
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} |  82 +++++++++++++++-
>  drivers/soc/fsl/qe/Makefile                        |   2 +-
>  drivers/soc/fsl/qe/qe_ic.h                         | 103 ---------------------
>  4 files changed, 83 insertions(+), 105 deletions(-)
>  rename drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} (85%)
>  delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 38853a1..cef999d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -69,3 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
>  obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
> +obj-$(CONFIG_QUICC_ENGINE)		+= qe_ic.o

Did you test this? ;-)

> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/irqchip/irq-qeic.c
> similarity index 85%
> rename from drivers/soc/fsl/qe/qe_ic.c
> rename to drivers/irqchip/irq-qeic.c
> index ec2ca86..1f91225 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/irqchip/irq-qeic.c
> @@ -30,7 +30,87 @@
>  #include <asm/io.h>
>  #include <soc/fsl/qe/qe_ic.h>
>  
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
> + * QE interrupt controller internal structure
> + */
> +struct qe_ic_info {
> +	u32	mask;	  /* location of this source at the QIMR register. */
> +	u32	mask_reg; /* Mask register offset */
> +	u8	pri_code; /* for grouped interrupts sources - the interrupt
> +			     code as appears at the group priority register */
> +	u32	pri_reg;  /* Group priority register offset */
> +};

Please, no tail comments.  Refer to KernelDoc.

>  
>  static DEFINE_RAW_SPINLOCK(qe_ic_lock);
>  
> diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
> index 2031d38..51e4726 100644
> --- a/drivers/soc/fsl/qe/Makefile
> +++ b/drivers/soc/fsl/qe/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for the linux ppc-specific parts of QE
>  #
> -obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_ic.o qe_io.o
> +obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_io.o
>  obj-$(CONFIG_CPM)	+= qe_common.o
>  obj-$(CONFIG_UCC)	+= ucc.o
>  obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
> diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
> deleted file mode 100644
> index 926a2ed..0000000
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
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
> - */

Please transfer this over as well, and update is as necessary.

thx,

Jason.
