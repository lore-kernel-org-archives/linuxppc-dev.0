Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-f49.google.com (mail-oa0-f49.google.com
 [209.85.219.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A98362C008D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 05:40:05 +1100 (EST)
Received: by mail-oa0-f49.google.com with SMTP id j6so7812161oag.22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 11:40:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363757079-23550-2-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1363757079-23550-2-git-send-email-lucaskt@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 26 Mar 2013 12:39:39 -0600
Message-ID: <CAErSpo4rc=8mYgwuTO6693QCQJ9nsPsxmh7YAwxMygiVrPQR0A@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] pci: added pcie_get_speed_cap_mask function
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Airlie <airlied@linux.ie>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 DRI mailing list <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 19, 2013 at 11:24 PM, Lucas Kannebley Tavares
<lucaskt@linux.vnet.ibm.com> wrote:
> Added function to gather the speed cap for a device and return a mask to
> supported speeds. The function is divided into an interface and a weak
> implementation so that architecture-specific functions can be called.
>
> This is the first step in moving function drm_pcie_get_speed_cap_mask
> from the drm subsystem to the pci one.

This still doesn't feel right to me.

I'm definitely not a hardware guy, but my understanding based on the
PCIe spec r3.0, sec 6.11, is that the hardware will automatically
maintain the link at the highest speed supported by both ends of the
link, unless software sets a lower Target Link Speed.  The only users
of this function are some Radeon drivers, and it looks like they only
use it because the hardware doesn't conform to this aspect of the spec
and requires device-specific tweaking.

We already have bus->max_bus_speed, which should tell you the max
speed supported by the upstream component.  Is that enough
information?  Maybe the radeon drivers could simply do something like
this:

    speed = rdev->ddev->pdev->bus->max_bus_speed;
    if (speed == PCI_SPEED_UNKNOWN || speed < PCIE_SPEED_5_0GT)
        return;

In your original email [1], you mentioned a null pointer dereference,
presumably when reading the PCIe capability for dev->pdev->bus->self,
with "self" being NULL.  This only happens for a bus with no upstream
P2P bridge, i.e., self will be NULL only if pdev is on a root bus.
But we also know pdev is a PCIe device, and I think a PCIe device on a
root bus must be a "Root Complex Integrated Endpoint" (PCIe spec sec
1.3.2.3).  Such a device does not have a link at all, so there's no
point in fiddling with its link speed.

I don't see how a radeon device could be an integrated endpoint, but
in your hypervisor environment, maybe it isn't quite spec-compliant in
terms of its attachment.  Can you collect the output of "lspci -vv"?
Maybe that will make things clearer.

In any case, if a radeon device is on a root bus, I think the root bus
max_bus_speed will be PCI_SPEED_UNKNOWN, and if it's not on a root
bus, max_bus_speed should be set correctly based on the upstream PCIe
port.

Bjorn

[1] http://lkml.kernel.org/r/50819140.8030806@linux.vnet.ibm.com

> Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c   |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |    6 ++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b099e00..d94ab79 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3931,6 +3931,50 @@ static int __init pci_setup(char *str)
>  }
>  early_param("pci", pci_setup);
>
> +int __weak pcibios_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
> +{
> +       struct pci_dev *root;
> +       u32 lnkcap, lnkcap2;
> +
> +       *mask = 0;
> +       if (!dev)
> +               return -EINVAL;
> +
> +       root = dev->bus->self;
> +
> +       /* we've been informed via and serverworks don't make the cut */
> +       if (root->vendor == PCI_VENDOR_ID_VIA ||
> +           root->vendor == PCI_VENDOR_ID_SERVERWORKS)
> +               return -EINVAL;
> +
> +       pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
> +       pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
> +
> +       if (lnkcap2) {  /* PCIe r3.0-compliant */
> +               if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
> +                       *mask |= PCIE_SPEED_25;
> +               if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
> +                       *mask |= PCIE_SPEED_50;
> +               if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
> +                       *mask |= PCIE_SPEED_80;
> +       } else {        /* pre-r3.0 */
> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> +                       *mask |= PCIE_SPEED_25;
> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> +                       *mask |= (PCIE_SPEED_25 | PCIE_SPEED_50);
> +       }
> +
> +       dev_info(&dev->dev, "probing gen 2 caps for device %x:%x = %x/%x\n",
> +               root->vendor, root->device, lnkcap, lnkcap2);
> +       return 0;
> +}
> +
> +int pcie_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
> +{
> +       return pcibios_get_speed_cap_mask(dev, mask);
> +}
> +EXPORT_SYMBOL(pcie_get_speed_cap_mask);
> +
>  EXPORT_SYMBOL(pci_reenable_device);
>  EXPORT_SYMBOL(pci_enable_device_io);
>  EXPORT_SYMBOL(pci_enable_device_mem);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2461033a..24a2f63 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1861,4 +1861,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>   */
>  struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
>
> +#define PCIE_SPEED_25 1
> +#define PCIE_SPEED_50 2
> +#define PCIE_SPEED_80 4
> +
> +extern int pcie_get_speed_cap_mask(struct pci_dev *dev, u32 *speed_mask);
> +
>  #endif /* LINUX_PCI_H */
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
