Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D55D1A0195
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 11:24:22 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 24 Jun 2014 06:54:19 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 57F5D394003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 06:54:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5O1PRl262128214
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 06:55:27 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5O1OFii027916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 06:54:15 +0530
Date: Tue, 24 Jun 2014 09:24:14 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 12/17] powerpc/powernv: implement
 pcibios_sriov_resource_alignment on powernv
Message-ID: <20140624012414.GA5204@richard>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-13-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140623060947.GB12055@shangw> <20140623082142.GB4509@richard>
 <20140623232922.GA4018@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140623232922.GA4018@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linux-pci@vger.kernel.org, yan@linux.vnet.ibm.com, bhelgaas@google.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 09:29:22AM +1000, Gavin Shan wrote:
>On Mon, Jun 23, 2014 at 04:21:42PM +0800, Wei Yang wrote:
>>On Mon, Jun 23, 2014 at 04:09:47PM +1000, Gavin Shan wrote:
>>>On Tue, Jun 10, 2014 at 09:56:34AM +0800, Wei Yang wrote:
>>>>This patch implements the pcibios_sriov_resource_alignment() on powernv
>>>>platform.
>>>>
>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>---
>>>> arch/powerpc/include/asm/machdep.h        |    1 +
>>>> arch/powerpc/kernel/pci-common.c          |    8 ++++++++
>>>> arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++++++++
>>>> 3 files changed, 26 insertions(+)
>>>>
>>>>diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>>>>index 2f2e770..3bbc55f 100644
>>>>--- a/arch/powerpc/include/asm/machdep.h
>>>>+++ b/arch/powerpc/include/asm/machdep.h
>>>>@@ -242,6 +242,7 @@ struct machdep_calls {
>>>> 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
>>>> #ifdef CONFIG_PCI_IOV
>>>> 	resource_size_t (*__pci_sriov_resource_size)(struct pci_dev *, int resno);
>>>>+	resource_size_t (*__pci_sriov_resource_alignment)(struct pci_dev *, int resno, resource_size_t align);
>
>Both lines exceed 80 lines here :)
>
>>>> #endif /* CONFIG_PCI_IOV */
>>>>
>>>> 	/* Called to shutdown machine specific hardware not already controlled
>>>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>>>index c4e2e92..35345ac 100644
>>>>--- a/arch/powerpc/kernel/pci-common.c
>>>>+++ b/arch/powerpc/kernel/pci-common.c
>>>>@@ -128,6 +128,14 @@ resource_size_t pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
>>>>
>>>> 	return 0;
>>>> }
>>>>+
>>>>+resource_size_t pcibios_sriov_resource_alignment(struct pci_dev *pdev, int resno, resource_size_t align)
>>>>+{
>>>>+	if (ppc_md.__pci_sriov_resource_alignment)
>>>>+		return ppc_md.__pci_sriov_resource_alignment(pdev, resno, align);
>>>>+
>>>>+	return 0;
>>>>+}
>>>> #endif /* CONFIG_PCI_IOV */
>>>>
>>>> static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 7dfad6a..b0ac851 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -1573,6 +1573,22 @@ static resource_size_t __pnv_pci_sriov_resource_size(struct pci_dev *pdev, int r
>>>>
>>>> 	return size;
>>>> }
>>>>+
>>>>+static resource_size_t __pnv_pci_sriov_resource_alignment(struct pci_dev *pdev, int resno,
>>>>+		resource_size_t align)
>>>
>>>The function could be "pcibios_sriov_resource_alignment()", but it's not a big deal.
>>>If you prefer the original one, then keep it :)
>>
>>I guess you want to name it to pnv_pcibios_sriov_resource_alignment()?
>>pcibios_sriov_resource_alignment() is the general name for this function.
>>
>>If yes, this is changed.
>>
>
>Nope, What I mean is to have something like this:
>
>	struct machdep_calls {
>		:
>	#ifdef CONFIG_PCI_IOV
>	resource_size_t (*pci_sriov_resource_size)(struct pci_dev *dev,
>						   int resno);
>	resource_size_t (*pci_sriov_resource_alignment)(struct pci_dev *dev,
>							int resno,
>							resource_size_t align);
>	#endif
>		:
>	}
>
>	ppc_md.pci_sriov_resource_size = pnv_pci_iov_res_size;
>	ppc_md.pci_sriov_resource_alignment = pnv_pci_iov_res_alignment;
>
>The point is not to have prefix "__" for callbacks in "struct machdep_calls".
>ppc_md.__pci_sriov_resource_size is the first one that has prefix "__"

Yep, will change the name.

>
>>>
>>>>+{
>>>>+	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>>+	resource_size_t iov_align;
>>>>+
>>>>+	iov_align = resource_size(&pdev->resource[resno]);
>>>>+	if (iov_align)
>>>>+		return iov_align;
>>>>+
>>>>+	if (pdn->vfs)
>>>>+		return pdn->vfs * align;
>>>>+
>>>>+	return align;
>>>>+}
>>>> #endif /* CONFIG_PCI_IOV */
>>>>
>>>> /* Prevent enabling devices for which we couldn't properly
>>>>@@ -1777,6 +1793,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>> 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>>>> #ifdef CONFIG_PCI_IOV
>>>> 	ppc_md.__pci_sriov_resource_size = __pnv_pci_sriov_resource_size;
>>>>+	ppc_md.__pci_sriov_resource_alignment = __pnv_pci_sriov_resource_alignment;
>>>> #endif /* CONFIG_PCI_IOV */
>>>> 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>>>>
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me
