Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CB551A0E33
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 00:30:15 +1000 (AEST)
Received: by pdea3 with SMTP id a3so112485703pde.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2015 07:30:13 -0700 (PDT)
Message-ID: <554E19EF.1070903@ozlabs.ru>
Date: Sun, 10 May 2015 00:30:07 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 13/21] powerpc/powernv: Introduce pnv_pci_poll()
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-14-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-14-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2015 04:03 PM, Gavin Shan wrote:
> We might not get some PCI slot information (e.g. power status)
> immediately by OPAL API. Instead, opal_pci_poll() need to be called
> for the required information.
>
> The patch introduces pnv_pci_poll(), which bases on original
> pnv_eeh_poll(), to cover the above case
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 28 ++--------------------------
>   arch/powerpc/platforms/powernv/pci.c         | 16 ++++++++++++++++
>   arch/powerpc/platforms/powernv/pci.h         |  1 +
>   3 files changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 58e4dcf..9253b9e 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -742,24 +742,6 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
>   	return ret;
>   }
>
> -static s64 pnv_eeh_poll(uint64_t id)
> -{
> -	s64 rc = OPAL_HARDWARE;
> -
> -	while (1) {
> -		rc = opal_pci_poll(id, NULL);
> -		if (rc <= 0)
> -			break;
> -
> -		if (system_state < SYSTEM_RUNNING)
> -			udelay(1000 * rc);
> -		else
> -			msleep(rc);
> -	}
> -
> -	return rc;
> -}
> -
>   int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
>   {
>   	struct pnv_phb *phb = hose->private_data;
> @@ -788,10 +770,7 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
>
>   	/* Issue reset and poll until it's completed */
>   	rc = opal_pci_reset(phb->opal_id, scope, OPAL_ASSERT_RESET);
> -	if (rc > 0)
> -		rc = pnv_eeh_poll(phb->opal_id);
> -
> -	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
> +	return pnv_pci_poll(phb->opal_id, rc, NULL);


You are carrying a negative value to the new helper too? Looks complicated.

Also, before you only cared if opal_pci_reset() returned negative value, 
now you treat it as a timeout, is it new change to OPAL or it has always 
been there?


>   }
>
>   static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
> @@ -882,10 +861,7 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>   	phb = hose->private_data;
>   	id |= (dev->bus->number << 24) | (dev->devfn << 16) | phb->opal_id;
>   	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
> -	if (rc > 0)
> -		rc = pnv_eeh_poll(id);
> -
> -	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
> +	return pnv_pci_poll(id, rc, NULL);
>   }
>
>   static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index bca2aeb..a2da9a3 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -44,6 +44,22 @@
>   #define cfg_dbg(fmt...)	do { } while(0)
>   //#define cfg_dbg(fmt...)	printk(fmt)
>
> +int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
> +{
> +	while (rval > 0) {
> +		if (system_state < SYSTEM_RUNNING)
> +			udelay(1000 * rval);
> +		else
> +			msleep(rval);

Are these delays the once removed by "PATCH v4 09/21] powerpc/powernv: Use 
PCI slot reset infrastructure"? If so, I would merge this patch into 09/24 
or move this one before that one, for bisect'ability.


> +
> +		rval = opal_pci_poll(id, pval);
> +		if (rval == OPAL_SUCCESS && pval)
> +			rval = opal_pci_poll(id, pval);

Why calling it twice?


> +	}
> +
> +	return rval ? -EIO : 0;
> +}
> +
>   #ifdef CONFIG_PCI_MSI
>   static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>   {
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 8b10f01..82c5539 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -202,6 +202,7 @@ struct pnv_phb {
>
>   extern struct pci_ops pnv_pci_ops;
>
> +int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval);
>   void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>   				unsigned char *log_buff);
>   int pnv_pci_cfg_read(struct pci_dn *pdn,
>


-- 
Alexey
