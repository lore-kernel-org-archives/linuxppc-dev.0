Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1AA05B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 14:39:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DB93DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 14:39:45 +1000 (EST)
Message-Id: <1456507C-E9F9-436B-9901-6F127A5FDD1F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1250204775-5001-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] sbc8560: Fix warm reboot with board specific reset
	function
Date: Thu, 13 Aug 2009 23:39:37 -0500
References: <1250204775-5001-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 13, 2009, at 6:06 PM, Paul Gortmaker wrote:

> From: Liang Li <Liang.Li@windriver.com>
>
> The existing fsl_rstcr_restart function fails to reset the sbc8560
> board. This implements a board specific reset function that uses
> the RCR(Reset Control Register) of the board's EPLD to do a reset.
>
> Signed-off-by: Liang Li <Liang.Li@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/platforms/85xx/sbc8560.c |   39 ++++++++++++++++++++++++ 
> ++++++++-
> 1 files changed, 38 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/ 
> platforms/85xx/sbc8560.c
> index cc27807..86dcca2 100644
> --- a/arch/powerpc/platforms/85xx/sbc8560.c
> +++ b/arch/powerpc/platforms/85xx/sbc8560.c
> @@ -267,6 +267,43 @@ arch_initcall(sbc8560_rtc_init);
>
> #endif	/* M48T59 */
>
> +static __u8 __iomem *brstcr;
> +
> +static int __init sbc8560_bdrstcr_init(void)
> +{
> +	struct device_node *np;
> +	struct resource res;
> +
> +	np = of_find_compatible_node(NULL, NULL, "wrs,sbc8560-brstcr");
> +	if (np == NULL) {
> +		printk(KERN_WARNING "sbc8560: No board specific RSTCR in DTB.\n");
> +		return -ENODEV;
> +	}
> +
> +	of_address_to_resource(np, 0, &res);
> +
> +	printk(KERN_INFO "sbc8560: Found BRSTCR at i/o 0x%x\n", res.start);
> +
> +	brstcr = ioremap(res.start, res.end - res.start);
> +	if(!brstcr)
> +		printk(KERN_WARNING "sbc8560: ioremap of brstcr failed.\n");
> +
> +	of_node_put(np);
> +
> +	return 0;
> +}
> +
> +arch_initcall(sbc8560_bdrstcr_init);
> +
> +void sbc8560_rstcr_restart(char * cmd)
> +{
> +	local_irq_disable();
> +	if(brstcr)
> +		out_8(brstcr,in_8(brstcr) & 0x7f);

how about using clrbits8()

> +
> +	while(1);
> +}
> +
> define_machine(sbc8560) {
> 	.name			= "SBC8560",
> 	.probe			= sbc8560_probe,
> @@ -274,7 +311,7 @@ define_machine(sbc8560) {
> 	.init_IRQ		= sbc8560_pic_init,
> 	.show_cpuinfo		= sbc8560_show_cpuinfo,
> 	.get_irq		= mpic_get_irq,
> -	.restart		= fsl_rstcr_restart,
> +	.restart		= sbc8560_rstcr_restart,
> 	.calibrate_decr		= generic_calibrate_decr,
> 	.progress		= udbg_progress,
> };
> -- 
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
