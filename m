Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 1B39A685A3
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Oct 2005 04:24:37 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 25 Oct 2005 11:24:34 -0700
To: Sven Luther <sl@bplan-gmbh.de>, linuxppc-dev@ozlabs.org
Message-ID: <20051025182434.GA13982@xyzzy.farnsworth.org>
References: <20051025075159.GA10316@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051025075159.GA10316@localhost.localdomain>
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_pcidev - implements
	hotplug for the marvell gige functionality by probing the
	northbridge pci id.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 25, 2005 at 07:51:59AM +0000, Sven Luther wrote:
> Add Marvell gigabit ethernet hotplug through the northbridge pci id support
> for the Pegasos machines.
> 
> Signed-off-by: Nicolas DET <det.nicolas@free.fr>
> Signed-off-by: Sven Luther <sl@bplan-gmbh.de>
> 
> ---
> This patch is not optimal, as the proper way to handling this is to bring full
> hotplug support to the platform drivers, but this would be much more invasive
> and far reaching a project. This approach matches the marvell discovery
> northbridge pci id to load the driver for the builtin gigabit ethernet
> function, and is similar of what is done already using the discover module
> loading technique. With more and more distributions moving to using hotplug
> only to probe for modules to load, this patch becomes necessary.
> 
> Friendly,
> 
> Sven Luther

> diff -Naur a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
> --- a/drivers/net/mv643xx_eth.c	2005-10-25 09:20:50.604386000 +0200
> +++ b/drivers/net/mv643xx_eth.c	2005-10-25 09:20:14.596386000 +0200
> @@ -36,6 +36,10 @@
>  #include <linux/udp.h>
>  #include <linux/etherdevice.h>
>  
> +#ifdef CONFIG_PPC_MULTIPLATFORM
> +#include <linux/pci.h>
> +#endif
> +
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/ethtool.h>
> @@ -1640,6 +1644,16 @@
>  		" and Dale Farnsworth");
>  MODULE_DESCRIPTION("Ethernet driver for Marvell MV643XX");
>  
> +#ifdef CONFIG_PPC_MULTIPLATFORM
> +static struct pci_device_id pci_marvell_mv64360[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, pci_marvell_mv64360);
> +#endif
> +
> +
>  /*
>   * The second part is the low level driver of the gigE ethernet ports.
>   */

I don't think this is really dependent on PPC_MULTIPLATFORM,
and the driver also supports 64460.

How about the patch below.
-Dale

Index: linux-2.6.14-rc2-mm1-mv643xx-enet/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6.14-rc2-mm1-mv643xx-enet.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6.14-rc2-mm1-mv643xx-enet/drivers/net/mv643xx_eth.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/ethtool.h>
+#include <linux/pci.h>
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/pgtable.h>
@@ -1597,6 +1598,14 @@ MODULE_AUTHOR(	"Rabeeh Khoury, Assaf Hof
 		" and Dale Farnsworth");
 MODULE_DESCRIPTION("Ethernet driver for Marvell MV643XX");
 
+static struct pci_device_id pci_mv64xxx_enet[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64460) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, pci_mv64xxx_enet);
+
 /*
  * The second part is the low level driver of the gigE ethernet ports.
  */
