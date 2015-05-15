Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C1311A05F5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 16:27:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 15 May 2015 16:27:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 131CD2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 16:27:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F6Ra3M40697912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 16:27:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F6RBJu027749
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 16:27:12 +1000
Date: Fri, 15 May 2015 16:26:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 06/11] powerpc/eeh: create EEH_PE_VF for VF PE
Message-ID: <20150515062646.GA31660@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431668786-30371-7-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Fri, May 15, 2015 at 01:46:21PM +0800, Wei Yang wrote:
>On powernv platform, VF PE is a special PE which is different from the Bus
>PE.  On the EEH side, it needs a corresponding concept to handle the VF PE
>properly. For example, we need to create VF PE when VF's pci_dev is
>initialized in kernel. And add a flag to mark it is a VF PE.
>
>This patch introduces the EEH_PE_VF type for VF PE and creates it for a VF.
>At the mean time, it creates the sysfs and address cache for VF PE at PCI
>device final fixup time.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

With one thing fixed as below.

>---
> arch/powerpc/include/asm/eeh.h               |    1 +
> arch/powerpc/kernel/eeh_pe.c                 |   10 ++++++++--
> arch/powerpc/platforms/powernv/eeh-powernv.c |   14 ++++++++++++++
> 3 files changed, 23 insertions(+), 2 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>index 1b3614d..c1fde48 100644
>--- a/arch/powerpc/include/asm/eeh.h
>+++ b/arch/powerpc/include/asm/eeh.h
>@@ -70,6 +70,7 @@ struct pci_dn;
> #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
> #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
> #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
>+#define EEH_PE_VF	(1 << 4)	/* VF PE     */
>
> #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
> #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index 35f0b62..260a701 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
> 	 * EEH device already having associated PE, but
> 	 * the direct parent EEH device doesn't have yet.
> 	 */
>-	pdn = pdn ? pdn->parent : NULL;
>+	if (edev->physfn)
>+		pdn = pci_get_pdn(edev->physfn);
>+	else
>+		pdn = pdn ? pdn->parent : NULL;
> 	while (pdn) {
> 		/* We're poking out of PCI territory */
> 		parent = pdn_to_eeh_dev(pdn);
>@@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
> 	}
>
> 	/* Create a new EEH PE */
>-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>+	if (edev->physfn)
>+		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
>+	else
>+		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
> 	if (!pe) {
> 		pr_err("%s: out of memory!\n", __func__);
> 		return -ENOMEM;
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index 622f08c..31344a4 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -1540,3 +1540,17 @@ static int __init eeh_powernv_init(void)
> 	return ret;
> }
> machine_early_initcall(powernv, eeh_powernv_init);
>+
>+static void pnv_eeh_vf_final_fixup(struct pci_dev *pdev)
>+{
>+	/*
>+	 * The following operations will fail if VF's sysfs files aren't
>+	 * created or its resources aren't finalized.
>+	 */
>+	if (!pdev->is_virtfn)
>+		return;
>+
>+	eeh_add_device_late(pdev);
>+	eeh_sysfs_add_device(pdev);

It's worthy to have following code to make the logic here complete. Otherwise,
we will run into problem quickly once the eeh_add_device_{early,late}() get
changed in eeh.c:

	eeh_add_device_early(pdn);
	eeh_add_device_late(pdev);
	eeh_sysfs_add_device(pdev);

Thanks,
Gavin

>+}
>+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_eeh_vf_final_fixup);
>-- 
>1.7.9.5
>
