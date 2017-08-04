Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xNzJr1yp6zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 17:36:59 +1000 (AEST)
Subject: Re: [PATCH v9 4/4] irqchip/qeic: remove PPCisms for QEIC
To: Zhao Qiang <qiang.zhao@nxp.com>, tglx@linutronix.de
References: <1501731490-34402-1-git-send-email-qiang.zhao@nxp.com>
 <1501731490-34402-5-git-send-email-qiang.zhao@nxp.com>
Cc: oss@buserror.net, xiaobo.xie@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <76c2673a-af7d-45d1-85d3-7d328808d292@arm.com>
Date: Fri, 4 Aug 2017 08:31:25 +0100
MIME-Version: 1.0
In-Reply-To: <1501731490-34402-5-git-send-email-qiang.zhao@nxp.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Please add all the irqchip maintainers when posting irqchip patches...]

On 03/08/17 04:38, Zhao Qiang wrote:
> QEIC was supported on PowerPC, and dependent on PPC,
> Now it is supported on other platforms, so remove PPCisms.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  arch/powerpc/platforms/83xx/km83xx.c          |   1 -
>  arch/powerpc/platforms/83xx/misc.c            |   1 -
>  arch/powerpc/platforms/83xx/mpc832x_mds.c     |   1 -
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   1 -
>  arch/powerpc/platforms/83xx/mpc836x_mds.c     |   1 -
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   1 -
>  arch/powerpc/platforms/85xx/corenet_generic.c |   1 -
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   1 -
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   1 -
>  arch/powerpc/platforms/85xx/twr_p102x.c       |   1 -
>  drivers/irqchip/irq-qeic.c                    | 219 +++++++++++++-------------
>  include/soc/fsl/qe/qe_ic.h                    | 132 ----------------
>  12 files changed, 111 insertions(+), 250 deletions(-)
>  delete mode 100644 include/soc/fsl/qe/qe_ic.h
> 

[...]

> diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
> index a2d8084..21e3b43 100644
> --- a/drivers/irqchip/irq-qeic.c
> +++ b/drivers/irqchip/irq-qeic.c
> @@ -18,8 +18,11 @@
>  #include <linux/of_address.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/irqdomain.h>
>  #include <linux/irqchip.h>
>  #include <linux/errno.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/stddef.h>
> @@ -27,9 +30,8 @@
>  #include <linux/signal.h>
>  #include <linux/device.h>
>  #include <linux/spinlock.h>
> -#include <asm/irq.h>
> +#include <linux/irq.h>
>  #include <asm/io.h>
> -#include <soc/fsl/qe/qe_ic.h>
>  
>  #define NR_QE_IC_INTS		64
>  
> @@ -87,6 +89,43 @@
>  #define SIGNAL_HIGH		2
>  #define SIGNAL_LOW		0
>  
> +#define NUM_OF_QE_IC_GROUPS	6
> +
> +/* Flags when we init the QE IC */
> +#define QE_IC_SPREADMODE_GRP_W			0x00000001
> +#define QE_IC_SPREADMODE_GRP_X			0x00000002
> +#define QE_IC_SPREADMODE_GRP_Y			0x00000004
> +#define QE_IC_SPREADMODE_GRP_Z			0x00000008
> +#define QE_IC_SPREADMODE_GRP_RISCA		0x00000010
> +#define QE_IC_SPREADMODE_GRP_RISCB		0x00000020
> +
> +#define QE_IC_LOW_SIGNAL			0x00000100
> +#define QE_IC_HIGH_SIGNAL			0x00000200
> +
> +#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH	0x00001000
> +#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH	0x00002000
> +#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH	0x00004000
> +#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH	0x00008000
> +#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH	0x00010000
> +#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH	0x00020000
> +#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH	0x00040000
> +#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH	0x00080000
> +#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH	0x00100000
> +#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH	0x00200000
> +#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH	0x00400000
> +#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH	0x00800000
> +#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT		(12)
> +
> +/* QE interrupt sources groups */
> +enum qe_ic_grp_id {
> +	QE_IC_GRP_W = 0,	/* QE interrupt controller group W */
> +	QE_IC_GRP_X,		/* QE interrupt controller group X */
> +	QE_IC_GRP_Y,		/* QE interrupt controller group Y */
> +	QE_IC_GRP_Z,		/* QE interrupt controller group Z */
> +	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
> +	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
> +};
> +
>  struct qe_ic {
>  	/* Control registers offset */
>  	u32 __iomem *regs;
> @@ -265,15 +304,15 @@ static struct qe_ic_info qe_ic_info[] = {
>  		},
>  };
>  
> -static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
> +static inline u32 qe_ic_read(__be32  __iomem *base, unsigned int reg)

Why are these tagged "inline"? In general, the compiler does a pretty
good job at inlining what makes sense to be inlined without having to be
told so.

>  {
> -	return in_be32(base + (reg >> 2));
> +	return ioread32be(base + (reg >> 2));
>  }
>  
> -static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
> +static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
>  			       u32 value)
>  {
> -	out_be32(base + (reg >> 2), value);
> +	iowrite32be(value, base + (reg >> 2));
>  }
>  
>  static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
> @@ -375,8 +414,8 @@ static const struct irq_domain_ops qe_ic_host_ops = {
>  	.xlate = irq_domain_xlate_onetwocell,
>  };
>  
> -/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
> -unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
> +/* Return an interrupt vector or 0 if no interrupt is pending. */
> +static unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
>  {
>  	int irq;
>  
> @@ -386,13 +425,13 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
>  	irq = qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
>  
>  	if (irq == 0)
> -		return NO_IRQ;
> +		return 0;
>  
>  	return irq_linear_revmap(qe_ic->irqhost, irq);
>  }
>  
> -/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
> -unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
> +/* Return an interrupt vector or 0 if no interrupt is pending. */
> +static unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
>  {
>  	int irq;
>  
> @@ -402,11 +441,69 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
>  	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
>  
>  	if (irq == 0)
> -		return NO_IRQ;
> +		return 0;
>  
>  	return irq_linear_revmap(qe_ic->irqhost, irq);
>  }
>  
> +static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
> +
> +	if (cascade_irq != 0)
> +		generic_handle_irq(cascade_irq);
> +}
> +
> +static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
> +
> +	if (cascade_irq != 0)
> +		generic_handle_irq(cascade_irq);
> +}
> +
> +static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	if (cascade_irq != 0)
> +		generic_handle_irq(cascade_irq);
> +
> +	chip->irq_eoi(&desc->irq_data);
> +}
> +
> +static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	if (cascade_irq != 0)
> +		generic_handle_irq(cascade_irq);
> +
> +	chip->irq_eoi(&desc->irq_data);
> +}
> +
> +static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	cascade_irq = qe_ic_get_high_irq(qe_ic);
> +	if (cascade_irq == 0)
> +		cascade_irq = qe_ic_get_low_irq(qe_ic);
> +
> +	if (cascade_irq != 0)
> +		generic_handle_irq(cascade_irq);
> +
> +	chip->irq_eoi(&desc->irq_data);
> +}
> +

There is an incredible amount of duplication in this code. You should be
able to do a better job at refactoring this code.

And clearly, none of these should ever be tagged "inline". Please leave
the compiler's job to the compiler unless you have an actual reason to
do so (but then "inline" is the wrong keyword).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
