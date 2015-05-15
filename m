Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A49731A2C15
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:58:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 15 May 2015 15:58:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 80C3C2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:58:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F5w0C940763610
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:58:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F5vZ5p011691
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:57:36 +1000
Date: Fri, 15 May 2015 15:57:10 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 02/11] powerpc/pci_dn: cache vf_index in pci_dn
Message-ID: <20150515055710.GB27029@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431668786-30371-3-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 15, 2015 at 01:46:17PM +0800, Wei Yang wrote:
>The patch caches the VF index in pci_dn, which can be used to calculate
>VF's bus, device and function number. Those information helps to locate
>the VF's PCI device instance when doing hotplug during EEH recovery if
>necessary.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin


>---
> arch/powerpc/include/asm/pci-bridge.h |    1 +
> arch/powerpc/kernel/pci_dn.c          |    4 +++-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>index 1811c44..d78afe4 100644
>--- a/arch/powerpc/include/asm/pci-bridge.h
>+++ b/arch/powerpc/include/asm/pci-bridge.h
>@@ -199,6 +199,7 @@ struct pci_dn {
> #ifdef CONFIG_PCI_IOV
> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
> 	u16     num_vfs;		/* number of VFs enabled*/
>+	int     vf_index;		/* VF index in the PF */
> 	int     offset;			/* PE# for the first VF PE */
> #define M64_PER_IOV 4
> 	int     m64_per_iov;
>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>index b3b4df9..f771130 100644
>--- a/arch/powerpc/kernel/pci_dn.c
>+++ b/arch/powerpc/kernel/pci_dn.c
>@@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
> #ifdef CONFIG_PCI_IOV
> static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
> 					   struct pci_dev *pdev,
>+					   int vf_index,
> 					   int busno, int devfn)
> {
> 	struct pci_dn *pdn;
>@@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
> 	pdn->parent = parent;
> 	pdn->busno = busno;
> 	pdn->devfn = devfn;
>+	pdn->vf_index = vf_index;
> #ifdef CONFIG_PPC_POWERNV
> 	pdn->pe_number = IODA_INVALID_PE;
> #endif
>@@ -196,7 +198,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
> 		return NULL;
>
> 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>-		pdn = add_one_dev_pci_data(parent, NULL,
>+		pdn = add_one_dev_pci_data(parent, NULL, i,
> 					   pci_iov_virtfn_bus(pdev, i),
> 					   pci_iov_virtfn_devfn(pdev, i));
> 		if (!pdn) {
>-- 
>1.7.9.5
>
