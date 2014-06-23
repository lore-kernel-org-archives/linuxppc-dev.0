Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 116B21A017A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:29:27 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Jun 2014 09:29:25 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 316852BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:29:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5NN75Jo8192500
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:07:05 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5NNTKkN008585
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:29:21 +1000
Date: Tue, 24 Jun 2014 09:29:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 12/17] powerpc/powernv: implement
 pcibios_sriov_resource_alignment on powernv
Message-ID: <20140623232922.GA4018@shangw>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-13-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140623060947.GB12055@shangw> <20140623082142.GB4509@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140623082142.GB4509@richard>
Cc: benh@au1.ibm.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, yan@linux.vnet.ibm.com,
 bhelgaas@google.com, qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2014 at 04:21:42PM +0800, Wei Yang wrote:
>On Mon, Jun 23, 2014 at 04:09:47PM +1000, Gavin Shan wrote:
>>On Tue, Jun 10, 2014 at 09:56:34AM +0800, Wei Yang wrote:
>>>This patch implements the pcibios_sriov_resource_alignment() on powernv
>>>platform.
>>>
>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>---
>>> arch/powerpc/include/asm/machdep.h        |    1 +
>>> arch/powerpc/kernel/pci-common.c          |    8 ++++++++
>>> arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++++++++
>>> 3 files changed, 26 insertions(+)
>>>
>>>diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>>>index 2f2e770..3bbc55f 100644
>>>--- a/arch/powerpc/include/asm/machdep.h
>>>+++ b/arch/powerpc/include/asm/machdep.h
>>>@@ -242,6 +242,7 @@ struct machdep_calls {
>>> 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
>>> #ifdef CONFIG_PCI_IOV
>>> 	resource_size_t (*__pci_sriov_resource_size)(struct pci_dev *, int resno);
>>>+	resource_size_t (*__pci_sriov_resource_alignment)(struct pci_dev *, int resno, resource_size_t align);

Both lines exceed 80 lines here :)

>>> #endif /* CONFIG_PCI_IOV */
>>>
>>> 	/* Called to shutdown machine specific hardware not already controlled
>>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>>index c4e2e92..35345ac 100644
>>>--- a/arch/powerpc/kernel/pci-common.c
>>>+++ b/arch/powerpc/kernel/pci-common.c
>>>@@ -128,6 +128,14 @@ resource_size_t pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
>>>
>>> 	return 0;
>>> }
>>>+
>>>+resource_size_t pcibios_sriov_resource_alignment(struct pci_dev *pdev, int resno, resource_size_t align)
>>>+{
>>>+	if (ppc_md.__pci_sriov_resource_alignment)
>>>+		return ppc_md.__pci_sriov_resource_alignment(pdev, resno, align);
>>>+
>>>+	return 0;
>>>+}
>>> #endif /* CONFIG_PCI_IOV */
>>>
>>> static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>index 7dfad6a..b0ac851 100644
>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>@@ -1573,6 +1573,22 @@ static resource_size_t __pnv_pci_sriov_resource_size(struct pci_dev *pdev, int r
>>>
>>> 	return size;
>>> }
>>>+
>>>+static resource_size_t __pnv_pci_sriov_resource_alignment(struct pci_dev *pdev, int resno,
>>>+		resource_size_t align)
>>
>>The function could be "pcibios_sriov_resource_alignment()", but it's not a big deal.
>>If you prefer the original one, then keep it :)
>
>I guess you want to name it to pnv_pcibios_sriov_resource_alignment()?
>pcibios_sriov_resource_alignment() is the general name for this function.
>
>If yes, this is changed.
>

Nope, What I mean is to have something like this:

	struct machdep_calls {
		:
	#ifdef CONFIG_PCI_IOV
	resource_size_t (*pci_sriov_resource_size)(struct pci_dev *dev,
						   int resno);
	resource_size_t (*pci_sriov_resource_alignment)(struct pci_dev *dev,
							int resno,
							resource_size_t align);
	#endif
		:
	}

	ppc_md.pci_sriov_resource_size = pnv_pci_iov_res_size;
	ppc_md.pci_sriov_resource_alignment = pnv_pci_iov_res_alignment;

The point is not to have prefix "__" for callbacks in "struct machdep_calls".
ppc_md.__pci_sriov_resource_size is the first one that has prefix "__"

>>
>>>+{
>>>+	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>+	resource_size_t iov_align;
>>>+
>>>+	iov_align = resource_size(&pdev->resource[resno]);
>>>+	if (iov_align)
>>>+		return iov_align;
>>>+
>>>+	if (pdn->vfs)
>>>+		return pdn->vfs * align;
>>>+
>>>+	return align;
>>>+}
>>> #endif /* CONFIG_PCI_IOV */
>>>
>>> /* Prevent enabling devices for which we couldn't properly
>>>@@ -1777,6 +1793,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>> 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>>> #ifdef CONFIG_PCI_IOV
>>> 	ppc_md.__pci_sriov_resource_size = __pnv_pci_sriov_resource_size;
>>>+	ppc_md.__pci_sriov_resource_alignment = __pnv_pci_sriov_resource_alignment;
>>> #endif /* CONFIG_PCI_IOV */
>>> 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>>>

Thanks,
Gavin
