Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTdnk0zSvzDr4c
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 07:44:42 +1000 (AEST)
Date: Fri, 11 Aug 2017 16:44:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: simplify and fix VGA default device behaviour
Message-ID: <20170811214438.GI17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170804102033.27731-2-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 04, 2017 at 08:20:31PM +1000, Daniel Axtens wrote:
> Some powerpc devices provide a PCI display that isn't picked up by
> the VGA arbiter, presumably because it doesn't support the PCI
> legacy VGA ranges.
> 
> Commit c2e1d84523ad ("powerpc: Set default VGA device") introduced
> an arch quirk to mark these devices as default to fix X autoconfig.
> 
> The commit message stated that the patch:
> 
>     Ensures a default VGA is always set if a graphics adapter is present,
>     even if firmware did not initialize it. If more than one graphics
>     adapter is present, ensure the one initialized by firmware is set
>     as the default VGA device.
> 
> The patch used the following test to decide whether or not to mark
> a device as default:
> 
>   pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>   if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
>           vga_set_default_device(pdev);
> 
> This doesn't seem like it works quite as intended. Because of the
> logical OR, the default device will be set in 2 cases:
> 
>  1) if there is no default device
> OR
>  2) if this device has normal memory/IO decoding turned on
> 
> This will work as intended if there is only one device, but if
> there are multiple devices, we may override the device the VGA
> arbiter picked.

This quirk only runs on VGA class devices.  If there's more than one
VGA device in the system, and we assume that firmware only enables
PCI_COMMAND_IO or PCI_COMMAND_MEMORY on "the one initialized by
firmware", which seems reasonable to me, I think the existing code
does match the commit message.

We set the first VGA device we find to be the default.  Then, if we
find another VGA device that's enabled, we make *it* the default
instead.

> Instead, set a device as default if there is no default device AND
> this device decodes.
> 
> This will not change behaviour on single-headed systems.

If there is no enabled VGA device on the system, your new code means
there will be no default VGA device.

It's not clear from this changelog what problem this patch solves.
Maybe it's the "some displays not being picked up by the VGA arbiter"
you mentioned, but there's not enough detail to connect it with the
patch, especially since the patch means we'll set the default device
in fewer cases than we did before.

With the patch, we only set the default if we find an enabled VGA
device.  Previously we also set the default if we found a VGA device
that had not been enabled.

> Cc: Brian King <brking@linux.vnet.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> Tested in TCG (the card provided by qemu doesn't automatically
> register with vgaarb, so the relevant code path has been tested)
> but I would appreciate any tests on real hardware.
> 
> Informal benh ack: https://patchwork.kernel.org/patch/9850235/
> ---
>  arch/powerpc/kernel/pci-common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 341a7469cab8..c95fdda3a2dc 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1746,8 +1746,11 @@ static void fixup_vga(struct pci_dev *pdev)
>  {
>  	u16 cmd;
>  
> +	if (vga_default_device())
> +		return;
> +
>  	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> -	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
> +	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
>  		vga_set_default_device(pdev);
>  
>  }
> -- 
> 2.11.0
> 
