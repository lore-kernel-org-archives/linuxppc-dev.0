Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8z1k3DWQzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:41:14 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7B6d8rK021590
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 02:41:12 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9u8ktw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 02:41:12 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 16:41:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3F8DB3578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:41:08 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7B6f8eF32047204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:41:08 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7B6f7iZ010493
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:41:08 +1000
Date: Thu, 11 Aug 2016 16:40:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH v3] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470865522-28046-1-git-send-email-mauricfo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470865522-28046-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <20160811064036.GB3787@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2016 at 06:45:22PM -0300, Mauricio Faria de Oliveira wrote:
>This patch leverages 'struct pci_host_bridge' from the PCI subsystem
>in order to free the pci_controller only after the last reference to
>its devices is dropped (avoiding an oops in pcibios_release_device()
>if the last reference is dropped after pcibios_free_controller()).
>
>The patch relies on pci_host_bridge.release_fn() (and .release_data),
>which is called automatically by the PCI subsystem when the root bus
>is released (i.e., the last reference is dropped).  Those fields are
>set via pci_set_host_bridge_release() (e.g. in the platform-specific
>implementation of pcibios_root_bridge_prepare()).
>
>It introduces the 'pcibios_host_bridge_release()' function to be set
>as .release_fn(), which expects .release_data to hold the pointer to
>the pci_controller to kfree().
>
>It enables that functionality for pseries (although it isn't platform
>-specific, and may be used by cxl). It keeps pcibios_free_controller()
>backwards-compatible (i.e., kfree(phb) in it) in case no .release_fn()
>is defined for the pci_controller.
>
>Details on not-so-elegant design choices:
>
> - Added 'pci_controller.bridge' field (pointer to associated 'struct
>   pci_host_bridge') so *not* to use 'pci_find_host_bridge(phb->bus)'
>   in pcibios_free_controller().
>
>   That's because remove_phb_dynamic() sets 'phb->bus = NULL' before
>   pcibios_free_controller().  That seems to be very important, with
>   commit title 'powerpc/pci: Fix various pseries PCI hotplug issues'
>   (so I'll not remove it just to avoid this null pointer dereference).
>
> - Used 'pci_host_bridge.release_data' field (pointer to associated
>   'struct pci_controller') so *not* to 'pci_bus_to_host(bridge->bus)'
>   in pcibios_host_bridge_release().
>
>   That's because pci_remove_root_bus() sets 'host_bridge->bus = NULL'
>   (so, if the last reference is released after pci_remove_root_bus()
>   runs, which eventually reaches pcibios_host_bridge_release(), that
>   would hit a null pointer dereference).
>
>   The cxl/vphb.c code calls pci_remove_root_bus(), and the cxl folks
>   are interested in this fix.
>
>Test-case:
>
>  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.0
>  <...> /sys/block/sdaa -> ../devices/pci0021:01/0021:01:00.0/<...>
>
>  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.1
>  <...> /sys/block/sdab -> ../devices/pci0021:01/0021:01:00.1/<...>
>
>  # cat >/dev/sdaa & pid1=$!
>  # cat >/dev/sdab & pid2=$!
>
>  # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
>  Validating PHB DLPAR capability...yes.
>  [  479.547020] pci_hp_remove_devices: PCI: Removing devices on bus 0021:01
>  [  479.547049] pci_hp_remove_devices:    Removing 0021:01:00.0...
>  ...
>  [  483.536303] pci_hp_remove_devices:    Removing 0021:01:00.1...
>  ...
>  [  497.072130] pci_bus 0021:01: busn_res: [bus 01-ff] is released
>  [  497.072209] rpadlpar_io: slot PHB 33 removed
>
>  # kill -9 $pid1
>  # kill -9 $pid2
>  [  506.604458] pcibios_host_bridge_release: domain 33, dynamic 1
>
>Suggested-By: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
>
>Changelog:
> - v3: different approach: struct pci_host_bridge.release_fn()
> - v2: different approach: struct pci_controller.refcount
>---
> arch/powerpc/include/asm/pci-bridge.h |  2 ++
> arch/powerpc/kernel/pci-common.c      | 15 ++++++++++++++-
> arch/powerpc/platforms/pseries/pci.c  |  3 +++
> 3 files changed, 19 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>index b5e88e4..9b11631 100644
>--- a/arch/powerpc/include/asm/pci-bridge.h
>+++ b/arch/powerpc/include/asm/pci-bridge.h
>@@ -54,6 +54,7 @@ struct pci_controller_ops {
>  */
> struct pci_controller {
> 	struct pci_bus *bus;
>+	struct pci_host_bridge *bridge; /* associated 'PHB' in PCI subsystem */
> 	char is_dynamic;
> #ifdef CONFIG_PPC64
> 	int node;
>@@ -301,6 +302,7 @@ extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
> /* Allocate & free a PCI host bridge structure */
> extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
> extern void pcibios_free_controller(struct pci_controller *phb);
>+extern void pcibios_host_bridge_release(struct pci_host_bridge *bridge);
>
> #ifdef CONFIG_PCI
> extern int pcibios_vaddr_is_ioport(void __iomem *address);
>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>index a5c0153..c5b5f60 100644
>--- a/arch/powerpc/kernel/pci-common.c
>+++ b/arch/powerpc/kernel/pci-common.c
>@@ -145,11 +145,23 @@ void pcibios_free_controller(struct pci_controller *phb)
> 	list_del(&phb->list_node);
> 	spin_unlock(&hose_spinlock);
>
>-	if (phb->is_dynamic)
>+	/* if the associated pci_host_bridge has a release_fn(), rely on that. */
>+	if (!phb->bridge->release_fn && phb->is_dynamic)
> 		kfree(phb);
> }
> EXPORT_SYMBOL_GPL(pcibios_free_controller);
>
>+void pcibios_host_bridge_release(struct pci_host_bridge *bridge)
>+{
>+	struct pci_controller *phb = (struct pci_controller *) bridge->release_data;
>+
>+	pr_debug("domain %d, dynamic %d\n", phb->global_number, phb->is_dynamic);
>+
>+	if (phb->is_dynamic)
>+		kfree(phb);
>+}
>+EXPORT_SYMBOL_GPL(pcibios_host_bridge_release);
>+

It seems the user has two options here: (1) Setup bridge's release_fn() and call
pcibios_free_controller() explicitly; (2) Call pcibios_free_controller() without
a valid bridge's release_fn() initialized. I think we can provide better interface
to users: what we do in pcibios_free_controller() and pcibios_host_bridge_release()
should be (almost) same. pcibios_host_bridge_release() can be a wrapper of
pcibios_free_controller(). With this, the users have two options: (1) Rely on bridge's
release_fn() to free the PCI controller; (2) Call pcibios_free_controller() as we're
doing currently. Those two options corresponds to immediately or deferred releasing.

> /*
>  * The function is used to return the minimal alignment
>  * for memory or I/O windows of the associated P2P bridge.
>@@ -1646,6 +1658,7 @@ void pcibios_scan_phb(struct pci_controller *hose)
> 		return;
> 	}
> 	hose->bus = bus;
>+	hose->bridge = pci_find_host_bridge(bus);
>
> 	/* Get probe mode and perform scan */
> 	mode = PCI_PROBE_NORMAL;
>diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
>index fe16a50..146d5da 100644
>--- a/arch/powerpc/platforms/pseries/pci.c
>+++ b/arch/powerpc/platforms/pseries/pci.c
>@@ -119,6 +119,9 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
>
> 	bus = bridge->bus;
>
>+	pci_set_host_bridge_release(bridge, pcibios_host_bridge_release,
>+					(void *) pci_bus_to_host(bus));
>+
> 	dn = pcibios_get_phb_of_node(bus);
> 	if (!dn)
> 		return 0;

Thanks,
Gavin

>-- 
>1.8.3.1
>
