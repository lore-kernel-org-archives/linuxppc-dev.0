Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A70301A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 11:17:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 13 May 2015 11:17:30 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2356D2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 11:17:28 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4D1HJn219529772
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 11:17:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4D1Gtli031503
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 11:16:55 +1000
Date: Wed, 13 May 2015 11:16:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 9/9] powerpc/eeh: handle VF PE properly
Message-ID: <20150513011630.GA8973@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-10-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430723258-21299-10-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Mon, May 04, 2015 at 03:07:38PM +0800, Wei Yang wrote:
>Compared with Bus PE, VF PE just has one single pci function. This
                                                 ^^^
>introduces the difference of error handling on a VF PE.
>

Lets have simple example to make the discussion easy: Suppose that one
particular PF has only one IOV BAR and we're going to enable 8 VFs. Also
the VF BAR size exceeds 64MB. For this case, we're going to have 2 VF
groups, which have 4 VFs. First of all, there are 8 PE numbers consumed
in total and lets say they're PE#(x) ... PE#(x+7).

For above case, the M64 runs in "single" mode. In other word, we just
need two M64 BARs here and they're owned by PE#x and PE#(x+1) separately.
Equally speaking, the relationship between PE# and VF index becomes as
below from MMIO's view: PE#x (VF#0/1/2/3), PE#x(VF#4/5/6/7). However,
this mapping isn't updated to PELTM. On the other hand, each VF has
separate PE# number as we update to PELTM. Lastly, we have to chain
PE#x/+1/+2/+3 and PE#x+4/5/6/7 because the VF group is sharing M64
resources. Hopefully, I didn't miss anything.

