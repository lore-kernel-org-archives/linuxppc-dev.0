Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id D2F1967CB2
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 17:55:09 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so674692ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 05 Nov 2006 22:55:07 -0800 (PST)
Message-ID: <528646bc0611052255m6faf6466of48fcbb3d74ffaa5@mail.gmail.com>
Date: Sun, 5 Nov 2006 23:55:07 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
In-Reply-To: <454A5952.6090801@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <454902F9.20206@bplan-gmbh.de>
	<1162419138.25682.453.camel@localhost.localdomain>
	<454A1C37.5050208@bplan-gmbh.de> <454A5952.6090801@bplan-gmbh.de>
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I still haven't had the time to get this code working on my board, and
I haven't followed the discussion over the last week very carefully,
but here's my comments anyway.  :)

On 11/2/06, Nicolas DET <nd@bplan-gmbh.de> wrote:
> --- a/arch/powerpc/sysdev/mpc52xx_pic.c 1970-01-01 01:00:00.000000000 +0100
> +++ b/arch/powerpc/sysdev/mpc52xx_pic.c 2006-11-02 17:56:10.000000000 +0100
> +static inline void io_be_setbit(u32 __iomem *addr, int bitno)
> +{
> +       out_be32(addr, in_be32(addr) | (1 << bitno) );
> +}
> +
> +static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
> +{
> +       out_be32(addr, in_be32(addr) & ~(1 << bitno));
> +}
> +

