Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skPvy6KshzDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:33:18 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S4X61d068031
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:33:16 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qxu2aqa5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:33:16 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 14:33:14 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 548E22CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:33:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S4XBVL1638870
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:33:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S4XAEV028535
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:33:11 +1000
Date: Wed, 28 Sep 2016 14:33:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, mpe@ellerman.id.au
Subject: Re: [PATCH v2 5/5] drivers/pci/hotplug: Support surprise hotplug in
 powernv driver
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1474894567-15229-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1474894567-15229-6-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474894567-15229-6-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <20160928043340.GA18600@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 26, 2016 at 10:56:07PM +1000, Gavin Shan wrote:
>This supports PCI surprise hotplug. The design is highlighted as
>below:
>
>   * The PCI slot's surprise hotplug capability is exposed through
>     device node property "ibm,slot-surprise-pluggable", meaning
>     PCI surprise hotplug will be disabled if skiboot doesn't support
>     it yet.
>   * The interrupt because of presence or link state change is raised
>     on surprise hotplug event. One event is allocated and queued to
>     the PCI slot for workqueue to pick it up and process in serialized
>     fashion. The code flow for surprise hotplug is same to that for
>     managed hotplug except: the affected PEs are put into frozen state
>     to avoid unexpected EEH error reporting in surprise hot remove path.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---

.../...

>+static irqreturn_t pnv_php_interrupt(int irq, void *data)
>+{
>+	struct pnv_php_slot *php_slot = data;
>+	struct pci_dev *pchild, *pdev = php_slot->pdev;
>+	struct eeh_dev *edev;
>+	struct eeh_pe *pe;
>+	struct pnv_php_event *event;
>+	u16 sts, lsts;
>+	u8 presence;
>+	bool added;
>+	unsigned long flags;
>+	int ret;
>+
>+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
>+	sts &= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
>+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);
>+	if (sts & PCI_EXP_SLTSTA_DLLSC) {
>+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lsts);
>+		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
>+	} else if (sts & PCI_EXP_SLTSTA_PDC) {
>+		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
>+		if (!ret)
>+			return IRQ_HANDLED;
>+		added = !!(presence == OPAL_PCI_SLOT_PRESENT);
>+	} else {
>+		return IRQ_NONE;
>+	}
>+
>+	/* Freeze the removed PE to avoid unexpected error reporting */
>+	if (!added) {
>+		pchild = list_first_entry_or_null(&php_slot->bus->devices,
>+						  struct pci_dev, bus_list);
>+		edev = pchild ? pci_dev_to_eeh_dev(pchild) : NULL;
>+		pe = edev ? edev->pe : NULL;
>+		if (pe) {
>+			eeh_serialize_lock(&flags);
>+			eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
>+			eeh_serialize_unlock(flags);
>+			eeh_pe_set_option(pe, EEH_OPT_FREEZE_PE);
>+		}
>+	}
>+

I still need export @confirm_error_lock. Otherwise, it will be failed to be
built when having CONFIG_HOTPLUG_PCI_POWERNV=m. I will respin and add one
patch for that in v3.

Thanks,
Gavin
