Return-Path: <LW@KARO-electronics.de>
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de
 [134.119.228.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCVFC5zq3zDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 23:16:15 +1100 (AEDT)
Date: Thu, 12 Oct 2017 14:05:48 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Julien Thierry <julien.thierry@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter
 <daniel.vetter@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Gabriele Paoloni
 <gabriele.paoloni@huawei.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon
 <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Xinliang Liu
 <z.liuxinliang@hisilicon.com>, Alex Williamson
 <alex.williamson@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, Rongrong Zou <zourongrong@gmail.com>, Dave
 Airlie <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 1/2] vgaarb: Select a default VGA device even if there's
 no legacy VGA
Message-ID: <20171012140548.10754506@karo-electronics.de>
In-Reply-To: <b5373cbb-7d0d-a626-159b-dee0b82d32d0@arm.com>
References: <20171006221358.12211.42879.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171006222428.12211.3635.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <b5373cbb-7d0d-a626-159b-dee0b82d32d0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, 12 Oct 2017 12:24:10 +0100 Julien Thierry wrote:
> Hi Bjorn,
>=20
> On 06/10/17 23:24, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >=20
> > Daniel Axtens reported that on the HiSilicon D05 board, the VGA device =
is
> > behind a bridge that doesn't support PCI_BRIDGE_CTL_VGA, so the VGA arb=
iter
> > never selects it as the default, which means Xorg auto-detection doesn't
> > work.
> >=20
> > VGA is a legacy PCI feature: a VGA device can respond to addresses, e.g=
.,
> > [mem 0xa0000-0xbffff], [io 0x3b0-0x3bb], [io 0x3c0-0x3df], etc., that a=
re
> > not configurable by BARs.  Consequently, multiple VGA devices can confl=
ict
> > with each other.  The VGA arbiter avoids conflicts by ensuring that tho=
se
> > legacy resources are only routed to one VGA device at a time.
> >=20
> > The arbiter identifies the "default VGA" device, i.e., a legacy VGA dev=
ice
> > that was used by boot firmware.  It selects the first device that:
> >=20
> >    - is of PCI_CLASS_DISPLAY_VGA,
> >    - has both PCI_COMMAND_IO and PCI_COMMAND_MEMORY enabled, and
> >    - has PCI_BRIDGE_CTL_VGA set in all upstream bridges.
> >=20
> > Some systems don't have such a device.  For example, if a host bridge
> > doesn't support I/O space, PCI_COMMAND_IO probably won't be enabled for=
 any
> > devices below it.  Or, as on the HiSilicon D05, the VGA device may be
> > behind a bridge that doesn't support PCI_BRIDGE_CTL_VGA, so accesses to=
 the
> > legacy VGA resources will never reach the device.
> >=20
> > This patch extends the arbiter so that if it doesn't find a device that
> > meets all the above criteria, it selects the first device that:
> >=20
> >    - is of PCI_CLASS_DISPLAY_VGA and
> >    - has PCI_COMMAND_IO or PCI_COMMAND_MEMORY enabled
> >=20
> > If it doesn't find even that, it selects the first device that:
> >=20
> >    - is of class PCI_CLASS_DISPLAY_VGA.
> >=20
> > Such a device may not be able to use the legacy VGA resources, but most
> > drivers can operate the device without those.  Setting it as the default
> > device means its "boot_vga" sysfs file will contain "1", which Xorg (via
> > libpciaccess) uses to help select its default output device.
> >=20
> > This fixes Xorg auto-detection on some arm64 systems (HiSilicon D05 in
> > particular; see the link below).
> >=20
> > It also replaces the powerpc fixup_vga() quirk, albeit with slightly
> > different semantics: the quirk selected the first VGA device we found, =
and
> > overrode that selection with any enabled VGA device we found.  If there
> > were several enabled VGA devices, the *last* one we found would become =
the
> > default.
> >=20
> > The code here instead selects the *first* enabled VGA device we find, a=
nd
> > if none are enabled, the first VGA device we find.
> >=20
> > Link: http://lkml.kernel.org/r/20170901072744.2409-1-dja@axtens.net
> > Tested-by: Daniel Axtens <dja@axtens.net>    # arm64, ppc64-qemu-tcg
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   arch/powerpc/kernel/pci-common.c |   12 ------------
> >   drivers/gpu/vga/vgaarb.c         |   25 +++++++++++++++++++++++++
> >   2 files changed, 25 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci=
-common.c
> > index 02831a396419..0ac7aa346c69 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -1740,15 +1740,3 @@ static void fixup_hide_host_resource_fsl(struct =
pci_dev *dev)
> >   }
> >   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hi=
de_host_resource_fsl);
> >   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_h=
ide_host_resource_fsl);
> > -
> > -static void fixup_vga(struct pci_dev *pdev)
> > -{
> > -	u16 cmd;
> > -
> > -	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > -	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_dev=
ice())
> > -		vga_set_default_device(pdev);
> > -
> > -}
> > -DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> > -			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
> > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > index 76875f6299b8..aeb41f793ed4 100644
> > --- a/drivers/gpu/vga/vgaarb.c
> > +++ b/drivers/gpu/vga/vgaarb.c
> > @@ -1468,6 +1468,31 @@ static int __init vga_arb_device_init(void)
> >   			vgaarb_info(dev, "no bridge control possible\n");
> >   	}
> >  =20
> > +	if (!vga_default_device()) {
> > +		list_for_each_entry(vgadev, &vga_list, list) {
> > +			struct device *dev =3D &vgadev->pdev->dev;
> > +			u16 cmd;
> > +
> > +			pdev =3D vgadev->pdev;
> > +			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> > +				vgaarb_info(dev, "setting as boot device (VGA legacy resources not=
 available)\n");
> > +				vga_set_default_device(pdev);
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (!vga_default_device()) {
> > +		vgadev =3D list_first_entry_or_null(&vga_list,
> > +						  struct vga_device, list);
> > +		if (vgadev) {
> > +			struct device *dev =3D &vgadev->pdev->dev;
> > +			vgaarb_info(dev, "setting as boot device (VGA legacy resources not =
available)\n");
> > +			vga_set_default_device(pdev);
>=20
> Isn't 'pdev' NULL here? shouldn't it be vgadev->pdev instead?
>=20
That cannot not happen, though it isn't quite obvious.
'vgadev' will only be non-NULL, when the vga_list isn't empty and in
that case pdev has been set up in the list_for_each_entry() loop above.


Lothar Wa=C3=9Fmann
