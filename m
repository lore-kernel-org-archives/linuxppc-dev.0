Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A4D81A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:54:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 15 May 2015 18:54:23 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B1D522BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:54:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F8sD2e26738820
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:54:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F8rmwv009393
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:53:49 +1000
Date: Fri, 15 May 2015 16:53:30 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 05/11] powerpc/powernv: create/release eeh_dev for VF
Message-ID: <20150515085330.GA26681@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150515061916.GA29805@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150515061916.GA29805@gwshan>
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

On Fri, May 15, 2015 at 04:19:16PM +1000, Gavin Shan wrote:
>On Fri, May 15, 2015 at 01:46:20PM +0800, Wei Yang wrote:
>>EEH on powerpc platform needs eeh_dev structure to track the PCI device
>>status. Since VFs are created/released dynamically, VF's eeh_dev is also
>>dynamically created/released in system.
>>
>>This patch creates/removes eeh_dev when pci_dn is created/removed for VFs,
>>and marks it with EEH_DEV_VF type.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>After removing the unnecessary line of code as below.
>
>>---
>> arch/powerpc/include/asm/eeh.h |    1 +
>> arch/powerpc/kernel/eeh.c      |    4 ++++
>> arch/powerpc/kernel/pci_dn.c   |   11 +++++++++++
>> 3 files changed, 16 insertions(+)
>>
>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>index a52db28..1b3614d 100644
>>--- a/arch/powerpc/include/asm/eeh.h
>>+++ b/arch/powerpc/include/asm/eeh.h
>>@@ -138,6 +138,7 @@ struct eeh_dev {
>> 	struct pci_controller *phb;	/* Associated PHB		*/
>> 	struct pci_dn *pdn;		/* Associated PCI device node	*/
>> 	struct pci_dev *pdev;		/* Associated PCI device	*/
>>+	struct pci_dev *physfn;		/* Associated PF PORT		*/
>> 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
>> };
>>
>>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>index 6c7ce1b..221e280 100644
>>--- a/arch/powerpc/kernel/eeh.c
>>+++ b/arch/powerpc/kernel/eeh.c
>>@@ -1135,6 +1135,10 @@ void eeh_add_device_late(struct pci_dev *dev)
>> 	}
>>
>> 	edev->pdev = dev;
>>+#ifdef CONFIG_PCI_IOV
>>+	if (dev->is_virtfn)
>>+		edev->physfn = dev->physfn;
>>+#endif
>> 	dev->dev.archdata.edev = edev;
>>
>> 	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
>>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>index f771130..94806a4 100644
>>--- a/arch/powerpc/kernel/pci_dn.c
>>+++ b/arch/powerpc/kernel/pci_dn.c
>>@@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>> struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>> {
>> #ifdef CONFIG_PCI_IOV
>>+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>> 	struct pci_dn *parent, *pdn;
>>+	struct eeh_dev *edev;
>> 	int i;
>>
>> 	/* Only support IOV for now */
>>@@ -206,6 +208,8 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>> 				 __func__, i);
>> 			return NULL;
>> 		}
>>+		eeh_dev_init(pdn, hose);
>>+		edev = pdn_to_eeh_dev(pdn);
>
>Nothing is done to edev after getting it. So I think the last line of changes
>here isn't needed. Could you check and remove it if I'm correct?

You are right, removed.

>
>Thanks,
>Gavin
>
>> 	}
>> #endif /* CONFIG_PCI_IOV */
>>
>>@@ -254,10 +258,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
>> 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>> 		list_for_each_entry_safe(pdn, tmp,
>> 			&parent->child_list, list) {
>>+			struct eeh_dev *edev;
>> 			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
>> 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
>> 				continue;
>>
>>+			edev = pdn_to_eeh_dev(pdn);
>>+			if (edev) {
>>+				pdn->edev = NULL;
>>+				kfree(edev);
>>+			}
>>+
>> 			if (!list_empty(&pdn->list))
>> 				list_del(&pdn->list);
>>
>>-- 
>>1.7.9.5
>>

-- 
Richard Yang
Help you, Help me
