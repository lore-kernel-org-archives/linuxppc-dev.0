Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 394631A0615
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 01:41:06 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 07:41:03 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 802D119D8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 07:28:56 -0700 (MST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24EexwA32309264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 14:41:00 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24Eew9h010827
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 09:40:59 -0500
Subject: Re: [PATCH v6 19/20] cxlflash: Use new cxl_pci_read_adapter_vpd() API
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1457090804-9719-20-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <56D99E7F.3030605@linux.vnet.ibm.com>
Date: Fri, 4 Mar 2016 08:41:03 -0600
MIME-Version: 1.0
In-Reply-To: <1457090804-9719-20-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks good !

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

On 3/4/2016 5:26 AM, Frederic Barrat wrote:
> To read the adapter VPD, drivers can't rely on pci config APIs, as it
> wouldn't work on powerVM. cxl introduced a new kernel API especially
> for this, so start using it.
>
> Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>   drivers/scsi/cxlflash/common.h |  1 -
>   drivers/scsi/cxlflash/main.c   | 18 ++----------------
>   2 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
> index 5ada926..580f370 100644
> --- a/drivers/scsi/cxlflash/common.h
> +++ b/drivers/scsi/cxlflash/common.h
> @@ -106,7 +106,6 @@ struct cxlflash_cfg {
>   	atomic_t scan_host_needed;
>
>   	struct cxl_afu *cxl_afu;
> -	struct pci_dev *parent_dev;
>
>   	atomic_t recovery_threads;
>   	struct mutex ctx_recovery_mutex;
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index f6d90ce..e04aae7 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -1407,7 +1407,7 @@ static int start_context(struct cxlflash_cfg *cfg)
>    */
>   static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
>   {
> -	struct pci_dev *dev = cfg->parent_dev;
> +	struct pci_dev *dev = cfg->dev;
>   	int rc = 0;
>   	int ro_start, ro_size, i, j, k;
>   	ssize_t vpd_size;
> @@ -1416,7 +1416,7 @@ static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
>   	char *wwpn_vpd_tags[NUM_FC_PORTS] = { "V5", "V6" };
>
>   	/* Get the VPD data from the device */
> -	vpd_size = pci_read_vpd(dev, 0, sizeof(vpd_data), vpd_data);
> +	vpd_size = cxl_read_adapter_vpd(dev, vpd_data, sizeof(vpd_data));
>   	if (unlikely(vpd_size <= 0)) {
>   		dev_err(&dev->dev, "%s: Unable to read VPD (size = %ld)\n",
>   		       __func__, vpd_size);
> @@ -2392,7 +2392,6 @@ static int cxlflash_probe(struct pci_dev *pdev,
>   {
>   	struct Scsi_Host *host;
>   	struct cxlflash_cfg *cfg = NULL;
> -	struct device *phys_dev;
>   	struct dev_dependent_vals *ddv;
>   	int rc = 0;
>
> @@ -2458,19 +2457,6 @@ static int cxlflash_probe(struct pci_dev *pdev,
>
>   	pci_set_drvdata(pdev, cfg);
>
> -	/*
> -	 * Use the special service provided to look up the physical
> -	 * PCI device, since we are called on the probe of the virtual
> -	 * PCI host bus (vphb)
> -	 */
> -	phys_dev = cxl_get_phys_dev(pdev);
> -	if (!dev_is_pci(phys_dev)) {
> -		dev_err(&pdev->dev, "%s: not a pci dev\n", __func__);
> -		rc = -ENODEV;
> -		goto out_remove;
> -	}
> -	cfg->parent_dev = to_pci_dev(phys_dev);
> -
>   	cfg->cxl_afu = cxl_pci_to_afu(pdev);
>
>   	rc = init_pci(cfg);
>
