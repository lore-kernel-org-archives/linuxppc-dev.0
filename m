Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1E171A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:53:54 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 12 May 2015 17:53:53 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7B4E82BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:53:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4C7regD31981624
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:53:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4C7rGHk009381
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:53:16 +1000
Date: Tue, 12 May 2015 15:52:58 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 5/9] powerpc/eeh: create EEH_PE_VF for VF PE
Message-ID: <20150512075258.GB16788@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150511023707.GA8816@gwshan> <20150511062549.GB1632@richard>
 <20150512062823.GB18734@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150512062823.GB18734@gwshan>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 04:28:23PM +1000, Gavin Shan wrote:
>On Mon, May 11, 2015 at 02:25:49PM +0800, Wei Yang wrote:
>>On Mon, May 11, 2015 at 12:37:07PM +1000, Gavin Shan wrote:
>>>On Mon, May 04, 2015 at 03:07:34PM +0800, Wei Yang wrote:
>>>
>>>Please reorder PATCH[6] with this one because the EEH device is expected
>>>to be created before EEH PE.
>>
>>That's a good idea.
>>
>>>
>>>>On powernv platform, VF PE is a special PE which is different from the Bus
>>>>PE.  On the EEH side, it needs a corresponding concept to handle the VF PE
>>>>properly. For example, we need to create VF PE when VF's pci_dev is
>>>>initialized in kernel. And add a flag to mark it is a VF PF.
>>>                                                       ^^^^^
>>>>
>>>
>>>>From above commit log, my understanding is that you're adding a flag to
>>>identify VF PE, which is handled differently from bus PE. You missed the
>>>details on the difference between them and the speical treament to VF PE.
>>>Could you help add those information in the commit log to make it looks
>>>complete?
>>>
>>
>>This patch just introduce the VF PE. For those differences, we have another
>>patch "handle VF PE properly" to cover. In the log of that patch, I listed
>>those differences. Do you think this is fine?
>>
>
>It's fine to me.
>
>>>>This patch introduces the EEH_PE_VF type for VF PE and creates it for a VF.
>>>>At the mean time, it creates the sysfs and address cache for VF PE.
>>>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>>                   it creates the sysfs and address cache for VF PE at PCI
>>>device final fixup time.
>>>
>>>>
>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>---
>>>> arch/powerpc/include/asm/eeh.h               |    1 +
>>>> arch/powerpc/kernel/eeh_pe.c                 |   12 ++++++++++--
>>>> arch/powerpc/platforms/powernv/eeh-powernv.c |   12 ++++++++++++
>>>> 3 files changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>>>index a52db28..56e8cd9 100644
>>>>--- a/arch/powerpc/include/asm/eeh.h
>>>>+++ b/arch/powerpc/include/asm/eeh.h
>>>>@@ -70,6 +70,7 @@ struct pci_dn;
>>>> #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
>>>> #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
>>>> #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
>>>>+#define EEH_PE_VF	(1 << 4)	/* VF PE     */
>>>>
>>>> #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
>>>> #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
>>>>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>>>>index 35f0b62..edfe63a 100644
>>>>--- a/arch/powerpc/kernel/eeh_pe.c
>>>>+++ b/arch/powerpc/kernel/eeh_pe.c
>>>>@@ -299,7 +299,12 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>>>> 	 * EEH device already having associated PE, but
>>>> 	 * the direct parent EEH device doesn't have yet.
>>>> 	 */
>>>>-	pdn = pdn ? pdn->parent : NULL;
>>>>+#ifdef CONFIG_PCI_IOV
>>>>+	if (edev->mode & EEH_DEV_VF)
>>>>+		pdn = pci_get_pdn(edev->physfn);
>>>>+	else
>>>>+#endif
>>>>+		pdn = pdn ? pdn->parent : NULL;
>>>
>>>[A]
>>>
>>>> 	while (pdn) {
>>>> 		/* We're poking out of PCI territory */
>>>> 		parent = pdn_to_eeh_dev(pdn);
>>>>@@ -382,7 +387,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>>>> 	}
>>>>
>>>> 	/* Create a new EEH PE */
>>>>-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>>>>+	if (edev->mode & EEH_DEV_VF)
>>>>+		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
>>>>+	else
>>>>+		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>>>
>>>You don't have CONFIG_PCI_IOV here to protect the code, but you had
>>>that at [A]. In order to keep the code look consistent, you either
>>>add it or remove it for all places. I prefer to remove it, which
>>>we don't need CONFIG_PCI_IOV.
>>>
>>
>>Ok, that's fine to remove it.
>>
>>BTW, if remove the CONFIG_PCI_IOV, we need to remove it around the physfn in
>>eeh_dev definition. That's fine?
>>
>
>It's fine to me.
>
>>>> 	if (!pe) {
>>>> 		pr_err("%s: out of memory!\n", __func__);
>>>> 		return -ENOMEM;
>>>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>>index 622f08c..5447481 100644
>>>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>>@@ -1540,3 +1540,15 @@ static int __init eeh_powernv_init(void)
>>>> 	return ret;
>>>> }
>>>> machine_early_initcall(powernv, eeh_powernv_init);
>>>>+
>>>>+#ifdef CONFIG_PCI_IOV
>>>>+static void pnv_pci_fixup_vf_eeh(struct pci_dev *pdev)
>>>>+{
>>>
>>>Please rename it to pnv_eeh_vf_final_fixup(). Names of all functions
>>>in this file expect prefix "pnv_eeh_". With "_final_", it's clearly
>>>to tell it's called on PCI device final fixup time.
>>>
>>
>>ok
>>
>>>>+	/* sysfs files should only be added after devices are added */
>>>
>>>It's nice to explain why here: sysfs for the PCI device isn't populated
>>>and the MMIO resource isn't finalized for the PCI device yet.
>>>
>>
>>Don't get your point.
>>
>>sysfs of the PCI device is populated at this point.
>>
>
>You have two operations here: (A) add the PCI device to EEH address cache;
>(B) add EEH related sysfs entries. (A) requires that the resources (MMIO
>on PHB3) of the VF is finalized. (B) requires VF's sysfs entries have been
>populated. So you need two conditions here to make sure (A) and (B) work
>correctly: sysfs files are created and MMIO resources are populated. I was
>saying your comments is a bit confusing. Could you have something like this:
>
>       /*
>        * The following operations will fail if VF's sysfs files aren't
>        * created or its resources aren't finalized.
>        */ 
>

Will change the comment with this.
