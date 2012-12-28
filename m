Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09EBB2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 16:18:53 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 28 Dec 2012 00:18:50 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EB071C90026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 00:18:47 -0500 (EST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBS5IlwE337384
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 00:18:47 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBS5IkTa025299
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 22:18:47 -0700
Date: Fri, 28 Dec 2012 13:18:24 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc/EEH: fix crash when adding a device in a slot with DDW
Message-ID: <20121228051824.GA9975@shangw.(null)>
References: <1356626040-9384-1-git-send-email-cascardo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356626040-9384-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, paulus@samba.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 27, 2012 at 02:34:00PM -0200, Thadeu Lima de Souza Cascardo wrote:
>The DDW code uses a eeh_dev struct from the pci_dev. However, this is
>not set until eeh_add_device_late is called.
>
>Since pci_bus_add_devices is called before eeh_add_device_late, the PCI
>devices are added to the bus, making drivers' probe hooks to be called.
>These will call set_dma_mask, which will call the DDW code, which will
>require the eeh_dev struct from pci_dev. This would result in a crash,
>due to a NULL dereference.
>
>Calling eeh_add_device_late after pci_bus_add_devices would make the
>system BUG, because device files shouldn't be added to devices there
>were not added to the system. So, a new function is needed to add such
>files only after pci_bus_add_devices have been called.
>

Could you please explain for a bit how did you trigger the problem? I'm
not sure you got it while doing PCI hotplug or just saw the issue during
system bootup stage :-)

>Cc: stable@vger.kernel.org
>Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
>---
> arch/powerpc/include/asm/eeh.h       |    3 +++
> arch/powerpc/kernel/pci-common.c     |    7 +++++--
> arch/powerpc/platforms/pseries/eeh.c |   24 +++++++++++++++++++++++-
> 3 files changed, 31 insertions(+), 3 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>index b0ef738..71aac19 100644
>--- a/arch/powerpc/include/asm/eeh.h
>+++ b/arch/powerpc/include/asm/eeh.h
>@@ -201,6 +201,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev);
> void __init eeh_addr_cache_build(void);
> void eeh_add_device_tree_early(struct device_node *);
> void eeh_add_device_tree_late(struct pci_bus *);
>+void eeh_add_device_tree_files(struct pci_bus *);

Since the function is going to add EEH specific sysfs files, its name would
be something like "eeh_add_sysfs_files" instead of "eeh_add_device_tree_files" :-)

> void eeh_remove_bus_device(struct pci_dev *, int);
>
> /**
>@@ -240,6 +241,8 @@ static inline void eeh_add_device_tree_early(struct device_node *dn) { }
>
> static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
>
>+static inline void eeh_add_device_tree_files(struct pci_bus *bus) { }
>+

It'd better to rename the function name to "eeh_add_sysfs_files" mentioned
as above.

> static inline void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe) { }
>
> static inline void eeh_lock(void) { }
>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>index 7f94f76..7b1f14c 100644
>--- a/arch/powerpc/kernel/pci-common.c
>+++ b/arch/powerpc/kernel/pci-common.c
>@@ -1480,11 +1480,14 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
> 	pcibios_allocate_bus_resources(bus);
> 	pcibios_claim_one_bus(bus);
>
>+	/* Fixup EEH */
>+	eeh_add_device_tree_late(bus);
>+
> 	/* Add new devices to global lists.  Register in proc, sysfs. */
> 	pci_bus_add_devices(bus);
>
>-	/* Fixup EEH */
>-	eeh_add_device_tree_late(bus);
>+	/* Add EEH sysfs files */
>+	eeh_add_device_tree_files(bus);

The function name would be "eeh_add_sysfs_files" as above.

> }
> EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
>

By the way, arch/powerpc/kernel/of_platform.c::of_pci_phb_probe is also calling
to eeh_add_device_tree_late() as well. Since you have removed part of the logic
from original eeh_add_device_tree_late(), which is add EEH specific sysfs files,
and you put that part of logic to eeh_add_device_tree_files(). So I think you
also need make the similiar change for of_pci_phb_probe() as well :-)

>diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
>index 9a04322..a667a34 100644
>--- a/arch/powerpc/platforms/pseries/eeh.c
>+++ b/arch/powerpc/platforms/pseries/eeh.c
>@@ -788,7 +788,6 @@ static void eeh_add_device_late(struct pci_dev *dev)
> 	dev->dev.archdata.edev = edev;
>
> 	eeh_addr_cache_insert_dev(dev);
>-	eeh_sysfs_add_device(dev);
> }
>
> /**
>@@ -815,6 +814,29 @@ void eeh_add_device_tree_late(struct pci_bus *bus)
> EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
>
> /**
>+ * eeh_add_device_tree_files - Add EEH sysfs files for the indicated PCI bus
>+ * @bus: PCI bus
>+ *
>+ * This routine must be used to add EEH sysfs files for PCI
>+ * devices which are attached to the indicated PCI bus. The PCI bus
>+ * is added after system boot through hotplug or dlpar.
>+ */
>+void eeh_add_device_tree_files(struct pci_bus *bus)
>+{
>+	struct pci_dev *dev;
>+
>+	list_for_each_entry(dev, &bus->devices, bus_list) {
>+		eeh_sysfs_add_device(dev);
>+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>+			struct pci_bus *subbus = dev->subordinate;
>+			if (subbus)
>+				eeh_add_device_tree_files(subbus);
>+		}
>+	}
>+}
>+EXPORT_SYMBOL_GPL(eeh_add_device_tree_files);
>+

The function name mentioned as above.

>+/**
>  * eeh_remove_device - Undo EEH setup for the indicated pci device
>  * @dev: pci device to be removed
>  * @purge_pe: remove the PE or not
>

Thanks,
Gavin
