Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tvYvK10LlzDqN3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 04:04:44 +1100 (AEDT)
Subject: Re: [Patch V7 4/4] irqchip/qeic: remove PPCisms for QEIC
To: Zhao Qiang <qiang.zhao@nxp.com>, oss@buserror.net
References: <1482741166-33164-1-git-send-email-qiang.zhao@nxp.com>
 <1482741166-33164-4-git-send-email-qiang.zhao@nxp.com>
Cc: jason@lakedaemon.net, xiaobo.xie@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <0f4093fe-41ad-444d-235a-637ef2fa71d7@arm.com>
Date: Thu, 5 Jan 2017 17:04:40 +0000
MIME-Version: 1.0
In-Reply-To: <1482741166-33164-4-git-send-email-qiang.zhao@nxp.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/12/16 08:32, Zhao Qiang wrote:
> QEIC was supported on PowerPC, and dependent on PPC,
> Now it is supported on other platforms, so remove PPCisms.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v6:
> 	- new added
> Changes for v7:
> 	- fix warning
> 
>  drivers/irqchip/irq-qeic.c | 34 ++++++++++++++++++++--------------
>  include/soc/fsl/qe/qe_ic.h | 12 ++++++------
>  2 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
> index 4f49d4b..957ea5b 100644
> --- a/drivers/irqchip/irq-qeic.c
> +++ b/drivers/irqchip/irq-qeic.c
> @@ -18,7 +18,10 @@
>  #include <linux/of_address.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/irqdomain.h>
>  #include <linux/errno.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/stddef.h>
> @@ -88,7 +91,7 @@
>  
>  struct qe_ic {
>  	/* Control registers offset */
> -	volatile u32 __iomem *regs;
> +	u32 __iomem *regs;
>  
>  	/* The remapper for this QEIC */
>  	struct irq_domain *irqhost;
> @@ -264,15 +267,15 @@ static struct qe_ic_info qe_ic_info[] = {
>  		},
>  };
>  
> -static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
> +static inline u32 qe_ic_read(__be32  __iomem * base, unsigned int reg)
>  {
> -	return in_be32(base + (reg >> 2));
> +	return ioread32be(base + (reg >> 2));
>  }
>  
> -static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
> +static inline void qe_ic_write(__be32  __iomem * base, unsigned int reg,
>  			       u32 value)
>  {
> -	out_be32(base + (reg >> 2), value);
> +	iowrite32be(value, base + (reg >> 2));
>  }
>  
>  static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
> @@ -374,7 +377,7 @@ static const struct irq_domain_ops qe_ic_host_ops = {
>  	.xlate = irq_domain_xlate_onetwocell,
>  };
>  
> -/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
> +/* Return an interrupt vector or 0 if no interrupt is pending. */
>  unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)

Why isn't this static?

>  {
>  	int irq;
> @@ -385,12 +388,12 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
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
> +/* Return an interrupt vector or 0 if no interrupt is pending. */
>  unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)

and this ? And all the functions in that file while you're at it?

>  {
>  	int irq;
> @@ -401,7 +404,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
>  	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
>  
>  	if (irq == 0)
> -		return NO_IRQ;
> +		return 0;
>  
>  	return irq_linear_revmap(qe_ic->irqhost, irq);
>  }
> @@ -447,7 +450,7 @@ static int __init qe_ic_init(unsigned int flags)
>  	qe_ic->virq_high = irq_of_parse_and_map(node, 0);
>  	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
>  
> -	if (qe_ic->virq_low == NO_IRQ) {
> +	if (qe_ic->virq_low == 0) {
>  		pr_err("Failed to map QE_IC low IRQ\n");
>  		ret = -ENOMEM;
>  		goto err_domain_remove;
> @@ -479,7 +482,7 @@ static int __init qe_ic_init(unsigned int flags)
>  	irq_set_handler_data(qe_ic->virq_low, qe_ic);
>  	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
>  
> -	if (qe_ic->virq_high != NO_IRQ &&
> +	if (qe_ic->virq_high != 0 &&
>  			qe_ic->virq_high != qe_ic->virq_low) {
>  		irq_set_handler_data(qe_ic->virq_high, qe_ic);
>  		irq_set_chained_handler(qe_ic->virq_high,
> @@ -500,7 +503,8 @@ err_put_node:
>  void qe_ic_set_highest_priority(unsigned int virq, int high)
>  {
>  	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
> -	unsigned int src = virq_to_hw(virq);
> +	struct irq_data *irq_data = irq_get_irq_data(virq);
> +	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
>  	u32 temp = 0;
>  
>  	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
> @@ -518,7 +522,8 @@ void qe_ic_set_highest_priority(unsigned int virq, int high)
>  int qe_ic_set_priority(unsigned int virq, unsigned int priority)
>  {
>  	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
> -	unsigned int src = virq_to_hw(virq);
> +	struct irq_data *irq_data = irq_get_irq_data(virq);
> +	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
>  	u32 temp;
>  
>  	if (priority > 8 || priority == 0)
> @@ -548,7 +553,8 @@ int qe_ic_set_priority(unsigned int virq, unsigned int priority)
>  int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
>  {
>  	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
> -	unsigned int src = virq_to_hw(virq);
> +	struct irq_data *irq_data = irq_get_irq_data(virq);
> +	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
>  	u32 temp, control_reg = QEIC_CICNR, shift = 0;
>  
>  	if (priority > 2 || priority == 0)
> diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
> index 6113699..863cfec 100644
> --- a/include/soc/fsl/qe/qe_ic.h
> +++ b/include/soc/fsl/qe/qe_ic.h
> @@ -76,7 +76,7 @@ static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)

Why do we have a bunch of static inline functions here? Why do have that
file at all?

>  	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
>  	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
>  
> -	if (cascade_irq != NO_IRQ)
> +	if (cascade_irq != 0)
>  		generic_handle_irq(cascade_irq);
>  }
>  
> @@ -85,7 +85,7 @@ static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
>  	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
>  	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
>  
> -	if (cascade_irq != NO_IRQ)
> +	if (cascade_irq != 0)
>  		generic_handle_irq(cascade_irq);
>  }
>  
> @@ -95,7 +95,7 @@ static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
>  	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
> -	if (cascade_irq != NO_IRQ)
> +	if (cascade_irq != 0)
>  		generic_handle_irq(cascade_irq);
>  
>  	chip->irq_eoi(&desc->irq_data);
> @@ -107,7 +107,7 @@ static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
>  	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
> -	if (cascade_irq != NO_IRQ)
> +	if (cascade_irq != 0)
>  		generic_handle_irq(cascade_irq);
>  
>  	chip->irq_eoi(&desc->irq_data);
> @@ -120,10 +120,10 @@ static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
>  	cascade_irq = qe_ic_get_high_irq(qe_ic);
> -	if (cascade_irq == NO_IRQ)
> +	if (cascade_irq == 0)
>  		cascade_irq = qe_ic_get_low_irq(qe_ic);
>  
> -	if (cascade_irq != NO_IRQ)
> +	if (cascade_irq != 0)
>  		generic_handle_irq(cascade_irq);
>  
>  	chip->irq_eoi(&desc->irq_data);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