If above description is complete, I think you need expose VF (PE) group
to EEH. Potentially, I guess you need improve it later for VFIO so that
it can pass VF (PE) group to *same* guest. Generally speaking, the VF (PE)
group should be visible to EEH as single PE, which is similar to what I
did for "huge BAR" support where we have master/slave PE. The master PE
is exposed to EEH while the slave PEs are invisible from EEH. However,
the situation for VF (PE) group is different, but not too much: the
slave PEs (PE#x+1/2/3, PE#x+5/6/7 in this case) do contain PCI device.
So think you can something as below if you can't figure out better
solution:

- When the PE group is finalized in pcibios_fixup_sriov_enable(), you
  mark the master/slave PE accordingly, and put the slave PE to the
  master PE's slave list.
- When doing EEH probe on VF's edev, detach it to EEH with master PE#.

With above mechanism, each VF PE can potentially have multiple EEH devices,
not one single PCI function as you said in the commit log, which needs to
be changed accordingly.

>For example in the hotplug case, EEH needs to remove and re-create the VF
>properly. In the case when PF's error_detected() disable SRIOV, this patch
>introduces a flag to mark the eeh_dev of a VF to avoid the slot_reset() and
>resume(). Since the FW is not ware of the VF, this patch handles the VF
>restore/reset in kernel directly.
>
>This patch is to handle the VF PE properly in these cases.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/include/asm/eeh.h   |    1 +
> arch/powerpc/kernel/eeh.c        |    1 +
> arch/powerpc/kernel/eeh_driver.c |  108 ++++++++++++++++++++++++++++++--------
> arch/powerpc/kernel/eeh_pe.c     |    3 +-
> 4 files changed, 90 insertions(+), 23 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>index 78c8bec..43e8a24 100644
>--- a/arch/powerpc/include/asm/eeh.h
>+++ b/arch/powerpc/include/asm/eeh.h
>@@ -141,6 +141,7 @@ struct eeh_dev {
> 	struct pci_controller *phb;	/* Associated PHB		*/
> 	struct pci_dn *pdn;		/* Associated PCI device node	*/
> 	struct pci_dev *pdev;		/* Associated PCI device	*/
>+	int    in_error;		/* Error flag for eeh_dev	*/

Begining from "v2" (maybe I'm wrong about the revision), I suggested to
remove "in_error" because we already had similar flag EEH_DEV_NO_HANDLER.
I don't think it's different to merge them and I already told how to do
that. If you still find it's difficult to do it, I'm fine to keep it and
I'll fix it up later by myself.

> #ifdef CONFIG_PCI_IOV
> 	struct pci_dev *physfn;		/* Associated PF PORT		*/
> #endif /* CONFIG_PCI_IOV */
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 221e280..077c3d1 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -1226,6 +1226,7 @@ void eeh_remove_device(struct pci_dev *dev)
> 	 * from the parent PE during the BAR resotre.
> 	 */
> 	edev->pdev = NULL;
>+	edev->in_error = 0;
> 	dev->dev.archdata.edev = NULL;
> 	if (!(edev->pe->state & EEH_PE_KEEP))
> 		eeh_rmv_from_parent_pe(edev);
>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>index 89eb4bc..6e42cad 100644
>--- a/arch/powerpc/kernel/eeh_driver.c
>+++ b/arch/powerpc/kernel/eeh_driver.c
>@@ -211,6 +211,7 @@ static void *eeh_report_error(void *data, void *userdata)
> 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
>
>+	edev->in_error = 1;
> 	eeh_pcid_put(dev);
> 	return NULL;
> }
>@@ -282,7 +283,8 @@ static void *eeh_report_reset(void *data, void *userdata)
>
> 	if (!driver->err_handler ||
> 	    !driver->err_handler->slot_reset ||
>-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
>+	    (edev->mode & EEH_DEV_NO_HANDLER) ||
>+	    (!edev->in_error)) {
> 		eeh_pcid_put(dev);
> 		return NULL;
> 	}
>@@ -339,14 +341,16 @@ static void *eeh_report_resume(void *data, void *userdata)
>
> 	if (!driver->err_handler ||
> 	    !driver->err_handler->resume ||
>-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
>+	    (edev->mode & EEH_DEV_NO_HANDLER) ||
>+	    (!edev->in_error)) {
> 		edev->mode &= ~EEH_DEV_NO_HANDLER;
>-		eeh_pcid_put(dev);
>-		return NULL;
>+		goto out;
> 	}
>
> 	driver->err_handler->resume(dev);
>
>+out:
>+	edev->in_error = 0;
> 	eeh_pcid_put(dev);
> 	return NULL;
> }
>@@ -386,12 +390,42 @@ static void *eeh_report_failure(void *data, void *userdata)
> 	return NULL;
> }
>
>+#ifdef CONFIG_PCI_IOV
>+static void *eeh_add_virt_device(void *data, void *userdata)
>+{
>+	struct pci_driver *driver;
>+	struct eeh_dev *edev = (struct eeh_dev *)data;
>+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>+
>+	if (!(edev->mode & EEH_DEV_VF)) {
>+		pr_warn("EEH: eeh_dev(%04x:%02x:%02x:%01x) is not a VF\n",
>+			edev->phb->global_number, pdn->busno,
>+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>+		return NULL;
>+	}

Please don't use logs starting with "EEH:" arbitrarily. It's assumed
for principle EEH logs. This one isn't a major one and print the function
name helps for debugging:

	if (!edev->physfn) {
		pr_warn("%s: EEH dev %04x:%02x:%02x:%01x not for VF\n",
			edev->phb->global_number, pdn->busno,
			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
		return NULL;
	}

>+
>+	driver = eeh_pcid_get(dev);
>+	if (driver) {
>+		eeh_pcid_put(dev);
>+		if (driver->err_handler)
>+			return NULL;
>+	}

dev and driver are NULL for those VFs that have been unplugged. For those
VFs weren't unplugged, driver and err_handler should be valid. The code
looks correct. However, for consistence, please use EEH_DEV_DISCONNECTED
that has been marked to those EEH devices which were unplugged. Do you
think it would be better?

	if (!(dev->flags & EEH_DEV_DISCONNECTED))
		return NULL;

>+
>+	pci_iov_virtfn_add(edev->physfn, pdn->vf_index, 0);
>+	return NULL;
>+}

>+#endif /* CONFIG_PCI_IOV */
>+
> static void *eeh_rmv_device(void *data, void *userdata)
> {
> 	struct pci_driver *driver;
> 	struct eeh_dev *edev = (struct eeh_dev *)data;
> 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
> 	int *removed = (int *)userdata;
>+#ifdef CONFIG_PCI_IOV
>+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>+#endif

You don't have to have CONFIG_PCI_IOV here. I guess you probably remove
all CONFIG_PCI_IOV checks because the flag or conditions introduced
to edev/PE can tell they're VF sensitive or not.

>
> 	/*
> 	 * Actually, we should remove the PCI bridges as well.
>@@ -416,7 +450,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
> 	driver = eeh_pcid_get(dev);
> 	if (driver) {
> 		eeh_pcid_put(dev);
>-		if (driver->err_handler)
>+		if (removed && driver->err_handler)
> 			return NULL;
> 	}
>
>@@ -425,11 +459,21 @@ static void *eeh_rmv_device(void *data, void *userdata)
> 		 pci_name(dev));
> 	edev->bus = dev->bus;
> 	edev->mode |= EEH_DEV_DISCONNECTED;
>-	(*removed)++;
>-
>-	pci_lock_rescan_remove();
>-	pci_stop_and_remove_bus_device(dev);
>-	pci_unlock_rescan_remove();
>+	if (removed)
>+		(*removed)++;
>+
>+#ifdef CONFIG_PCI_IOV
>+	if (edev->mode & EEH_DEV_VF) {
>+		pci_iov_virtfn_remove(edev->physfn, pdn->vf_index, 0);
>+		edev->pdev = NULL;
>+		pdn->pe_number = IODA_INVALID_PE;

Setting the PE number to invalid one seems not correct because the PE
is still consumed by the VF's RID.

>+	} else
>+#endif

You can remove this CONFIG_PCI_IOV here since you already had EEH_DEV_VF
or "edev->physfn" as I said previously.

>+	{
>+		pci_lock_rescan_remove();
>+		pci_stop_and_remove_bus_device(dev);
>+		pci_unlock_rescan_remove();
>+	}
>
> 	return NULL;
> }
>@@ -548,6 +592,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
> 	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
> 	struct timeval tstamp;
> 	int cnt, rc, removed = 0;
>+	struct eeh_dev *edev;
>
> 	/* pcibios will clear the counter; save the value */
> 	cnt = pe->freeze_count;
>@@ -561,12 +606,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
> 	 */
> 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
> 	if (bus) {
>-		pci_lock_rescan_remove();
>-		pcibios_remove_pci_devices(bus);
>-		pci_unlock_rescan_remove();
>-	} else if (frozen_bus) {
>+		if (pe->type & EEH_PE_VF)
>+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
>+		else {
>+			pci_lock_rescan_remove();
>+			pcibios_remove_pci_devices(bus);
>+			pci_unlock_rescan_remove();
>+		}
>+	} else if (frozen_bus)
> 		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
>-	}
>
> 	/*
> 	 * Reset the pci controller. (Asserts RST#; resets config space).
>@@ -607,14 +655,26 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
> 		 * PE. We should disconnect it so the binding can be
> 		 * rebuilt when adding PCI devices.
> 		 */
>+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);

As above, VF PE can have multiple EEH devices.

> 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
>-		pcibios_add_pci_devices(bus);
>+#ifdef CONFIG_PCI_IOV
>+		if (pe->type & EEH_PE_VF)
>+			eeh_add_virt_device(edev, NULL);
>+		else
>+#endif
>+			pcibios_add_pci_devices(bus);
> 	} else if (frozen_bus && removed) {
> 		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
> 		ssleep(5);
>
>+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
> 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
>-		pcibios_add_pci_devices(frozen_bus);
>+#ifdef CONFIG_PCI_IOV
>+		if (pe->type & EEH_PE_VF)
>+			eeh_add_virt_device(edev, NULL);
>+		else
>+#endif
>+			pcibios_add_pci_devices(frozen_bus);
> 	}
> 	eeh_pe_state_clear(pe, EEH_PE_KEEP);
>
>@@ -792,11 +852,15 @@ perm_error:
> 	 * the their PCI config any more.
> 	 */
> 	if (frozen_bus) {
>-		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>-
>-		pci_lock_rescan_remove();
>-		pcibios_remove_pci_devices(frozen_bus);
>-		pci_unlock_rescan_remove();
>+		if (pe->type & EEH_PE_VF) {
>+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
>+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>+		} else {
>+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>+			pci_lock_rescan_remove();
>+			pcibios_remove_pci_devices(frozen_bus);
>+			pci_unlock_rescan_remove();
>+		}
> 	}
> }
>
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index edfe63a..3b8b32f 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -916,7 +916,8 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
> 	if (pe->type & EEH_PE_PHB) {
> 		bus = pe->phb->bus;
> 	} else if (pe->type & EEH_PE_BUS ||
>-		   pe->type & EEH_PE_DEVICE) {
>+		   pe->type & EEH_PE_DEVICE ||
>+		   pe->type & EEH_PE_VF) {

I still have the concern: VF PE isn't supposed to have PE primary bus as the
PE contains single or multiple (virtual) functions. So you can't simply
return the "shared" bus to caller to apply hotplug on it or for other
purpose.

> 		if (pe->bus) {
> 			bus = pe->bus;
> 			goto out;

Thanks,
Gavin