Do these belong somewhere else?  In common code somewhere?  Does this
have the side effect of looking like an atomic operation to the casual
observer?  (That's a coding convention question directed at Ben)

> +static inline struct device_node *find_mpc52xx_picnode(void)
> +{
> +       return of_find_compatible_node(NULL, "interrupt-controller",
> +                                      "mpc5200-pic");
> +}
> +
> +static inline struct device_node *find_mpc52xx_sdmanode(void)
> +{
> +       return of_find_compatible_node(NULL, "dma-controller",
> +                                      "mpc5200-bestcomm");
> +}

I don't think this is a very good idea from a maintenance perspective.
 Effectively, they replace a single line of code with 5 lines (4 for
the static func, 1 where it is called).  If in the future they ever
need to be called in more than 1 or 2 places, then this could be
revisited.

> +
> +/*
> + * IRQ[0-3] interrupt irq_chip
> +*/
> +
> +static void mpc52xx_extirq_mask(unsigned int virq)
> +{
> +       int irq;
> +       int l2irq;
> +
> +       irq = irq_map[virq].hwirq;
> +       l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;

L2 offset will always be 0; why not just omit all references to it?
Keeps the code slightly more concise.

> +/*
> + * init (public)
> +*/
> +
> +void __init mpc52xx_init_irq(void)
> +{
> +       struct device_node *picnode;
> +       int picnode_regsize;
> +       u32 picnode_regoffset;
> +
> +       struct device_node *sdmanode;
> +       int sdmanode_regsize;
> +       u32 sdmanode_regoffset;
> +
> +       u64 size64;
> +       int flags;
> +
> +       u32 intr_ctrl;
> +
> +       picnode = find_mpc52xx_picnode();
> +       sdmanode = find_mpc52xx_sdmanode();
> +
> +       if ( (picnode == NULL) || (sdmanode == NULL) )
> +               return;

I don't think you should fail silently here.

> +
> +       /* Retrieve PIC ressources */
> +       picnode_regoffset = (u32) of_get_address(picnode, 0, &size64, &flags);
> +       if (picnode_regoffset == 0)
> +               return ;

ditto

> +
> +       picnode_regoffset = of_translate_address(picnode, (u32 *) picnode_regoffset);
> +       picnode_regsize = (int)size64;
> +
> +       /* Retrieve SDMA ressources */
> +       sdmanode_regoffset = (u32) of_get_address(sdmanode, 0, &size64, &flags);
> +       if (sdmanode_regoffset == 0)
> +               return ;

ditto

> +
> +       sdmanode_regoffset = of_translate_address(sdmanode, (u32 *) sdmanode_regoffset);
> +       sdmanode_regsize = (int)size64;
> +
> +       /* Remap the necessary zones */
> +       intr = ioremap(picnode_regoffset, picnode_regsize);
> +       sdma = ioremap(sdmanode_regoffset, sdmanode_regsize);
> +
> +       if ((intr == NULL) || (sdma == NULL))
> +               panic("Can't ioremap PIC/SDMA register or init_irq !");
> +
> +       printk(KERN_INFO "Remapped MPC52xx PIC at 0x%8.8x\n", picnode_regoffset);
> +       printk(KERN_INFO "Remapped MPC52xx SDMA at 0x%8.8x\n", sdmanode_regoffset);
> +
> +       of_node_put(picnode);
> +       of_node_put(sdmanode);

Silent failure cases above will bypass these calls to of_node_put().

> +
> +       /* Disable all interrupt sources. */
> +       out_be32(&sdma->IntPend, 0xffffffff);   /* 1 means clear pending */
> +       out_be32(&sdma->IntMask, 0xffffffff);   /* 1 means disabled */
> +       out_be32(&intr->per_mask, 0x7ffffc00);  /* 1 means disabled */
> +       out_be32(&intr->main_mask, 0x00010fff); /* 1 means disabled */
> +       intr_ctrl = in_be32(&intr->ctrl);
> +       intr_ctrl &= 0x00ff0000;        /* Keeps IRQ[0-3] config */
> +       intr_ctrl |= 0x0f000000 |       /* clear IRQ 0-3 */
> +           0x00001000 |        /* MEE master external enable */
> +           0x00000000 |        /* 0 means disable IRQ 0-3 */
> +           0x00000001;         /* CEb route critical normally */
> +       out_be32(&intr->ctrl, intr_ctrl);
> +
> +       /* Zero a bunch of the priority settings.  */
> +       out_be32(&intr->per_pri1, 0);
> +       out_be32(&intr->per_pri2, 0);
> +       out_be32(&intr->per_pri3, 0);
> +       out_be32(&intr->main_pri1, 0);
> +       out_be32(&intr->main_pri2, 0);
> +
> +       /*
> +        * As last step, add an irq host to translate the real
> +        * hw irq information provided by the ofw to linux virq
> +        */
> +
> +       mpc52xx_irqhost =
> +           irq_alloc_host(IRQ_HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTVIRQ,
> +                          &mpc52xx_irqhost_ops, -1);
> +
> +       if (mpc52xx_irqhost)
> +               mpc52xx_irqhost->host_data = picnode;
> +}
> +
> +/*
> + * get_irq (public)
> +*/
> +unsigned int mpc52xx_get_irq(void)
> +{
> +       u32 status;
> +       int irq = NO_IRQ_IGNORE;
> +
> +       status = in_be32(&intr->enc_status);
> +       if (status & 0x00000400) {      /* critical */
> +               irq = (status >> 8) & 0x3;
> +               if (irq == 2)   /* high priority peripheral */
> +                       goto peripheral;
> +               irq |=
> +                   (MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
> +                   MPC52xx_IRQ_L1_MASK;
> +       } else if (status & 0x00200000) {       /* main */
> +               irq = (status >> 16) & 0x1f;
> +               if (irq == 4)   /* low priority peripheral */
> +                       goto peripheral;
> +               irq |=
> +                   (MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
> +                   MPC52xx_IRQ_L1_MASK;
> +       } else if (status & 0x20000000) {       /* peripheral */
> +             peripheral:
> +               irq = (status >> 24) & 0x1f;
> +               if (irq == 0) { /* bestcomm */
> +                       status = in_be32(&sdma->IntPend);
> +                       irq = ffs(status) - 1;
> +                       irq |=
> +                           (MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
> +                           MPC52xx_IRQ_L1_MASK;
> +               } else
> +                       irq |=
> +                           (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
> +                           MPC52xx_IRQ_L1_MASK;
> +
> +       }
> +
> +       pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
> +                irq_linear_revmap(mpc52xx_irqhost, irq));
> +
> +       return irq_linear_revmap(mpc52xx_irqhost, irq);
> +}
> --- a/include/asm-powerpc/mpc52xx.h     1970-01-01 01:00:00.000000000 +0100
> +++ b/include/asm-powerpc/mpc52xx.h     2006-11-02 17:54:37.000000000 +0100
> @@ -0,0 +1,319 @@
> +/*
> + *
> + * Prototypes, etc. for the Freescale MPC52xx embedded cpu chips
> + * May need to be cleaned as the port goes on ...
> + *
> + * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
> + * Copyright (C) 2003 MontaVista, Software, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef __ASM_POWERPC_MPC52xx_H__
> +#define __ASM_POWERPC_MPC52xx_H__
> +
> +#ifndef __ASSEMBLY__
> +#include <asm/types.h>
> +#include <asm/prom.h>
> +
> +#endif                         /* __ASSEMBLY__ */
> +
> +/* ======================================================================== */
> +/* Main registers/struct addresses                                          */
> +/* ======================================================================== */
> +
> +/* Registers zone offset/size  */
> +#define MPC52xx_MMAP_CTL_OFFSET                0x0000
> +#define MPC52xx_MMAP_CTL_SIZE          0x068
> +#define MPC52xx_SDRAM_OFFSET           0x0100
> +#define MPC52xx_SDRAM_SIZE             0x010
> +#define MPC52xx_CDM_OFFSET             0x0200
> +#define MPC52xx_CDM_SIZE               0x038
> +#define MPC52xx_INTR_OFFSET            0x0500
> +#define MPC52xx_INTR_SIZE              0x04c
> +#define MPC52xx_GPTx_OFFSET(x)         (0x0600 + ((x)<<4))
> +#define MPC52xx_GPT_SIZE               0x010
> +#define MPC52xx_RTC_OFFSET             0x0800
> +#define MPC52xx_RTC_SIZE               0x024
> +#define MPC52xx_GPIO_OFFSET            0x0b00
> +#define MPC52xx_GPIO_SIZE              0x040
> +#define MPC52xx_GPIO_WKUP_OFFSET       0x0c00
> +#define MPC52xx_GPIO_WKUP_SIZE         0x028
> +#define MPC52xx_PCI_OFFSET             0x0d00
> +#define MPC52xx_PCI_SIZE               0x100
> +#define MPC52xx_SDMA_OFFSET            0x1200
> +#define MPC52xx_SDMA_SIZE              0x100
> +#define MPC52xx_XLB_OFFSET             0x1f00
> +#define MPC52xx_XLB_SIZE               0x100
> +#define MPC52xx_PSCx_OFFSET(x)         (((x)!=6)?(0x1e00+((x)<<9)):0x2c00)
> +#define MPC52xx_PSC_SIZE               0x0a0
> +
> +/* SRAM used for SDMA */
> +#define MPC52xx_SRAM_OFFSET            0x8000
> +#define MPC52xx_SRAM_SIZE              0x4000

Register addresses/lengths are being passed by the device tree.  I
think they should be taken out of here to remove the temptation for
driver writers to use them.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
