Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B82921A03C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 20:41:00 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 2 Nov 2015 15:10:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A019C3940049
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 15:10:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA29emHY19857568
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 15:10:49 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA29dkiJ007466
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 15:09:47 +0530
Date: Mon, 2 Nov 2015 17:39:44 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 10/12] powerpc/eeh: Support error recovery for VF PE
Message-ID: <20151102093944.GA7462@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-11-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632FE30.8040003@ozlabs.ru>
 <20151101015351.GA947@Richards-MBP.lan> <5636A2F4.70405@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5636A2F4.70405@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 02, 2015 at 10:40:36AM +1100, Alexey Kardashevskiy wrote:
>On 11/01/2015 12:53 PM, Wei Yang wrote:
>>On Fri, Oct 30, 2015 at 04:20:48PM +1100, Alexey Kardashevskiy wrote:
>>>On 10/26/2015 02:16 PM, Wei Yang wrote:
>>>>Different from PCI bus dependent PE, PE for VFs doesn't have the
>>>
>>>s/Different from/Unlike/
>>>
>>
>>Will change in next version.
>>
>>>
>>>>primary bus, on which the PCI hotplug is implemented. The patch
>>>>supports error recovery, especially the PCI hotplug for VF's PE.
>>>
>>>The patch adds support for error recovery of what exactly?
>>>What is "especially" about?
>>>
>>
>>PFs are enumerated on PCI bus, while VFs are created by PF's driver.
>>
>>In EEH recovery, it has two cases.
>>1. Device and driver is EEH aware, error handlers are called.
>>2. Device and driver is not EEH aware, un-plug the device and plug it again by
>>    enumerating it.
>>
>>The special thing happens on the second case. For a PF, we could use the
>>original pci core to enumerate the bus, while for VF, we need to record the VF
>>which are un-plugged then plug it again.
>
>
>Right. This should have been the actual commit log.
>
>
>>>
>>>>The hotplug on VF's PE is implemented based on VFs, instead of
>>>>PCI bus any more.
>>>
>>>Needs rephrase.
>>>
>>>Is this patch about EEH error recovery, i.e. unplug VF, re-plug VF? Why does
>>>the commit log talk about PE hotplug? I thought we do VF (i.e. PCI device)
>>>hotplug, not PE.
>>>
>>
>>Hmm... unlike the Bus PE for PFs, VF PE is dynamically created and released
>>when VFs are created and released.
>
>
>Sure. PEs are created/released, not plugged/unplugged (VFs are), that was my
>point.
>

Thanks for the suggestion, will change it in next version.

