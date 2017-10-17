Return-Path: <dja@axtens.net>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGJQM3cGhzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 13:03:54 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id k7so208651pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 19:03:54 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Daniel Vetter <daniel.vetter@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 Xinliang Liu <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] vgaarb: Factor out EFI and fallback default device
 selection
In-Reply-To: <20171013034729.14630.30419.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171013034338.14630.4766.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171013034729.14630.30419.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 17 Oct 2017 13:03:46 +1100
Message-ID: <871sm2y1h9.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <bhelgaas@google.com> writes:

> The default VGA device is normally set in vga_arbiter_add_pci_device() when
> we call it for the first enabled device that can be accessed with the
> legacy VGA resources ([mem 0xa0000-0xbffff], etc.)
>
> That default device can be overridden by an EFI device that owns the boot
> framebuffer.  As a fallback, we can also select a VGA device that can't be
> accessed via legacy VGA resources, or a VGA device that isn't even enabled.
>
> Factor out this EFI and fallback selection from vga_arb_device_init() into
> a separate vga_arb_select_default_device() function.  This doesn't change
> any behavior, but it untangles the "bridge control possible" checking and
> messages from the default device selection.
>
> Tested-by: Zhou Wang <wangzhou1@hisilicon.com>  # D05 Hisi Hip07, Hip08
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/gpu/vga/vgaarb.c |   57 ++++++++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 8035e38d5110..d35d6d271f3f 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -1402,29 +1402,14 @@ static struct miscdevice vga_arb_device = {
>  	MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
>  };
>  
> -static int __init vga_arb_device_init(void)
> +static void __init vga_arb_select_default_device(void)
>  {
> -	int rc;
>  	struct pci_dev *pdev;
>  	struct vga_device *vgadev;
>  
> -	rc = misc_register(&vga_arb_device);
> -	if (rc < 0)
> -		pr_err("error %d registering device\n", rc);
> -
> -	bus_register_notifier(&pci_bus_type, &pci_notifier);
> -
> -	/* We add all pci devices satisfying vga class in the arbiter by
> -	 * default */
> -	pdev = NULL;
> -	while ((pdev =
> -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -			       PCI_ANY_ID, pdev)) != NULL)
> -		vga_arbiter_add_pci_device(pdev);
> -
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
>  	list_for_each_entry(vgadev, &vga_list, list) {
>  		struct device *dev = &vgadev->pdev->dev;
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
>  		/*
>  		 * Override vga_arbiter_add_pci_device()'s I/O based detection
>  		 * as it may take the wrong device (e.g. on Apple system under
> @@ -1461,12 +1446,8 @@ static int __init vga_arb_device_init(void)
>  				vgaarb_info(dev, "overriding boot device\n");
>  			vga_set_default_device(vgadev->pdev);
>  		}
> -#endif
> -		if (vgadev->bridge_has_one_vga)
> -			vgaarb_info(dev, "bridge control possible\n");
> -		else
> -			vgaarb_info(dev, "no bridge control possible\n");
>  	}
> +#endif
>  
>  	if (!vga_default_device()) {
>  		list_for_each_entry(vgadev, &vga_list, list) {
> @@ -1492,6 +1473,38 @@ static int __init vga_arb_device_init(void)
>  			vga_set_default_device(vgadev->pdev);
>  		}
>  	}
> +}
> +
> +static int __init vga_arb_device_init(void)
> +{
> +	int rc;
> +	struct pci_dev *pdev;
> +	struct vga_device *vgadev;
> +
> +	rc = misc_register(&vga_arb_device);
> +	if (rc < 0)
> +		pr_err("error %d registering device\n", rc);
> +
> +	bus_register_notifier(&pci_bus_type, &pci_notifier);
> +
> +	/* We add all PCI devices satisfying VGA class in the arbiter by
> +	 * default */
> +	pdev = NULL;
> +	while ((pdev =
> +		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> +			       PCI_ANY_ID, pdev)) != NULL)
> +		vga_arbiter_add_pci_device(pdev);
> +
> +	list_for_each_entry(vgadev, &vga_list, list) {
> +		struct device *dev = &vgadev->pdev->dev;
> +
> +		if (vgadev->bridge_has_one_vga)
> +			vgaarb_info(dev, "bridge control possible\n");
> +		else
> +			vgaarb_info(dev, "no bridge control possible\n");
> +	}

Initially I wondered if this info printk could be moved into
vga_arbiter_check_bridge_sharing(), but it's been separated out since
3448a19da479b ("vgaarb: use bridges to control VGA routing where
possible."), and upon closer examination, it seems you can't be sure a
device doesn't share a bridge until the end of the process, so this is
indeed correct.

Everything else also looks good to me.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

> +
> +	vga_arb_select_default_device();
>  
>  	pr_info("loaded\n");
>  	return rc;
