Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ECA51A02B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 04:26:50 +1000 (EST)
Received: by mail-ie0-f179.google.com with SMTP id tr6so1083205ieb.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 11:26:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1402365399-5121-15-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-15-git-send-email-weiyang@linux.vnet.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 Jun 2014 19:26:27 +0100
Message-ID: <CACxGe6v6Rdd=GQ8qR5LQ64NThidn7kn3WkKFkOXOsNuWq75D-A@mail.gmail.com>
Subject: Re: [RFC PATCH V3 14/17] ppc/pci: create/release dev-tree node for VFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 gwshan@linux.vnet.ibm.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, yan@linux.vnet.ibm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2014 at 2:56 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> Currently, powernv platform is not aware of VFs. This means no dev-node
> represents a VF. Also, VF PCI device is created when PF driver want to enable
> it. This leads to the pdn->pdev and pdn->pe_number an invalid value.
>
> This patch create/release dev-node for VF and fixs this when a VF's pci_dev
> is created.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

I don't think this is the right way to handle this. Unless it is a
fixup to a buggy devicetree provided by firmware, I don't want to see
any code modifying the devicetree to describe stuff that is able to be
directly enumerated. Really the pci code should handle the lack of a
device_node gracefully. If it cannot then it should be fixed.

g.

> ---
>  arch/powerpc/platforms/powernv/Kconfig    |    1 +
>  arch/powerpc/platforms/powernv/pci-ioda.c |  103 +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci.c      |   20 ++++++
>  3 files changed, 124 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 895e8a2..0dd331b 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -11,6 +11,7 @@ config PPC_POWERNV
>         select PPC_UDBG_16550
>         select PPC_SCOM
>         select ARCH_RANDOM
> +       select OF_DYNAMIC
>         default y
>
>  config PPC_POWERNV_RTAS
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index e46c5bf..9ace027 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -23,6 +23,7 @@
>  #include <linux/io.h>
>  #include <linux/msi.h>
>  #include <linux/memblock.h>
> +#include <linux/of_pci.h>
>
>  #include <asm/sections.h>
>  #include <asm/io.h>
> @@ -771,6 +772,108 @@ static void pnv_pci_ioda_setup_PEs(void)
>         }
>  }
>
> +#ifdef CONFIG_PCI_IOV
> +static void pnv_pci_create_vf_node(struct pci_dev *dev, u16 vf_num)
> +{
> +       struct device_node *dn, *p_dn;
> +       struct pci_dn *pdn;
> +       struct pci_controller *hose;
> +       struct property *pp;
> +       void* value;
> +       u16 id;
> +
> +       hose = pci_bus_to_host(dev->bus);
> +
> +       /* Create dev-tree node for VFs if this is a PF */
> +       p_dn = pci_bus_to_OF_node(dev->bus);
> +       if (p_dn == NULL) {
> +               dev_err(&dev->dev, "SRIOV: VF bus NULL device node\n");
> +               return;
> +       }
> +
> +       for (id = 0; id < vf_num; id++) {
> +               dn = kzalloc(sizeof(*dn), GFP_KERNEL);
> +               pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
> +               pp  = kzalloc(sizeof(*pp), GFP_KERNEL);
> +               value = kzalloc(sizeof(u32), GFP_KERNEL);
> +
> +               if (!dn || !pdn || !pp || !value) {
> +                       kfree(dn);
> +                       kfree(pdn);
> +                       kfree(pp);
> +                       kfree(value);
> +                       dev_warn(&dev->dev, "%s: failed to create"
> +                               "dev-tree node for idx(%d)\n",
> +                               __func__, id);
> +
> +                       break;
> +               }
> +
> +               pp->value = value;
> +               pdn->node = dn;
> +               pdn->devfn = pci_iov_virtfn_devfn(dev, id);
> +               pdn->busno = dev->bus->number;
> +               pdn->pe_number = IODA_INVALID_PE;
> +               pdn->phb = hose;
> +
> +               dn->data = pdn;
> +               kref_init(&dn->kref);
> +               dn->full_name = dn->name =
> +                       kasprintf(GFP_KERNEL, "%s/vf%d",
> +                               p_dn->full_name, pdn->devfn);
> +               dn->parent = p_dn;
> +
> +               pp->name = kasprintf(GFP_KERNEL, "reg");
> +               pp->length = 5 * sizeof(__be32);
> +               *(u32*)pp->value = cpu_to_be32(pdn->devfn) << 8;
> +               dn->properties = pp;
> +
> +               of_attach_node(dn);
> +       }
> +}
> +
> +static void pnv_pci_release_vf_node(struct pci_dev *dev, u16 vf_num)
> +{
> +       struct device_node *dn;
> +       struct property *pp;
> +       u16 id;
> +
> +       for (id = 0; id < vf_num; id++) {
> +               dn = of_pci_find_child_device(dev->bus->dev.of_node,
> +                               pci_iov_virtfn_devfn(dev, id));
> +               if (!dn)
> +                       continue;
> +
> +               of_detach_node(dn);
> +               pp = dn->properties;
> +               kfree(pp->name);
> +               kfree(pp->value);
> +               kfree(pp);
> +               kfree(dn->data);
> +               kfree(dn);
> +       }
> +}
> +
> +int pcibios_sriov_disable(struct pci_dev *pdev)
> +{
> +       struct pci_sriov *iov;
> +       u16 vf_num;
> +
> +       iov = pdev->sriov;
> +       vf_num = iov->num_VFs;
> +       pnv_pci_release_vf_node(pdev, vf_num);
> +
> +       return 0;
> +}
> +
> +int pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
> +{
> +       pnv_pci_create_vf_node(pdev, vf_num);
> +
> +       return 0;
> +}
> +#endif /* CONFIG_PCI_IOV */
> +
>  static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev)
>  {
>         struct pci_dn *pdn = pci_get_pdn(pdev);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 687a068..43fcc73 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -654,6 +654,26 @@ static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
>  {
>         struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>         struct pnv_phb *phb = hose->private_data;
> +#ifdef CONFIG_PCI_IOV
> +       struct pnv_ioda_pe *pe;
> +       struct pci_dn *pdn;
> +
> +       /* Fix the VF pdn PE number */
> +       if (pdev->is_virtfn) {
> +               pdn = pci_get_pdn(pdev);
> +               if (pdn->pcidev == NULL || pdn->pe_number == IODA_INVALID_PE) {
> +                       list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> +                               if (pe->rid ==
> +                                       ((pdev->bus->number << 8) | (pdev->devfn & 0xff))) {
> +                                       pdn->pcidev = pdev;
> +                                       pdn->pe_number = pe->pe_number;
> +                                       pe->pdev = pdev;
> +                                       break;
> +                               }
> +                       }
> +               }
> +       }
> +#endif /* CONFIG_PCI_IOV */
>
>         /* If we have no phb structure, try to setup a fallback based on
>          * the device-tree (RTAS PCI for example)
> --
> 1.7.9.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
