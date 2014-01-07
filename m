Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 8F35A2C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 07:28:14 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementation
Date: Tue, 07 Jan 2014 21:41:59 +0100
Message-ID: <4984978.bktZCpdLkC@vostro.rjw.lan>
In-Reply-To: <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pci@vger.kernel.org, galak@codeaurora.org, scottwood@freescale.com,
 roy.zang@freescale.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, January 07, 2014 04:04:08 PM Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> The new suspend/resume implementation, send pme turnoff message
> in suspend, and send pme exit message in resume.
> 
> Add a PME handler, to response PME & message interrupt.
> 
> Change platform_driver->suspend/resume to syscore->suspend/resume.

Can you please first describe the problem you're trying to address?

Thanks!

> pci-driver will call back EP device, to save EP state in
> pci_pm_suspend_noirq, so we need to keep the link, until
> pci_pm_suspend_noirq finish.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
> index 213d5b8..84476b6 100644
> --- a/arch/powerpc/platforms/85xx/c293pcie.c
> +++ b/arch/powerpc/platforms/85xx/c293pcie.c
> @@ -68,6 +68,7 @@ define_machine(c293_pcie) {
>  	.init_IRQ		= c293_pcie_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index fbd871e..aa8b9a3 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -163,6 +163,7 @@ define_machine(corenet_generic) {
>  	.init_IRQ		= corenet_gen_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_coreint_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
> index e6285ae..11790e0 100644
> --- a/arch/powerpc/platforms/85xx/ge_imp3a.c
> +++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
> @@ -215,6 +215,7 @@ define_machine(ge_imp3a) {
>  	.show_cpuinfo		= ge_imp3a_show_cpuinfo,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
> index 15ce4b5..a378ba3 100644
> --- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
> @@ -76,6 +76,7 @@ define_machine(mpc8536_ds) {
>  	.init_IRQ		= mpc8536_ds_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index 7a31a0e..b0753e2 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -385,6 +385,7 @@ define_machine(mpc85xx_cds) {
>  #ifdef CONFIG_PCI
>  	.restart	= mpc85xx_cds_restart,
>  	.pcibios_fixup_bus	= mpc85xx_cds_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #else
>  	.restart	= fsl_rstcr_restart,
>  #endif
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> index 9ebb91e..ffdf021 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -209,6 +209,7 @@ define_machine(mpc8544_ds) {
>  	.init_IRQ		= mpc85xx_ds_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -223,6 +224,7 @@ define_machine(mpc8572_ds) {
>  	.init_IRQ		= mpc85xx_ds_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -237,6 +239,7 @@ define_machine(p2020_ds) {
>  	.init_IRQ		= mpc85xx_ds_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index a7b3621..6cd3b8a 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -416,6 +416,7 @@ define_machine(mpc8568_mds) {
>  	.progress	= udbg_progress,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  };
>  
> @@ -437,6 +438,7 @@ define_machine(mpc8569_mds) {
>  	.progress	= udbg_progress,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  };
>  
> @@ -459,6 +461,7 @@ define_machine(p1021_mds) {
>  	.progress	= udbg_progress,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  };
>  
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> index 53b6fb0..3e2bc3d 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -254,6 +254,7 @@ define_machine(p2020_rdb) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -268,6 +269,7 @@ define_machine(p1020_rdb) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -282,6 +284,7 @@ define_machine(p1021_rdb_pc) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -296,6 +299,7 @@ define_machine(p2020_rdb_pc) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -310,6 +314,7 @@ define_machine(p1025_rdb) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -324,6 +329,7 @@ define_machine(p1020_mbg_pc) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -338,6 +344,7 @@ define_machine(p1020_utm_pc) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -352,6 +359,7 @@ define_machine(p1020_rdb_pc) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -366,6 +374,7 @@ define_machine(p1020_rdb_pd) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -380,6 +389,7 @@ define_machine(p1024_rdb) {
>  	.init_IRQ		= mpc85xx_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
> index d6a3dd3..ad1a3d4 100644
> --- a/arch/powerpc/platforms/85xx/p1010rdb.c
> +++ b/arch/powerpc/platforms/85xx/p1010rdb.c
> @@ -78,6 +78,7 @@ define_machine(p1010_rdb) {
>  	.init_IRQ		= p1010_rdb_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
> index e611e79..6ac986d 100644
> --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> @@ -567,6 +567,7 @@ define_machine(p1022_ds) {
>  	.init_IRQ		= p1022_ds_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
> index 8c92971..7a180f0 100644
> --- a/arch/powerpc/platforms/85xx/p1022_rdk.c
> +++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
> @@ -147,6 +147,7 @@ define_machine(p1022_rdk) {
>  	.init_IRQ		= p1022_rdk_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
> index 2ae9d49..0e61400 100644
> --- a/arch/powerpc/platforms/85xx/p1023_rds.c
> +++ b/arch/powerpc/platforms/85xx/p1023_rds.c
> @@ -126,6 +126,7 @@ define_machine(p1023_rds) {
>  	.progress		= udbg_progress,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  };
>  
> @@ -140,5 +141,6 @@ define_machine(p1023_rdb) {
>  	.progress		= udbg_progress,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  };
> diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
> index 5cefc5a..7f26732 100644
> --- a/arch/powerpc/platforms/85xx/qemu_e500.c
> +++ b/arch/powerpc/platforms/85xx/qemu_e500.c
> @@ -66,6 +66,7 @@ define_machine(qemu_e500) {
>  	.init_IRQ		= qemu_e500_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_coreint_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
> index f621218..b072146 100644
> --- a/arch/powerpc/platforms/85xx/sbc8548.c
> +++ b/arch/powerpc/platforms/85xx/sbc8548.c
> @@ -135,6 +135,7 @@ define_machine(sbc8548) {
>  	.restart	= fsl_rstcr_restart,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.calibrate_decr = generic_calibrate_decr,
>  	.progress	= udbg_progress,
> diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
> index dcbf7e4..1a9c108 100644
> --- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
> +++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
> @@ -170,6 +170,7 @@ define_machine(xes_mpc8572) {
>  	.init_IRQ		= xes_mpc85xx_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -184,6 +185,7 @@ define_machine(xes_mpc8548) {
>  	.init_IRQ		= xes_mpc85xx_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> @@ -198,6 +200,7 @@ define_machine(xes_mpc8540) {
>  	.init_IRQ		= xes_mpc85xx_pic_init,
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
>  	.get_irq		= mpic_get_irq,
>  	.restart		= fsl_rstcr_restart,
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 4dfd61d..98cb3d4 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -22,10 +22,13 @@
>  #include <linux/delay.h>
>  #include <linux/string.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/bootmem.h>
>  #include <linux/memblock.h>
>  #include <linux/log2.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
> +#include <linux/syscore_ops.h>
>  #include <linux/uaccess.h>
>  
>  #include <asm/io.h>
> @@ -1085,55 +1088,167 @@ void fsl_pci_assign_primary(void)
>  	}
>  }
>  
> -static int fsl_pci_probe(struct platform_device *pdev)
> +#ifdef CONFIG_PM
> +static irqreturn_t fsl_pci_pme_handle(int irq, void *dev_id)
>  {
> -	int ret;
> -	struct device_node *node;
> +	struct pci_controller *hose = dev_id;
> +	struct ccsr_pci __iomem *pci = hose->private_data;
> +	u32 dr;
>  
> -	node = pdev->dev.of_node;
> -	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
> +	dr = in_be32(&pci->pex_pme_mes_dr);
> +	if (dr)
> +		out_be32(&pci->pex_pme_mes_dr, dr);
> +	else
> +		return IRQ_NONE;
>  
> -	mpc85xx_pci_err_probe(pdev);
> +	return IRQ_HANDLED;
> +}
> +
> +static int fsl_pci_pme_probe(struct pci_controller *hose)
> +{
> +	struct ccsr_pci __iomem *pci;
> +	struct pci_dev *dev = hose->bus->self;
> +	u16 pms;
> +	int pme_irq;
> +	int res;
> +
> +	/* PME Disable */
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pms);
> +	pms &= ~PCI_PM_CTRL_PME_ENABLE;
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pms);
> +
> +	pme_irq = irq_of_parse_and_map(hose->dn, 0);
> +	if (!pme_irq) {
> +		pr_warn("Failed to map PME interrupt.\n");
> +
> +		return -ENXIO;
> +	}
> +
> +	res = devm_request_irq(hose->parent, pme_irq,
> +			fsl_pci_pme_handle,
> +			IRQF_DISABLED | IRQF_SHARED,
> +			"[PCI] PME", hose);
> +	if (res < 0) {
> +		pr_warn("Unable to requiest irq %d for PME\n", pme_irq);
> +		irq_dispose_mapping(pme_irq);
> +
> +		return -ENODEV;
> +	}
> +
> +	pci = hose->private_data;
> +
> +	/* Enable PTOD, ENL23D & EXL23D */
> +	out_be32(&pci->pex_pme_mes_disr, 0);
> +	setbits32(&pci->pex_pme_mes_disr,
> +		  PME_DISR_EN_PTOD | PME_DISR_EN_ENL23D | PME_DISR_EN_EXL23D);
> +
> +	out_be32(&pci->pex_pme_mes_ier, 0);
> +	setbits32(&pci->pex_pme_mes_ier,
> +		  PME_DISR_EN_PTOD | PME_DISR_EN_ENL23D | PME_DISR_EN_EXL23D);
> +
> +	/* PME Enable */
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pms);
> +	pms |= PCI_PM_CTRL_PME_ENABLE;
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pms);
>  
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int fsl_pci_resume(struct device *dev)
> +static void send_pme_turnoff_message(struct pci_controller *hose)
>  {
> -	struct pci_controller *hose;
> -	struct resource pci_rsrc;
> +	struct ccsr_pci __iomem *pci = hose->private_data;
> +	u32 dr;
> +	int i;
>  
> -	hose = pci_find_hose_for_OF_device(dev->of_node);
> -	if (!hose)
> -		return -ENODEV;
> +	/* Send PME_Turn_Off Message Request */
> +	setbits32(&pci->pex_pmcr, PEX_PMCR_PTOMR);
>  
> -	if (of_address_to_resource(dev->of_node, 0, &pci_rsrc)) {
> -		dev_err(dev, "Get pci register base failed.");
> -		return -ENODEV;
> +	for (i = 0; i < 150; i++) {
> +		dr = in_be32(&pci->pex_pme_mes_dr);
> +		if (dr) {
> +			out_be32(&pci->pex_pme_mes_dr, dr);
> +			break;
> +		} else {
> +			udelay(1000);
> +		}
>  	}
> +}
>  
> -	setup_pci_atmu(hose);
> +static void fsl_pci_syscore_do_suspend(struct pci_controller *hose)
> +{
> +	send_pme_turnoff_message(hose);
> +}
> +
> +static int fsl_pci_syscore_suspend(void)
> +{
> +	struct pci_controller *hose, *tmp;
> +
> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> +		fsl_pci_syscore_do_suspend(hose);
>  
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops pci_pm_ops = {
> -	.resume = fsl_pci_resume,
> -};
> +static void fsl_pci_syscore_do_resume(struct pci_controller *hose)
> +{
> +	struct ccsr_pci __iomem *pci = hose->private_data;
> +	u32 dr;
> +	int i;
>  
> -#define PCI_PM_OPS (&pci_pm_ops)
> +	/* Send Exit L2 State Message */
> +	setbits32(&pci->pex_pmcr, PEX_PMCR_EXL2S);
>  
> -#else
> +	/* wait exit done */
> +	for (i = 0; i < 150; i++) {
> +		dr = in_be32(&pci->pex_pme_mes_dr);
> +		if (dr) {
> +			out_be32(&pci->pex_pme_mes_dr, dr);
> +			break;
> +		} else {
> +			udelay(1000);
> +		}
> +	}
> +
> +	setup_pci_atmu(hose);
> +}
>  
> -#define PCI_PM_OPS NULL
> +static void fsl_pci_syscore_resume(void)
> +{
> +	struct pci_controller *hose, *tmp;
> +
> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> +		fsl_pci_syscore_do_resume(hose);
> +}
>  
> +static struct syscore_ops pci_syscore_pm_ops = {
> +	.suspend = fsl_pci_syscore_suspend,
> +	.resume = fsl_pci_syscore_resume,
> +};
>  #endif
>  
> +void fsl_pcibios_fixup_phb(struct pci_controller *phb)
> +{
> +#ifdef CONFIG_PM
> +	fsl_pci_pme_probe(phb);
> +#endif
> +}
> +
> +static int fsl_pci_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device_node *node;
> +
> +	node = pdev->dev.of_node;
> +	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
> +
> +	mpc85xx_pci_err_probe(pdev);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver fsl_pci_driver = {
>  	.driver = {
>  		.name = "fsl-pci",
> -		.pm = PCI_PM_OPS,
>  		.of_match_table = pci_ids,
>  	},
>  	.probe = fsl_pci_probe,
> @@ -1141,6 +1256,9 @@ static struct platform_driver fsl_pci_driver = {
>  
>  static int __init fsl_pci_init(void)
>  {
> +#ifdef CONFIG_PM
> +	register_syscore_ops(&pci_syscore_pm_ops);
> +#endif
>  	return platform_driver_register(&fsl_pci_driver);
>  }
>  arch_initcall(fsl_pci_init);
> diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
> index 8d455df..c1cec77 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -32,6 +32,13 @@ struct platform_device;
>  #define PIWAR_WRITE_SNOOP	0x00005000
>  #define PIWAR_SZ_MASK          0x0000003f
>  
> +#define PEX_PMCR_PTOMR		0x1
> +#define PEX_PMCR_EXL2S		0x2
> +
> +#define PME_DISR_EN_PTOD	0x00008000
> +#define PME_DISR_EN_ENL23D	0x00002000
> +#define PME_DISR_EN_EXL23D	0x00001000
> +
>  /* PCI/PCI Express outbound window reg */
>  struct pci_outbound_window_regs {
>  	__be32	potar;	/* 0x.0 - Outbound translation address register */
> @@ -111,6 +118,7 @@ struct ccsr_pci {
>  
>  extern int fsl_add_bridge(struct platform_device *pdev, int is_primary);
>  extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
> +extern void fsl_pcibios_fixup_phb(struct pci_controller *phb);
>  extern int mpc83xx_add_bridge(struct device_node *dev);
>  u64 fsl_pci_immrbar_base(struct pci_controller *hose);
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
