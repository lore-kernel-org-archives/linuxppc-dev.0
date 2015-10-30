Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA60E1A0386
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:53:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 16:53:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7EB982CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:53:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9U6raJU1769870
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:53:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9U6rBoB012741
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:53:12 +1100
Date: Fri, 30 Oct 2015 14:52:46 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 06/12] powerpc/powernv: EEH device for VF
Message-ID: <20151030065246.GC5940@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632E51D.30805@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5632E51D.30805@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2015 at 02:33:49PM +1100, Alexey Kardashevskiy wrote:
>On 10/26/2015 02:15 PM, Wei Yang wrote:
>>VFs and their corresponding pci_dn instances are created and released
>>dynamically as their PF's SRIOV capability is enabled and disabled.
>>The patch creates and releases EEH devices for VFs when creating and
>>releasing their pci_dn instances, which means EEH devices and pci_dn
>>instances have same life cycle. Also, VF's EEH device is identified
>>by (struct eeh_dev::physfn).
>
>
>The add_dev_pci_data() helper (the one you hack) does not create pci_dn
>instances. The add_one_dev_pci_data() helper does.
>

Yes, you are right. The patch here create edev after the pci_dn is created.

So which part in the log you think is not accurate?

>
>>
>>[gwshan: changelog and removed CONFIG_PCI_IOV]
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/include/asm/eeh.h |  1 +
>>  arch/powerpc/kernel/pci_dn.c   | 12 ++++++++++++
>>  2 files changed, 13 insertions(+)
>>
>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>index c5eb86f..6c383ad 100644
>>--- a/arch/powerpc/include/asm/eeh.h
>>+++ b/arch/powerpc/include/asm/eeh.h
>>@@ -140,6 +140,7 @@ struct eeh_dev {
>>  	struct pci_controller *phb;	/* Associated PHB		*/
>>  	struct pci_dn *pdn;		/* Associated PCI device node	*/
>>  	struct pci_dev *pdev;		/* Associated PCI device	*/
>>+	struct pci_dev *physfn;		/* Associated PF PORT		*/
>>  	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
>>  };
>>
>>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>index f771130..f0ddde7 100644
>>--- a/arch/powerpc/kernel/pci_dn.c
>>+++ b/arch/powerpc/kernel/pci_dn.c
>>@@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>  struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>  {
>>  #ifdef CONFIG_PCI_IOV
>>+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>>  	struct pci_dn *parent, *pdn;
>>+	struct eeh_dev *edev;
>>  	int i;
>>
>>  	/* Only support IOV for now */
>>@@ -206,6 +208,9 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>  				 __func__, i);
>>  			return NULL;
>>  		}
>>+		eeh_dev_init(pdn, hose);
>>+		edev = pdn_to_eeh_dev(pdn);
>
>
>In theory, pdn_to_eeh_dev() can return NULL. In this patch, it is not clear
>if pdn->edev gets initialized before or after add_dev_pci_data().
>

Yep, the return value should be checked.

pdn->edev is initialized in eeh_dev_init() which is called in
add_dev_pci_data(). The order is not clear?

>
>
>>+		edev->physfn = pdev;
>>  	}
>>  #endif /* CONFIG_PCI_IOV */
>>
>>@@ -254,10 +259,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
>>  	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>>  		list_for_each_entry_safe(pdn, tmp,
>>  			&parent->child_list, list) {
>>+			struct eeh_dev *edev;
>>  			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
>>  			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
>>  				continue;
>>
>>+			edev = pdn_to_eeh_dev(pdn);
>>+			if (edev) {
>>+				pdn->edev = NULL;
>>+				kfree(edev);
>>+			}
>>+
>>  			if (!list_empty(&pdn->list))
>>  				list_del(&pdn->list);
>>
>>
>
>
>-- 
>Alexey
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
