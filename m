Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpdkM1415zDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:39:22 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CAd5SF043105
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 06:39:20 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243ensnfn2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 06:39:20 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 12 Jul 2016 20:39:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8B477357805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:39:14 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6CAdEdX26411024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:39:14 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6CAdDLO007652
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:39:14 +1000
Subject: Re: [PATCH 07/15] powerpc/powernv: Add support for the cxl kernel api
 on the real phb
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-8-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 12 Jul 2016 20:39:13 +1000
MIME-Version: 1.0
In-Reply-To: <1468237822-26276-8-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c4f8848f-4832-a21e-776d-40726b290b54@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(reviewed late in the evening, apologies if I've missed something)

On 11/07/16 21:50, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This adds support for the peer model of the cxl kernel api to the
> PowerNV PHB, in which physical function 0 represents the cxl function on
> the card (an XSL in the case of the CX4), which other physical functions
> will use for memory access and interrupt services. It is referred to as
> the peer model as these functions are peers of one another, as opposed
> to the Virtual PHB model which forms a hierarchy.
>
> This patch exports APIs to enable the peer mode, check if a PCI device
> is attached to a PHB in this mode, and to set and get the peer AFU for
> this mode.
>
> The cxl driver will enable this mode for supported cards by calling
> pnv_cxl_enable_phb_kernel_api(). This will set a flag in the PHB to note
> that this mode is enabled, and switch out it's controller_ops for the
> cxl version.
>
> The cxl version of the controller_ops struct implements it's own
> versions of the enable_device_hook and release_device to handle
> refcounting on the peer AFU and to allocate a default context for the
> device.
>
> Once enabled, the cxl kernel API may not be disabled on a PHB. Currently
> there is no safe way to disable cxl mode short of a reboot, so until
> that changes there is no reason to support the disable path.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Some comments below - with those addressed:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

>
> ---
>
> V1->V2:
> 	- Add an explanation of the peer model to the commit message,
> 	  and a comment above the pnv_cxl_enable_device_hook function.

The comments are good!

> +/*
> + * Sets flags and switches the controller ops to enable the cxl kernel api.
> + * Original the cxl kernel API operated on a virtual PHB, but certain cards

Originally

> + * such as the Mellanox CX4 use a peer model instead and for these cards the
> + * cxl kernel api will operate on the real PHB.
> + */
> +int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable)
> +{
> +	struct pnv_phb *phb = hose->private_data;
> +	struct module *cxl_module;
> +
> +	if (!enable) {
> +		/*
> +		 * Once cxl mode is enabled on the PHB, there is currently no
> +		 * known safe method to disable it again, and trying risks a
> +		 * checkstop. If we can find a way to safely disable cxl mode
> +		 * in the future we can revisit this, but for now the only sane
> +		 * thing to do is to refuse to disable cxl mode:
> +		 */
> +		return -EPERM;
> +	}
> +
> +	/*
> +	 * Hold a reference to the cxl module since several PHB operations now
> +	 * depend on it, and it would be insane to allow it to be removed so
> +	 * long as we are in this mode (and since we can't safely disable this
> +	 * mode once enabled...).
> +	 */
> +	mutex_lock(&module_mutex);
> +	cxl_module = find_module("cxl");
> +	if (cxl_module)
> +		__module_get(cxl_module);
> +	mutex_unlock(&module_mutex);
> +	if (!cxl_module)
> +		return -ENODEV;
> +
> +	phb->flags |= PNV_PHB_FLAG_CXL;
> +	hose->controller_ops = pnv_cxl_cx4_ioda_controller_ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pnv_cxl_enable_phb_kernel_api);
> +
> +bool pnv_pci_on_cxl_phb(struct pci_dev *dev)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +
> +	return !!(phb->flags & PNV_PHB_FLAG_CXL);
> +}
> +EXPORT_SYMBOL(pnv_pci_on_cxl_phb);

Should these two exports be _GPL as well?

> -static void pnv_pci_release_device(struct pci_dev *pdev)
> +void pnv_pci_release_device(struct pci_dev *pdev)

Why is this being unstatic-ified? I don't see us introducing any new 
uses of it.

>  {
>  	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>  	struct pnv_phb *phb = hose->private_data;
> @@ -3423,7 +3423,7 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>  		       OPAL_ASSERT_RESET);
>  }
>
> -static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
> +const struct pci_controller_ops pnv_pci_ioda_controller_ops = {

It looks like we don't currently use this - is this being unstatic-ised 
in view of allowing a switch back to regular mode in future?

>  extern struct pci_ops pnv_pci_ops;
> @@ -218,6 +222,8 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
>  extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>  extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
>  extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
> +extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
> +extern void pnv_pci_release_device(struct pci_dev *pdev);
>
>  extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>  			    const char *fmt, ...);
> @@ -238,4 +244,14 @@ extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
>  extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
>  extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
>
> +
> +/* cxl functions */
> +extern bool pnv_cxl_enable_device_hook(struct pci_dev *dev);
> +extern void pnv_cxl_disable_device(struct pci_dev *dev);
> +
> +
> +/* phb ops (cxl switches these when enabling the kernel api on the phb) */
> +extern const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops;
> +extern const struct pci_controller_ops pnv_pci_ioda_controller_ops;

See applicable comments about static.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
