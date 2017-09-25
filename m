Return-Path: <dja@axtens.net>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1L766mHszDsPs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 09:35:46 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a7so4236608pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 16:35:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com, catalin.marinas@arm.com,
 will.deacon@arm.com, gabriele.paoloni@huawei.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org, lukas@wunner.de, ard.biesheuvel@linaro.org,
 lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/3] Split default display handling out from VGA arbiter
In-Reply-To: <20170925163948.GD15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170901072744.2409-1-dja@axtens.net>
 <20170925163948.GD15970@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 26 Sep 2017 09:35:40 +1000
Message-ID: <87zi9ixsfn.fsf@linkitivity.dja.id.au>
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

Hi Bjorn,

> But I think trying to split the "default device" part out from the VGA
> arbiter ends up being overkill and making things more complicated
> instead of simpler.
Fair enough.

> Would something like the following work for you as well as the powerpc
> case?  On powerpc, we already use vga_set_default_device() to select a
> device that doesn't use legacy VGA resources, so maybe we can just do
> the same on ARM64?

It looks good. I'll try to get some time on the test system to test it
and I'll pester my friends at IBM to give it a go as well.

> I suppose there might be wrinkles in how the arbiter deals with
> multiple graphics devices on those systems, since I don't think it
> identifies these devices that don't use the legacy resources, but it
> seems like we live with whatever those on are powerpc and probably can
> on ARM64 as well.

I would say so, yes.

Thanks for sticking with this!

Regards,
Daniel

>
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 02831a396419..0ac7aa346c69 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1740,15 +1740,3 @@ static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
> -
> -static void fixup_vga(struct pci_dev *pdev)
> -{
> -	u16 cmd;
> -
> -	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> -	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
> -		vga_set_default_device(pdev);
> -
> -}
> -DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> -			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 76875f6299b8..9df4802c5f04 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -1468,6 +1468,21 @@ static int __init vga_arb_device_init(void)
>  			vgaarb_info(dev, "no bridge control possible\n");
>  	}
>  
> +	if (!vga_default_device()) {
> +		list_for_each_entry(vgadev, &vga_list, list) {
> +			struct device *dev = &vgadev->pdev->dev;
> +			u16 cmd;
> +
> +			pdev = vgadev->pdev;
> +			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> +				vgaarb_info(dev, "setting as boot device\n");
> +				vga_set_default_device(pdev);
> +				break;
> +			}
> +		}
> +	}
> +
>  	pr_info("loaded\n");
>  	return rc;
>  }
