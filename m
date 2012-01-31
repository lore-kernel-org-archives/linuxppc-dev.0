Return-Path: <r65073@freescale.com>
Date: Tue, 31 Jan 2012 21:58:22 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v3 14/25] irq_domain: Remove irq_domain_add_simple()
Message-ID: <20120131135821.GA24804@S2100-06.ap.freescale.net>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-15-git-send-email-grant.likely@secretlab.ca>
 <20120131124500.GA28571@S2101-09.ap.freescale.net>
 <4F27E96E.9010204@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4F27E96E.9010204@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2012 at 07:15:26AM -0600, Rob Herring wrote:
...
> >> --- a/arch/arm/mach-mx5/imx51-dt.c
> >> +++ b/arch/arm/mach-mx5/imx51-dt.c
> >> @@ -47,7 +47,7 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
> >>  static int __init imx51_tzic_add_irq_domain(struct device_node *np,
> >>  				struct device_node *interrupt_parent)
> >>  {
> >> -	irq_domain_add_simple(np, 0);
> >> +	irq_domain_add_legacy(np, 32, 0, 0, &irq_domain_simple_ops, NULL);
> >>  	return 0;
> >>  }
> >>  
> >> @@ -57,7 +57,7 @@ static int __init imx51_gpio_add_irq_domain(struct device_node *np,
> >>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> >>  
> >>  	gpio_irq_base -= 32;
> >> -	irq_domain_add_simple(np, gpio_irq_base);
> >> +	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops, NULL);
> > 
> > The tzic on imx5 gets 128 irq lines rather than 32 here.  The current
> > code will make any hwirq that is > 32 hit the WARN_ON below in
> > irq_domain_legacy_revmap().
> 
> But this is the gpio controller code? Really this should be 4 domains,
> but this temp fix is probably fine until you use my generic irq chip
> support.
> 
Sorry.  The comment was put at the wrong place.  It should be against
imx51_tzic_add_irq_domain() just above.

-- 
Regards,
Shawn
