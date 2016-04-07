Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgPBx5N3MzDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 10:50:17 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 10:50:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EE18D2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 10:50:05 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u370nqk3065926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 10:50:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u370nSok006387
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 10:49:28 +1000
Date: Thu, 7 Apr 2016 10:48:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2 v2] powerpc/iommu: Remove the dependency on EEH
 struct in DDW mechanism
Message-ID: <20160407004833.GB16777@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459988405-13991-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1459988405-13991-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459988405-13991-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2016 at 09:20:05PM -0300, Guilherme G. Piccoli wrote:
>Commit 39baadbf36ce ("powerpc/eeh: Remove eeh information from pci_dn")
>changed the pci_dn struct by removing its EEH-related members.
>As part of this clean-up, DDW mechanism was modified to read the device
>configuration address from eeh_dev struct.
>
>As a consequence, now if we disable EEH mechanism on kernel command-line
>for example, the DDW mechanism will fail, generating a kernel oops by
>dereferencing a NULL pointer (which turns to be the eeh_dev pointer).
>
>This patch just changes the configuration address calculation on DDW
>functions to a manual calculation based on pci_dn members instead of
>using eeh_dev-based address.
>
>No functional changes were made. This was tested on pSeries, both
>in PHyp and qemu guest.
>
>Fixes: 39baadbf36ce ("powerpc/eeh: Remove eeh information from pci_dn")
>Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks, Guilherme. Please make sure if it needs to be backported
to stable kernel. I assume it probably needs to be in 3.10+. 

>---
> arch/powerpc/platforms/pseries/iommu.c | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>index bd98ce2..3db2cea 100644
>--- a/arch/powerpc/platforms/pseries/iommu.c
>+++ b/arch/powerpc/platforms/pseries/iommu.c
>@@ -912,7 +912,8 @@ machine_arch_initcall(pseries, find_existing_ddw_windows);
> static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> 			struct ddw_query_response *query)
> {
>-	struct eeh_dev *edev;
>+	struct device_node *dn;
>+	struct pci_dn *pdn;
> 	u32 cfg_addr;
> 	u64 buid;
> 	int ret;
>@@ -923,11 +924,10 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> 	 * Retrieve them from the pci device, not the node with the
> 	 * dma-window property
> 	 */
>-	edev = pci_dev_to_eeh_dev(dev);
>-	cfg_addr = edev->config_addr;
>-	if (edev->pe_config_addr)
>-		cfg_addr = edev->pe_config_addr;
>-	buid = edev->phb->buid;
>+	dn = pci_device_to_OF_node(dev);
>+	pdn = PCI_DN(dn);
>+	cfg_addr = (pdn->busno << 8) | (pdn->devfn);
>+	buid = pdn->phb->buid;

No parentheses required on the second operand when getting @cfg_addr.
It would be nicer to initialize @buid and then @cfg_addr. When
developers look at the code, they usually check @buid and then
@cfg_addr.

>
> 	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
> 		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
>@@ -941,7 +941,8 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> 			struct ddw_create_response *create, int page_shift,
> 			int window_shift)
> {
>-	struct eeh_dev *edev;
>+	struct device_node *dn;
>+	struct pci_dn *pdn;
> 	u32 cfg_addr;
> 	u64 buid;
> 	int ret;
>@@ -952,11 +953,10 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> 	 * Retrieve them from the pci device, not the node with the
> 	 * dma-window property
> 	 */
>-	edev = pci_dev_to_eeh_dev(dev);
>-	cfg_addr = edev->config_addr;
>-	if (edev->pe_config_addr)
>-		cfg_addr = edev->pe_config_addr;
>-	buid = edev->phb->buid;
>+	dn = pci_device_to_OF_node(dev);
>+	pdn = PCI_DN(dn);
>+	cfg_addr = (pdn->busno << 8) | (pdn->devfn);
>+	buid = pdn->phb->buid;

Same comment as above.

Thanks,
Gavin
>
> 	do {
> 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
>-- 
>2.1.0
>
