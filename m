Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y80d55cfKzDqlT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 06:51:21 +1100 (AEDT)
Date: Fri, 6 Oct 2017 14:51:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org, lukas@wunner.de,
 ard.biesheuvel@linaro.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/3] Split default display handling out from VGA arbiter
Message-ID: <20171006195118.GG25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170901072744.2409-1-dja@axtens.net>
 <20170925163948.GD15970@bhelgaas-glaptop.roam.corp.google.com>
 <87k20kyezs.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k20kyezs.fsf@linkitivity.dja.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 27, 2017 at 01:52:55PM +1000, Daniel Axtens wrote:
> Hi Bjorn,
> 
> Yes, this works:
> 
> Tested-by: Daniel Axtens <dja@axtens.net> # arm64, ppc64-qemu-tcg

I guess I was assuming you'd pick this up, but that doesn't really
make sense because I didn't give you a signed-off-by or anything.
I'll post this with a changelog and signed-off-by so it doesn't get
lost.

I also noticed that I didn't correctly handle the powerpc quirk case
where it doesn't require the device to be enabled at all.  I'll try to
fix that up, too.

Bjorn

> > On Fri, Sep 01, 2017 at 05:27:41PM +1000, Daniel Axtens wrote:
> >> This patch set:
> >> 
> >>  - splits the default display handling out from VGA arbiter, into its
> >>    own file and behind its own Kconfig option (and gives the functions
> >>    better names).
> >> 
> >>  - adds extra detection of default devices. To be nominated, the vga
> >>    arbiter and platform hooks must not have nominated a default. A
> >>    card will then only be nominated if it has a driver attached and
> >>    has IO or memory decoding enabled.
> >> 
> >>  - adds relevant documentation.
> >> 
> >> The practical impact of this is improved X autoconfiguration on some
> >> arm64 systems.
> >
> > I think I gave you bad advice about trying to separate the "default
> > device" idea from the VGA arbiter.
> >
> > It is true that the "VGA arbiter" per se is related to routing the
> > legacy VGA resources, and the arbiter currently only selects a default
> > device if it finds a device to which those resources are routed.
> >
> > We have some cases where we want to select a default device that may
> > not support the legacy VGA resources, or where they might not be
> > routed to the device:
> >
> >   - systems where we match the EFI framebuffer address with a BAR, and
> >     select that device as default,
> >
> >   - powerpc systems where there may be no host bridge window that maps
> >     to the legacy VGA resources,
> >
> >   - your ARM64 systems where the default device may be behind a bridge
> >     that doesn't support legacy VGA routing (PCI_BRIDGE_CTL_VGA)
> >
> > But I think trying to split the "default device" part out from the VGA
> > arbiter ends up being overkill and making things more complicated
> > instead of simpler.
> >
> > Would something like the following work for you as well as the powerpc
> > case?  On powerpc, we already use vga_set_default_device() to select a
> > device that doesn't use legacy VGA resources, so maybe we can just do
> > the same on ARM64?
> >
> > I suppose there might be wrinkles in how the arbiter deals with
> > multiple graphics devices on those systems, since I don't think it
> > identifies these devices that don't use the legacy resources, but it
> > seems like we live with whatever those on are powerpc and probably can
> > on ARM64 as well.
> >
> >
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index 02831a396419..0ac7aa346c69 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -1740,15 +1740,3 @@ static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
> > -
> > -static void fixup_vga(struct pci_dev *pdev)
> > -{
> > -	u16 cmd;
> > -
> > -	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > -	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
> > -		vga_set_default_device(pdev);
> > -
> > -}
> > -DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> > -			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
> > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > index 76875f6299b8..9df4802c5f04 100644
> > --- a/drivers/gpu/vga/vgaarb.c
> > +++ b/drivers/gpu/vga/vgaarb.c
> > @@ -1468,6 +1468,21 @@ static int __init vga_arb_device_init(void)
> >  			vgaarb_info(dev, "no bridge control possible\n");
> >  	}
> >  
> > +	if (!vga_default_device()) {
> > +		list_for_each_entry(vgadev, &vga_list, list) {
> > +			struct device *dev = &vgadev->pdev->dev;
> > +			u16 cmd;
> > +
> > +			pdev = vgadev->pdev;
> > +			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> > +				vgaarb_info(dev, "setting as boot device\n");
> > +				vga_set_default_device(pdev);
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> >  	pr_info("loaded\n");
> >  	return rc;
> >  }
> 
> 
