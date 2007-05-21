Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC60DDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 01:57:41 +1000 (EST)
Date: Mon, 21 May 2007 10:57:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] power-management elements for 603e/fsl (version 2)
Message-ID: <20070521155712.GA16235@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.60.0705192013010.10162@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0705192013010.10162@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 19, 2007 at 09:22:10PM +0200, Guennadi Liakhovetski wrote:
> +static int ls_pm_enter(suspend_state_t state)
> +{
> +	char ier;
> +	int ret = 0;
> +	u64 tb;
> +
> +	/* Stop preemption */
> +	preempt_disable();
> +
> +	if ((ret = fsl_suspend(state)) < 0) {
> +		preempt_enable();
> +		return ret;
> +	}
> +
> +	local_irq_disable();

IRQs are already disabled when this function is called.

> +	/* go zzzzz... (re-enabling interrupts) */
> +	fsl_low_sleep();

IRQs really shouldn't be enabled here without something like the "Handle
HID0_SLEEP in the TLF_NAPPING hack" patch I posted recently.

> +	/* Re-enable local CPU interrupts */
> +	local_irq_enable();

Just leave them off.

> @@ -112,10 +155,15 @@ static int __init ls_uarts_init(void)
>  
>  	avr_clock = *(u32*)of_get_property(avr, "clock-frequency", &len);
>  	phys_addr = ((u32*)of_get_property(avr, "reg", &len))[0];
> + 	irq = ((u32*)get_property(avr, "interrupts", &len))[0];

Oopsing if a property is missing isn't nice.

> +
> +#ifdef CONFIG_PM
> +#include <linux/pci.h>
> +#include <asm/pci-bridge.h>
> +
> +#define	MPC10X_LP_REF_EN	(1<<12)
> +#define	MPC10X_PM		(1<<7)
> +#define MPC10X_DOZE		(1<<5)
> +#define	MPC10X_NAP		(1<<4)
> +#define	MPC10X_SLEEP		(1<<3)
> +
> +int fsl_suspend(suspend_state_t state)
> +{
> +	struct pci_dev *bridge;
> +	unsigned long flags;
> +	u16 pmcr1;
> +
> +	bridge = pci_find_slot(0, 0);
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	pci_read_config_word(bridge, 0x70, &pmcr1);
> +	local_irq_save(flags);
> +	/* Apparently, MacOS uses NAP mode for Grackle ??? */
> +	pmcr1 &= ~(MPC10X_DOZE | MPC10X_NAP);
> +	pmcr1 |= MPC10X_PM | MPC10X_SLEEP | MPC10X_LP_REF_EN;
> +	pci_write_config_word(bridge, 0x70, pmcr1);
> +	local_irq_restore(flags);

This should probably be something like mpc10x_suspend.  Also, IRQs should
already be disabled when this is called.

> +	/* Make sure the decrementer won't interrupt us */
> +	asm volatile("mtdec %0" : : "r" (0x7fffffff));
> +	/* Make sure any pending DEC interrupt occurring while we did
> +	 * the above didn't re-enable the DEC */
> +	mb();
> +	asm volatile("mtdec %0" : : "r" (0x7fffffff)); /* 8 seconds */

IRQs are already disabled here, so if it was pending it still will be (at
least with some cores).  It needs to be done with the arch suspend hook.

-Scott
