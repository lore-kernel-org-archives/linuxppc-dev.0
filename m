Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-x22f.google.com (mail-qc0-x22f.google.com
 [IPv6:2607:f8b0:400d:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 309551A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:41:21 +1100 (AEDT)
Received: by qcvs11 with SMTP id s11so10139792qcv.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 06:41:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150311062225.GC5826@richard>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083442.32124.96716.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224085234.GJ6220@google.com> <20150302074132.GG21571@richard>
 <20150311025125.GC10994@google.com> <20150311062225.GC5826@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Mar 2015 08:40:58 -0500
Message-ID: <CAErSpo7YQJLmAPLTUJKw+msvKsMoqVp2+cNJQ50Xt8h76YAqEw@mail.gmail.com>
Subject: Re: [PATCH v12 15/21] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2015 at 1:22 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Tue, Mar 10, 2015 at 09:51:25PM -0500, Bjorn Helgaas wrote:
>>On Mon, Mar 02, 2015 at 03:41:32PM +0800, Wei Yang wrote:
>>> On Tue, Feb 24, 2015 at 02:52:34AM -0600, Bjorn Helgaas wrote:
>>> >On Tue, Feb 24, 2015 at 02:34:42AM -0600, Bjorn Helgaas wrote:
>>> >> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> >>
>>> >> On PHB3, PF IOV BAR will be covered by M64 window to have better PE
>>> >> isolation.  The total_pe number is usually different from total_VFs, which
>>> >> can lead to a conflict between MMIO space and the PE number.
>>> >>
>>> >> For example, if total_VFs is 128 and total_pe is 256, the second half of
>>> >> M64 window will be part of other PCI device, which may already belong
>>> >> to other PEs.
>>> >
>>> >I'm still trying to wrap my mind around the explanation here.
>>> >
>>> >I *think* what's going on is that the M64 window must be a power-of-two
>>> >size.  If the VF(n) BAR space doesn't completely fill it, we might allocate
>>> >the leftover space to another device.  Then the M64 window for *this*
>>> >device may cause the other device to be associated with a PE it didn't
>>> >expect.
>>>
>>> Yes, this is the exact reason.
>>
>>Can you include some of this text in your changelog, then?  I can wordsmith
>>it and try to make it fit together better.
>>
>
> Sure, I will do this.
>
>>> >> +#ifdef CONFIG_PCI_IOV
>>> >> +static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>> >> +{
>>> >> + struct pci_controller *hose;
>>> >> + struct pnv_phb *phb;
>>> >> + struct resource *res;
>>> >> + int i;
>>> >> + resource_size_t size;
>>> >> + struct pci_dn *pdn;
>>> >> +
>>> >> + if (!pdev->is_physfn || pdev->is_added)
>>> >> +         return;
>>> >> +
>>> >> + hose = pci_bus_to_host(pdev->bus);
>>> >> + phb = hose->private_data;
>>> >> +
>>> >> + pdn = pci_get_pdn(pdev);
>>> >> + pdn->max_vfs = 0;
>>> >> +
>>> >> + for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>> >> +         res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>> >> +         if (!res->flags || res->parent)
>>> >> +                 continue;
>>> >> +         if (!pnv_pci_is_mem_pref_64(res->flags)) {
>>> >> +                 dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
>>> >> +                          i, res);
>>> >> +                 continue;
>>> >> +         }
>>> >> +
>>> >> +         dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>>> >> +         size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>> >> +         res->end = res->start + size * phb->ioda.total_pe - 1;
>>> >> +         dev_dbg(&pdev->dev, "                       %pR\n", res);
>>> >> +         dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
>>> >> +                         i, res, phb->ioda.total_pe);
>>> >> + }
>>> >> + pdn->max_vfs = phb->ioda.total_pe;
>>> >> +}
>>> >> +
>>> >> +static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
>>> >> +{
>>> >> + struct pci_dev *pdev;
>>> >> + struct pci_bus *b;
>>> >> +
>>> >> + list_for_each_entry(pdev, &bus->devices, bus_list) {
>>> >> +         b = pdev->subordinate;
>>> >> +
>>> >> +         if (b)
>>> >> +                 pnv_pci_ioda_fixup_sriov(b);
>>> >> +
>>> >> +         pnv_pci_ioda_fixup_iov_resources(pdev);
>>> >
>>> >I'm not sure this happens at the right time.  We have this call chain:
>>> >
>>> >  pcibios_scan_phb
>>> >    pci_create_root_bus
>>> >    pci_scan_child_bus
>>> >    pnv_pci_ioda_fixup_sriov
>>> >      pnv_pci_ioda_fixup_iov_resources
>>> >    for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
>>> >      increase res->size to accomodate 256 PEs (or roundup(totalVFs)
>>> >
>>> >so we only do the fixup_iov_resources() when we scan the PHB, and we
>>> >wouldn't do it at all for hot-added devices.
>>>
>>> Yep, you are right :-)
>>>
>>> I had a separate patch to do this in pcibios_add_pci_devices(). Looks we could
>>> merge them.
>>
>>Did you fix this in v13?  I don't see the change if you did.
>>
>
> I add this in [PATCH V13 15/21].
>
> In the file arch/powerpc/kernel/pci-hotplug.c, when hotplug a device, the
> fixup will be called on that bus too.

Ah, OK, thanks for the pointer.

>>> >> + }
>>> >> +}
>>> >> +#endif /* CONFIG_PCI_IOV */
>>> >> +
>>> >>  /*
>>> >>   * This function is supposed to be called on basis of PE from top
>>> >>   * to bottom style. So the the I/O or MMIO segment assigned to
>>> >> @@ -2125,6 +2180,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>> >>   ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
>>> >>   ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>>> >>   ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
>>> >> +#ifdef CONFIG_PCI_IOV
>>> >> + ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
>>> >> +#endif /* CONFIG_PCI_IOV */
>>> >>   pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>>> >>
>>> >>   /* Reset IODA tables to a clean state */
>>> >>
>>>
>>> --
>>> Richard Yang
>>> Help you, Help me
>>>
>
> --
> Richard Yang
> Help you, Help me
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