>
>>
>>>
>>>>
>>>>[gwshan: changelog and code refactoring]
>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>---
>>>>  arch/powerpc/include/asm/eeh.h   |   1 +
>>>>  arch/powerpc/kernel/eeh.c        |   8 ++++
>>>>  arch/powerpc/kernel/eeh_driver.c | 100 +++++++++++++++++++++++++++++++--------
>>>>  arch/powerpc/kernel/eeh_pe.c     |   3 +-
>>>>  4 files changed, 90 insertions(+), 22 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>>>index 331c856..ea1f13c4 100644
>>>>--- a/arch/powerpc/include/asm/eeh.h
>>>>+++ b/arch/powerpc/include/asm/eeh.h
>>>>@@ -142,6 +142,7 @@ struct eeh_dev {
>>>>  	struct pci_controller *phb;	/* Associated PHB		*/
>>>>  	struct pci_dn *pdn;		/* Associated PCI device node	*/
>>>>  	struct pci_dev *pdev;		/* Associated PCI device	*/
>>>>+	int    in_error;		/* Error flag for eeh_dev	*/
>>>
>>>Make it "bool".
>>>
>>
>>Will change it in next version.
>>
>>>
>>>>  	struct pci_dev *physfn;		/* Associated PF PORT		*/
>>>>  	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
>>>>  };
>>>>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>>>index af9b597..28e4d73 100644
>>>>--- a/arch/powerpc/kernel/eeh.c
>>>>+++ b/arch/powerpc/kernel/eeh.c
>>>>@@ -1227,6 +1227,14 @@ void eeh_remove_device(struct pci_dev *dev)
>>>>  	 * from the parent PE during the BAR resotre.
>>>>  	 */
>>>>  	edev->pdev = NULL;
>>>>+
>>>>+	/*
>>>>+	 * The flag "in_error" is used to trace EEH devices for VFs
>>>>+	 * in error state or not. It's set in eeh_report_error(). If
>>>>+	 * it's not set, eeh_report_{reset,resume}() won't be called
>>>>+	 * for the VF EEH device.
>>>>+	 */
>>>>+	edev->in_error = 0;
>>>>  	dev->dev.archdata.edev = NULL;
>>>>  	if (!(edev->pe->state & EEH_PE_KEEP))
>>>>  		eeh_rmv_from_parent_pe(edev);
>>>>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>>>>index 89eb4bc..99868e2 100644
>>>>--- a/arch/powerpc/kernel/eeh_driver.c
>>>>+++ b/arch/powerpc/kernel/eeh_driver.c
>>>>@@ -211,6 +211,7 @@ static void *eeh_report_error(void *data, void *userdata)
>>>>  	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
>>>>  	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
>>>>
>>>>+	edev->in_error = 1;
>>>>  	eeh_pcid_put(dev);
>>>>  	return NULL;
>>>>  }
>>>>@@ -282,7 +283,8 @@ static void *eeh_report_reset(void *data, void *userdata)
>>>>
>>>>  	if (!driver->err_handler ||
>>>>  	    !driver->err_handler->slot_reset ||
>>>>-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
>>>>+	    (edev->mode & EEH_DEV_NO_HANDLER) ||
>>>>+	    (!edev->in_error)) {
>>>>  		eeh_pcid_put(dev);
>>>>  		return NULL;
>>>>  	}
>>>>@@ -339,14 +341,16 @@ static void *eeh_report_resume(void *data, void *userdata)
>>>>
>>>
>>>bood was_in_error = edev->in_error;
>>>edev->in_error = false;
>>>
>>>then use was_in_error below and there is no need to replace return with goto,
>>>etc -> slightly simpler code.
>>>
>>
>>Will change it in next version.
>>
>>>
>>>>  	if (!driver->err_handler ||
>>>>  	    !driver->err_handler->resume ||
>>>>-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
>>>>+	    (edev->mode & EEH_DEV_NO_HANDLER) ||
>>>>+	    (!edev->in_error)) {
>>>>  		edev->mode &= ~EEH_DEV_NO_HANDLER;
>>>>-		eeh_pcid_put(dev);
>>>>-		return NULL;
>>>>+		goto out;
>>>>  	}
>>>>
>>>>  	driver->err_handler->resume(dev);
>>>>
>>>>+out:
>>>>+	edev->in_error = 0;
>>>>  	eeh_pcid_put(dev);
>>>>  	return NULL;
>>>>  }
>>>>@@ -386,12 +390,38 @@ static void *eeh_report_failure(void *data, void *userdata)
>>>>  	return NULL;
>>>>  }
>>>>
>>>>+static void *eeh_add_virt_device(void *data, void *userdata)
>>>>+{
>>>>+	struct pci_driver *driver;
>>>>+	struct eeh_dev *edev = (struct eeh_dev *)data;
>>>>+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>>>>+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>>>>+
>>>>+	if (!(edev->physfn)) {
>>>>+		pr_warn("%s: EEH dev %04x:%02x:%02x.%01x not for VF\n",
>>>>+			__func__, edev->phb->global_number, pdn->busno,
>>>>+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>>>>+		return NULL;
>>>>+	}
>>>>+
>>>>+	driver = eeh_pcid_get(dev);
>>>>+	if (driver) {
>>>>+		eeh_pcid_put(dev);
>>>>+		if (driver->err_handler)
>>>>+			return NULL;
>>>>+	}
>>>>+
>>>>+	pci_iov_virtfn_add(edev->physfn, pdn->vf_index, 0);
>>>>+	return NULL;
>>>>+}
>>>>+
>>>>  static void *eeh_rmv_device(void *data, void *userdata)
>>>>  {
>>>>  	struct pci_driver *driver;
>>>>  	struct eeh_dev *edev = (struct eeh_dev *)data;
>>>>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>>>>  	int *removed = (int *)userdata;
>>>>+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>>>>
>>>>  	/*
>>>>  	 * Actually, we should remove the PCI bridges as well.
>>>>@@ -416,7 +446,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
>>>>  	driver = eeh_pcid_get(dev);
>>>>  	if (driver) {
>>>>  		eeh_pcid_put(dev);
>>>>-		if (driver->err_handler)
>>>>+		if (removed && driver->err_handler)
>>>>  			return NULL;
>>>>  	}
>>>>
>>>>@@ -425,11 +455,23 @@ static void *eeh_rmv_device(void *data, void *userdata)
>>>>  		 pci_name(dev));
>>>>  	edev->bus = dev->bus;
>>>>  	edev->mode |= EEH_DEV_DISCONNECTED;
>>>>-	(*removed)++;
>>>>+	if (removed)
>>>>+		(*removed)++;
>>>>
>>>>-	pci_lock_rescan_remove();
>>>>-	pci_stop_and_remove_bus_device(dev);
>>>>-	pci_unlock_rescan_remove();
>>>>+	if (edev->physfn) {
>>>>+		pci_iov_virtfn_remove(edev->physfn, pdn->vf_index, 0);
>>>>+		edev->pdev = NULL;
>>>>+
>>>>+		/*
>>>>+		 * We have to set the VF PE number to invalid one, which is
>>>>+		 * required to plug the VF successfully.
>>>>+		 */
>>>>+		pdn->pe_number = IODA_INVALID_PE;
>>>>+	} else {
>>>>+		pci_lock_rescan_remove();
>>>>+		pci_stop_and_remove_bus_device(dev);
>>>>+		pci_unlock_rescan_remove();
>>>>+	}
>>>>
>>>>  	return NULL;
>>>>  }
>>>>@@ -548,6 +590,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>>>>  	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
>>>>  	struct timeval tstamp;
>>>>  	int cnt, rc, removed = 0;
>>>>+	struct eeh_dev *edev;
>>>>
>>>>  	/* pcibios will clear the counter; save the value */
>>>>  	cnt = pe->freeze_count;
>>>>@@ -561,12 +604,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>>>>  	 */
>>>>  	eeh_pe_state_mark(pe, EEH_PE_KEEP);
>>>>  	if (bus) {
>>>>-		pci_lock_rescan_remove();
>>>>-		pcibios_remove_pci_devices(bus);
>>>>-		pci_unlock_rescan_remove();
>>>>-	} else if (frozen_bus) {
>>>>+		if (pe->type & EEH_PE_VF)
>>>>+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
>>>
>>>
>>>I believe the rule is that if one branch of "if" uses curly braces, then the
>>>other should have them too.
>>>
>>
>>Thanks for reminding, will fix it in next version.
>
>
>I thought checkpatch.pl checks for it but apparently it does not.
>
>
>
>>>
>>>>+		else {
>>>>+			pci_lock_rescan_remove();
>>>>+			pcibios_remove_pci_devices(bus);
>>>>+			pci_unlock_rescan_remove();
>>>>+		}
>>>>+	} else if (frozen_bus)
>>>>  		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
>>>>-	}
>>>>
>>>>  	/*
>>>>  	 * Reset the pci controller. (Asserts RST#; resets config space).
>>>>@@ -607,14 +653,22 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>>>>  		 * PE. We should disconnect it so the binding can be
>>>>  		 * rebuilt when adding PCI devices.
>>>>  		 */
>>>>+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
>>>>  		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
>>>>-		pcibios_add_pci_devices(bus);
>>>>+		if (pe->type & EEH_PE_VF)
>>>
>>>Move "edev = list_first_entry(&pe->edevs, struct eeh_dev, list)" here. You
>>>could actually do:
>>>
>>>eeh_add_virt_device(list_first_entry(&pe->edevs, struct eeh_dev, list), NULL);
>>>
>>>and drop local variable @edev. Or move it to this scope. Dunno.
>>>
>>
>>Hmm... as I know, in eeh_pe_detach_dev() will remove the edev from pe's edevs
>>list.
>>
>>>
>>>>+			eeh_add_virt_device(edev, NULL);
>>>>+		else
>>>>+			pcibios_add_pci_devices(bus);
>>>>  	} else if (frozen_bus && removed) {
>>>>  		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
>>>>  		ssleep(5);
>>>>
>>>>+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
>>>>  		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
>>>>-		pcibios_add_pci_devices(frozen_bus);
>>>>+		if (pe->type & EEH_PE_VF)
>>>
>>>
>>>The same comment as above.
>>>
>>>>+			eeh_add_virt_device(edev, NULL);
>>>>+		else
>>>>+			pcibios_add_pci_devices(frozen_bus);
>>>>  	}
>>>>  	eeh_pe_state_clear(pe, EEH_PE_KEEP);
>>>>
>>>>@@ -792,11 +846,15 @@ perm_error:
>>>>  	 * the their PCI config any more.
>>>>  	 */
>>>>  	if (frozen_bus) {
>>>>-		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>>>>-
>>>>-		pci_lock_rescan_remove();
>>>>-		pcibios_remove_pci_devices(frozen_bus);
>>>>-		pci_unlock_rescan_remove();
>>>>+		if (pe->type & EEH_PE_VF) {
>>>>+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
>>>>+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>>>>+		} else {
>>>>+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>>>>+			pci_lock_rescan_remove();
>>>>+			pcibios_remove_pci_devices(frozen_bus);
>>>>+			pci_unlock_rescan_remove();
>>>>+		}
>>>>  	}
>>>>  }
>>>>
>>>>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>>>>index 260a701..5cde950 100644
>>>>--- a/arch/powerpc/kernel/eeh_pe.c
>>>>+++ b/arch/powerpc/kernel/eeh_pe.c
>>>>@@ -914,7 +914,8 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
>>>>  	if (pe->type & EEH_PE_PHB) {
>>>>  		bus = pe->phb->bus;
>>>>  	} else if (pe->type & EEH_PE_BUS ||
>>>>-		   pe->type & EEH_PE_DEVICE) {
>>>>+		   pe->type & EEH_PE_DEVICE ||
>>>>+		   pe->type & EEH_PE_VF) {
>>>>  		if (pe->bus) {
>>>>  			bus = pe->bus;
>>>>  			goto out;
>>>>
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
