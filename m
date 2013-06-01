Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76F4F2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:34:53 +1000 (EST)
Message-ID: <1370061286.3766.17.camel@pasglop>
Subject: Re: [PATCH 23/23] powerpc/eeh: Add debugfs entry to inject errors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:34:46 +1000
In-Reply-To: <1369902245-5886-24-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-24-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 16:24 +0800, Gavin Shan wrote:
> The patch intends to add debugfs entry powerpc/EEH/PHBx so that
> the administrator can inject EEH errors to specified PCI host
> bridge for testing purpose.

Use a better naming for the debugfs files. Something like
eeh_err_inject/pciNNNN, to be consistent with the general naming
of PHBs in the system.

However, maybe it would be better to instead having something along
the lines of a directory per PHB with a file in it for error injection ?

That way we can stick more things in there that can become handy for
debugging / diagnostics, such as register dumps etc...

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-ioda.c |   36 ++++++++++++++++++++++++++++-
>  1 files changed, 35 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
> index ec5c524..4cc9db7 100644
> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/bootmem.h>
>  #include <linux/delay.h>
> +#include <linux/debugfs.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -43,6 +44,29 @@
>  #include "powernv.h"
>  #include "pci.h"
>  
> +static struct dentry *ioda_eeh_dbgfs = NULL;
> +
> +static int ioda_eeh_dbgfs_set(void *data, u64 val)
> +{
> +	struct pci_controller *hose = data;
> +	struct pnv_phb *phb = hose->private_data;
> +
> +	out_be64(phb->regs + 0xD10, val);
> +	return 0;
> +}
> +
> +static int ioda_eeh_dbgfs_get(void *data, u64 *val)
> +{
> +	struct pci_controller *hose = data;
> +	struct pnv_phb *phb = hose->private_data;
> +
> +	*val = in_be64(phb->regs + 0xD10);
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_dbgfs_ops, ioda_eeh_dbgfs_get,
> +			ioda_eeh_dbgfs_set, "0x%llx\n");
> +
>  /**
>   * ioda_eeh_post_init - Chip dependent post initialization
>   * @hose: PCI controller
> @@ -54,10 +78,20 @@
>  static int ioda_eeh_post_init(struct pci_controller *hose)
>  {
>  	struct pnv_phb *phb = hose->private_data;
> +	char name[16];
> +
> +	/* Create EEH debugfs root if possible */
> +	if (!ioda_eeh_dbgfs)
> +		ioda_eeh_dbgfs = debugfs_create_dir("EEH", powerpc_debugfs_root);
>  
>  	/* FIXME: Enable it for PHB3 later */
> -	if (phb->type == PNV_PHB_IODA1)
> +	if (phb->type == PNV_PHB_IODA1) {
> +		sprintf(name, "PHB%d", hose->global_number);
> +		debugfs_create_file(name, 0600, ioda_eeh_dbgfs,
> +				    hose, &ioda_eeh_dbgfs_ops);
> +
>  		phb->eeh_enabled = 1;
> +	}
>  
>  	return 0;
>  }
