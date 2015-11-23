Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCCE61A013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:12:25 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 09:12:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AAF832CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:12:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANNCENb57081932
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:12:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANNBncE005402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:11:50 +1100
Date: Tue, 24 Nov 2015 10:11:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 29/50] powerpc/pci: Rename pcibios_find_pci_bus()
Message-ID: <20151123231124.GE5375@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-30-git-send-email-gwshan@linux.vnet.ibm.com>
 <564BF7A4.3060105@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <564BF7A4.3060105@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18, 2015 at 02:59:32PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>This renames pcibios_find_pci_bus() to pci_find_bus_by_node() to
>>avoid conflicts with those PCI subsystem weak function names, which
>>have prefix "pcibios". No logical changes introduced.
>
>Could be merged into [PATCH v7 28/50] powerpc/pci: Rename
>pcibios_{add,remove}_pci_devices()  or/and moved to the beginning of the
>series?
>

I don't think it would be merged to [PATCH 28/50]. If it needs to be merged
to another one patch, that would be [PATCH 30/50], but I prefer to keep it
to make the patch simple (doing one thing if possible).

>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/include/asm/pci-bridge.h      | 2 +-
>>  arch/powerpc/platforms/pseries/pci_dlpar.c | 5 ++---
>>  drivers/pci/hotplug/rpadlpar_core.c        | 6 +++---
>>  drivers/pci/hotplug/rpaphp_pci.c           | 2 +-
>>  4 files changed, 7 insertions(+), 8 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index c2360c8..28385cb 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -257,7 +257,7 @@ static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
>>  #endif
>>
>>  /** Find the bus corresponding to the indicated device node */
>>-extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
>>+extern struct pci_bus *pci_find_bus_by_node(struct device_node *dn);
>>
>>  /** Remove all of the PCI devices under this bus */
>>  extern void pci_remove_pci_devices(struct pci_bus *bus);
>>diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
>>index 5d4a3df..aee22b4 100644
>>--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
>>+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
>>@@ -54,8 +54,7 @@ find_bus_among_children(struct pci_bus *bus,
>>  	return child;
>>  }
>>
>>-struct pci_bus *
>>-pcibios_find_pci_bus(struct device_node *dn)
>>+struct pci_bus *pci_find_bus_by_node(struct device_node *dn)
>>  {
>>  	struct pci_dn *pdn = dn->data;
>>
>>@@ -64,7 +63,7 @@ pcibios_find_pci_bus(struct device_node *dn)
>>
>>  	return find_bus_among_children(pdn->phb->bus, dn);
>>  }
>>-EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
>>+EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
>>
>>  struct pci_controller *init_phb_dynamic(struct device_node *dn)
>>  {
>>diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
>>index ebd283b..9aa392b 100644
>>--- a/drivers/pci/hotplug/rpadlpar_core.c
>>+++ b/drivers/pci/hotplug/rpadlpar_core.c
>>@@ -176,7 +176,7 @@ static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
>>  	struct pci_dev *dev;
>>  	struct pci_controller *phb;
>>
>>-	if (pcibios_find_pci_bus(dn))
>>+	if (pci_find_bus_by_node(dn))
>>  		return -EINVAL;
>>
>>  	/* Add pci bus */
>>@@ -213,7 +213,7 @@ static int dlpar_remove_phb(char *drc_name, struct device_node *dn)
>>  	struct pci_dn *pdn;
>>  	int rc = 0;
>>
>>-	if (!pcibios_find_pci_bus(dn))
>>+	if (!pci_find_bus_by_node(dn))
>>  		return -EINVAL;
>>
>>  	/* If pci slot is hotpluggable, use hotplug to remove it */
>>@@ -357,7 +357,7 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
>>
>>  	pci_lock_rescan_remove();
>>
>>-	bus = pcibios_find_pci_bus(dn);
>>+	bus = pci_find_bus_by_node(dn);
>>  	if (!bus) {
>>  		ret = -EINVAL;
>>  		goto out;
>>diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
>>index 256066c..e7dd573 100644
>>--- a/drivers/pci/hotplug/rpaphp_pci.c
>>+++ b/drivers/pci/hotplug/rpaphp_pci.c
>>@@ -93,7 +93,7 @@ int rpaphp_enable_slot(struct slot *slot)
>>  	if (rc)
>>  		return rc;
>>
>>-	bus = pcibios_find_pci_bus(slot->dn);
>>+	bus = pci_find_bus_by_node(slot->dn);
>>  	if (!bus) {
>>  		err("%s: no pci_bus for dn %s\n", __func__, slot->dn->full_name);
>>  		return -EINVAL;
>>

Thanks,
Gavin
