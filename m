Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 717C6DDE0C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 20:25:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 1/2] drivers/ata: PATA driver for Celleb
Date: Thu, 11 Jan 2007 10:25:04 +0100
References: <200701110853.l0B8roEl018444@toshiba.co.jp>
In-Reply-To: <200701110853.l0B8roEl018444@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701111025.04927.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
> This patch adds kernel configuration and driver code
> for Celleb.
> 
> Many functions in ata_scc.c are copied from common libata code
> (ex: libata-core.c), because this PATA controller supports only
> 32bit read/write. If there are some low-level callbacks
> (like IN/OUT in drivers/ide), it is possible to make ata_scc.c
> simpler.

Actually, an even stronger reason to use an abstraction is the
fact that this is not really a PCI device and you therefore
don't use readl/writel, but rather in_be32/out_be32.

If you think the code gets better by using the low-level calls,
then it would be good if you also do the patch to implement them.

My feeling about your driver is that the amount of code duplication
is far too much, and it should better be based on generalizing the
existing libata code to deal with whatever you need to handle
differently.

> --- linux-2.6.20-rc4/drivers/ata/Makefile.orig	2007-01-11 01:56:01.000000000 +0900
> +++ linux-2.6.20-rc4/drivers/ata/Makefile	2007-01-11 01:56:32.000000000 +0900
> @@ -56,6 +56,7 @@ obj-$(CONFIG_PATA_WINBOND_VLB)	+= pata_w
>  obj-$(CONFIG_PATA_SIS)		+= pata_sis.o
>  obj-$(CONFIG_PATA_TRIFLEX)	+= pata_triflex.o
>  obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
> +obj-$(CONFIG_ATA_SCC)           += ata_scc.o
>  obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
>  # Should be last but one libata driver
>  obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o

If it is strictly parallel ATA, it should probably be called
CONFIG_PATA_SCC and pata_scc.c instead of the ata name you are using.

> --- linux-2.6.20-rc4/drivers/ata/ata_scc.c.orig	2007-01-11 01:56:52.000000000 +0900
> +++ linux-2.6.20-rc4/drivers/ata/ata_scc.c	2007-01-11 01:56:32.000000000 +0900
> @@ -0,0 +1,2083 @@
> +/*
> + * ata_scc.c - Support for IDE interfaces on Celleb platform

As a general rule, don't mention the file name in the description text,
it is implicit and it gets easily outdated when moving files around.


> +static void scc_set_piomode (struct ata_port *ap, struct ata_device *adev);
> +static void scc_set_dmamode (struct ata_port *ap, struct ata_device *adev);
> +static void scc_tf_load (struct ata_port *ap, const struct ata_taskfile *tf);
> +static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf);
> +static void scc_exec_command (struct ata_port *ap,
> +			      const struct ata_taskfile *tf);
> +static u8 scc_check_status (struct ata_port *ap);
> +static u8 scc_check_altstatus (struct ata_port *ap);
> +static void scc_std_dev_select (struct ata_port *ap, unsigned int device);
> +static void scc_bmdma_setup (struct ata_queued_cmd *qc);
> +static void scc_bmdma_start (struct ata_queued_cmd *qc);
> +static void scc_bmdma_stop (struct ata_queued_cmd *qc);
> +static u8 scc_bmdma_status (struct ata_port *ap);
> +static void scc_data_xfer (struct ata_device *adev, unsigned char *buf,
> +			   unsigned int buflen, int write_data);
> +static inline u8 scc_irq_on (struct ata_port *ap);
> +static inline u8 scc_irq_ack (struct ata_port *ap, unsigned int chk_drq);
> +static void scc_hsm_qc_complete (struct ata_queued_cmd *qc, int in_wq);
> +static int scc_hsm_move (struct ata_port *ap, struct ata_queued_cmd *qc,
> +			 u8 status, int in_wq);
> +static void scc_pio_task(struct work_struct *work);
> +static unsigned int scc_qc_issue_prot (struct ata_queued_cmd *qc);
> +static void scc_bmdma_freeze (struct ata_port *ap);
> +static void scc_bmdma_thaw (struct ata_port *ap);
> +static void scc_bmdma_drive_eh (struct ata_port *ap,
> +				ata_prereset_fn_t prereset,
> +				ata_reset_fn_t softreset,
> +				ata_reset_fn_t hardreset,
> +				ata_postreset_fn_t postreset);
> +static unsigned int scc_devchk (struct ata_port *ap, unsigned int device);
> +static void scc_bus_post_reset (struct ata_port *ap, unsigned int devmask);
> +static unsigned int scc_bus_softreset (struct ata_port *ap,
> +				       unsigned int devmask);
> +static int scc_pata_prereset(struct ata_port *ap);
> +static int scc_std_softreset (struct ata_port *ap, unsigned int *classes);
> +static void scc_std_postreset (struct ata_port *ap, unsigned int *classes);
> +static void scc_error_handler (struct ata_port *ap);
> +static inline unsigned int scc_host_intr (struct ata_port *ap,
> +					  struct ata_queued_cmd *qc);
> +static irqreturn_t scc_interrupt (int irq, void *dev_instance);
> +static void scc_bmdma_irq_clear (struct ata_port *ap);
> +static int scc_port_start (struct ata_port *ap);
> +static void scc_port_stop (struct ata_port *ap);
> +static void remove_mmio_scc (struct pci_dev *pdev);
> +static void scc_host_stop (struct ata_host *host);
> +static void scc_std_ports (struct ata_ioports *ioaddr);
> +static struct ata_probe_ent * scc_pci_init_native_mode (struct pci_dev *pdev,
> +							struct ata_port_info **port, 
> +							int ports);
> +static int scc_pci_init_one (struct pci_dev *pdev,
> +			     struct ata_port_info **port_info,
> +			     unsigned int n_ports);
> +static int setup_mmio_scc (struct pci_dev *dev, const char *name);
> +static int scc_init_one (struct pci_dev *pdev,
> +			 const struct pci_device_id *ent);

The more common way would be avoiding all these static declarations
entirely, and making sure that each function is called only by
other functions below it, not above it.

> +static struct pci_driver scc_pci_driver = {
> +	.name			= DRV_NAME,
> +	.id_table		= scc_pci_tbl,
> +	.probe			= scc_init_one,
> +	.remove			= ata_pci_remove_one,
> +	.suspend		= ata_pci_device_suspend,
> +	.resume			= ata_pci_device_resume,
> +};

The .suspend and .resume entries are commonly kept inside
#ifdef CONFIG_PM, so they can get left out at compile time.

> +	struct scc_ports *ports = (struct scc_ports *) ap->host->private_data;

Remove the type cast here, private_data is void*.

> +        void __iomem *cckctrl_port = ports->ctl_base + SCC_CTL_CCKCTRL;
> +        void __iomem *piosht_port = ports->ctl_base + SCC_CTL_PIOSHT;
> +        void __iomem *pioct_port = ports->ctl_base + SCC_CTL_PIOCT;
> +        unsigned long reg;
> +        int offset;
> +
> +	reg = in_be32(cckctrl_port);
> +        if (reg & CCKCTRL_ATACLKOEN)
> +		offset = 1; /* 133MHz */
> +	else
> +		offset = 0; /* 100MHz */

Indentation is wrong here. You should always use tabs, not spaces
for indenting.

	Arnd <><
