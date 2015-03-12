Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61A0F1A0299
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 11:51:31 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0115.outbound.protection.outlook.com [157.56.111.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C2A3D140146
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 11:51:29 +1100 (AEDT)
Message-ID: <1426119490.30327.99.camel@freescale.com>
Subject: Re: [PATCH 4/4 RFC] fsl/msi: Add interface to reserve/free msi bank
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <Bharat.Bhushan@freescale.com>
Date: Wed, 11 Mar 2015 19:18:10 -0500
In-Reply-To: <1425359866-31049-4-git-send-email-Bharat.Bhushan@freescale.com>
References: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1425359866-31049-4-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-03 at 10:47 +0530, Bharat Bhushan wrote:
> This patch allows a context (different from kernel context)
> to reserve a MSI bank for itself. And then the devices in the
> context will share the MSI bank.
> 
> VFIO meta driver is one of typical user of these APIs. It will
> reserve a MSI bank for MSI interrupt support of direct assignment
> PCI devices to a Guest. Patches for same will follow this patch.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
> ---
>  arch/powerpc/include/asm/device.h  |   2 +
>  arch/powerpc/include/asm/fsl_msi.h |  26 ++++++
>  arch/powerpc/sysdev/fsl_msi.c      | 169 +++++++++++++++++++++++++++++++------
>  arch/powerpc/sysdev/fsl_msi.h      |   1 +
>  4 files changed, 173 insertions(+), 25 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/fsl_msi.h
> 
> diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
> index 38faede..1c2bfd7 100644
> --- a/arch/powerpc/include/asm/device.h
> +++ b/arch/powerpc/include/asm/device.h
> @@ -40,6 +40,8 @@ struct dev_archdata {
>  #ifdef CONFIG_FAIL_IOMMU
>  	int fail_iommu;
>  #endif
> +
> +	void *context;
>  };

This needs a comment and probably a more specific name.

> @@ -200,6 +185,12 @@ static struct fsl_msi *fsl_msi_get_reserved_msi_bank(struct pci_dev *pdev)
>  {
>  	struct fsl_msi *msi_data = NULL;
>  	void *context = NULL;
> +	struct device *dev = &pdev->dev;
> +
> +	/* Device assigned to userspace if there is valid context */
> +	if (dev->archdata.context) {
> +		context = dev->archdata.context;
> +	}

No {}

>  
>  	list_for_each_entry(msi_data, &msi_head, list) {
>  		if ((msi_data->reserved == MSI_RESERVED) &&
> @@ -208,13 +199,133 @@ static struct fsl_msi *fsl_msi_get_reserved_msi_bank(struct pci_dev *pdev)
>  	}
>  
>  	/* If no MSI bank allocated for kernel owned device, allocate one */
> -	msi_data = fsl_msi_allocate_msi_bank(NULL);
> -	if (msi_data)
> -		return msi_data;
> +	if (!context) {
> +		msi_data = fsl_msi_allocate_msi_bank(NULL);
> +		if (msi_data)
> +			return msi_data;
> +	}
>  
>  	return NULL;
>  }
>  
> +/* API to set "context" to which the device belongs */
> +int fsl_msi_set_msi_bank_in_dev(struct device *dev, void *data)
> +{
> +	dev->archdata.context = data;
> +	return 0;
> +}

Do we really need "msi" to appear twice in every function name?

> +
> +/*  This API Allows a MSI bank to be reserved for a "context".
> + *  All devices in same "context" will share the allocated
> + *  MSI bank.
> + *  Typically this function will be called from meta
> + *  driver like VFIO with a valid "context".
> + */
> +struct fsl_msi *fsl_msi_reserve_msi_bank(void *context)
> +{
> +	struct fsl_msi *msi_data;
> +
> +	if (!context)
> +		return NULL;
> +
> +	/* Check if msi-bank already allocated for the context */
> +	list_for_each_entry(msi_data, &msi_head, list) {
> +		if (msi_data->reserved == MSI_FREE)
> +			continue;
> +
> +		if (context == msi_data->context)
> +			return msi_data;

The reserved == MSI_FREE check doesn't add anything because if it's free
then the context check will fail.

> +static int is_msi_bank_reserved(struct fsl_msi *msi)

s/int/bool/


> +/*
> + * This function configures PAMU window for MSI page with
> + * given iova. Also same iova will be used as "msi-address"
> + * when configuring msi-message in the devices using this
> + * msi bank.
> + */
> +int fsl_msi_set_msi_bank_region(struct iommu_domain *domain,
> +				void *context , int win,

Whitespace

> @@ -225,12 +336,17 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
>  	int len;
>  	const __be64 *reg;
>  
> -	/* If the msi-address-64 property exists, then use it */
> -	reg = of_get_property(hose->dn, "msi-address-64", &len);
> -	if (reg && (len == sizeof(u64)))
> -		address = be64_to_cpup(reg);
> -	else
> -		address = msi_data->msiir;
> +	if (pdev->dev.archdata.context) {
> +		address = msi_data->iova;
> +	} else {
> +		/* If the msi-address-64 property exists, then use it */
> +		reg = of_get_property(hose->dn, "msi-address-64", &len);
> +		if (reg && (len == sizeof(u64)))
> +			address = be64_to_cpup(reg);
> +		else
> +			address = fsl_pci_immrbar_base(hose) +
> +					(msi_data->msiir & 0xfffff);
> +	}

You removed the call to fsl_pci_immrbar_base in patch 1/4 and are
reintroducing it here.  If this call is needed, how does it work in
between those two patches?

> @@ -401,6 +517,9 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
>  	struct fsl_msi *msi = platform_get_drvdata(ofdev);
>  	int virq, i;
>  
> +	if (is_msi_bank_reserved(msi))
> +		return -EBUSY;

As I mentioned in discussion of a prior version of this, the driver core
ignores error codes in .remove().  Since there's no reason to remove
this piece of platform infrastructure, and the remove path has probably
never been tested, I'd just replace the whole thing with BUG().

-Scott
