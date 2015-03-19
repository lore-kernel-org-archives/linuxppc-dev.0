Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C61381A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 02:08:31 +1100 (AEDT)
Received: by oigv203 with SMTP id v203so67195366oig.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 08:08:27 -0700 (PDT)
Date: Thu, 19 Mar 2015 10:08:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V13 15/21] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
Message-ID: <20150319150824.GE26935@google.com>
References: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425446353-30513-16-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150311135507.GA16664@google.com> <20150312011517.GA5833@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312011517.GA5833@richard>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2015 at 09:15:17AM +0800, Wei Yang wrote:
> On Wed, Mar 11, 2015 at 08:55:07AM -0500, Bjorn Helgaas wrote:
> >On Wed, Mar 04, 2015 at 01:19:07PM +0800, Wei Yang wrote:
> >> On PHB3, PF IOV BAR will be covered by M64 window to have better PE
> >> isolation.  The total_pe number is usually different from total_VFs, which
> >> can lead to a conflict between MMIO space and the PE number.
> >> 
> >> For example, if total_VFs is 128 and total_pe is 256, the second half of
> >> M64 window will be part of other PCI device, which may already belong
> >> to other PEs.
> >> 
> >> Prevent the conflict by reserving additional space for the PF IOV BAR,
> >> which is total_pe number of VF's BAR size.
> >> 
> >> [bhelgaas: make dev_printk() output more consistent, index resource[]
> >> conventionally]
> >> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/machdep.h        |    4 ++
> >>  arch/powerpc/include/asm/pci-bridge.h     |    3 ++
> >>  arch/powerpc/kernel/pci-common.c          |    5 +++
> >>  arch/powerpc/kernel/pci-hotplug.c         |    4 ++
> >>  arch/powerpc/platforms/powernv/pci-ioda.c |   61 +++++++++++++++++++++++++++++
> >>  5 files changed, 77 insertions(+)
> >> 
> >> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> >> index c8175a3..965547c 100644
> >> --- a/arch/powerpc/include/asm/machdep.h
> >> +++ b/arch/powerpc/include/asm/machdep.h
> >> @@ -250,6 +250,10 @@ struct machdep_calls {
> >>  	/* Reset the secondary bus of bridge */
> >>  	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
> >>  
> >> +#ifdef CONFIG_PCI_IOV
> >> +	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
> >> +#endif /* CONFIG_PCI_IOV */
> >> +
> >>  	/* Called to shutdown machine specific hardware not already controlled
> >>  	 * by other drivers.
> >>  	 */
> >> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> >> index 513f8f2..de11de7 100644
> >> --- a/arch/powerpc/include/asm/pci-bridge.h
> >> +++ b/arch/powerpc/include/asm/pci-bridge.h
> >> @@ -175,6 +175,9 @@ struct pci_dn {
> >>  #define IODA_INVALID_PE		(-1)
> >>  #ifdef CONFIG_PPC_POWERNV
> >>  	int	pe_number;
> >> +#ifdef CONFIG_PCI_IOV
> >> +	u16     max_vfs;		/* number of VFs IOV BAR expended */
> >> +#endif /* CONFIG_PCI_IOV */
> >>  #endif
> >>  	struct list_head child_list;
> >>  	struct list_head list;
> >> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> >> index 8203101..022e9fe 100644
> >> --- a/arch/powerpc/kernel/pci-common.c
> >> +++ b/arch/powerpc/kernel/pci-common.c
> >> @@ -1646,6 +1646,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
> >>  	if (ppc_md.pcibios_fixup_phb)
> >>  		ppc_md.pcibios_fixup_phb(hose);
> >>  
> >> +#ifdef CONFIG_PCI_IOV
> >> +	if (ppc_md.pcibios_fixup_sriov)
> >> +		ppc_md.pcibios_fixup_sriov(bus);
> >> +#endif /* CONFIG_PCI_IOV */
> >
> >Here, and ...
> >
> >> +
> >>  	/* Configure PCI Express settings */
> >>  	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> >>  		struct pci_bus *child;
> >> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> >> index 5b78917..7d238ae 100644
> >> --- a/arch/powerpc/kernel/pci-hotplug.c
> >> +++ b/arch/powerpc/kernel/pci-hotplug.c
> >> @@ -94,6 +94,10 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
> >>  		 */
> >>  		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
> >>  		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> >> +#ifdef CONFIG_PCI_IOV
> >> +		if (ppc_md.pcibios_fixup_sriov)
> >> +			ppc_md.pcibios_fixup_sriov(bus);
> >> +#endif /* CONFIG_PCI_IOV */
> >
> >here, you have the same code.  It's good that we now do it for hot-added
> >devices as well as those present at boot.  But it's bad that it happens in
> >two different paths.
> >
> >Isn't there some way we can unify this so the same path is used for the
> >initial pcibios_scan_phb() and also the hot-add case?  Maybe call
> >pcibios_fixup_sriov() from pcibios_add_device()?
> >
> 
> 
> This is a very good suggestion. I have changed this and works fine.

I was expecting a v14 series with this change.  Is it coming, or are you
waiting for something else from me?
