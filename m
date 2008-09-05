Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1326EDDEEF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 13:54:32 +1000 (EST)
Subject: Re: 2.6.27-rc5-mm1 mystery trace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080904202032.2299c2c8.akpm@linux-foundation.org>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 13:54:22 +1000
Message-Id: <1220586862.4879.123.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> a) someone broke powerpc's kallsyms processing and
> 
> b) someone screwed up their procfs handling.

I think the proc bug is old, might have to do with /proc/bus/pci... 
I have that on my G5 too with 2.6.26, I think I just forgot about it..
Care to give that untested patch a try ?

powerpc: Always enable pci domains in /proc for 64 bits powerpc

This patch always enable the use of the pci domain number in /proc
on 64 bits ppc machines instead of the old pseries specific hack of
testing for the buid which is meaningless on most machines.

We also enable the compat code that makes domain 0 use the old
format for the sake of the X server.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-09-05 13:46:09.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-09-05 13:49:46.000000000 +1000
@@ -53,8 +53,9 @@ static int global_phb_number;		/* Global
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
 
-/* Default PCI flags is 0 */
-unsigned int ppc_pci_flags;
+/* Default PCI flags is 0 on ppc32, modified at boot on ppc64 */
+unsigned int ppc_pci_flags = 0;
+
 
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
@@ -669,15 +670,12 @@ void __devinit pci_process_bridge_OF_ran
 int pci_proc_domain(struct pci_bus *bus)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-#ifdef CONFIG_PPC64
-	return hose->buid != 0;
-#else
+
 	if (!(ppc_pci_flags & PPC_PCI_ENABLE_PROC_DOMAINS))
 		return 0;
 	if (ppc_pci_flags & PPC_PCI_COMPAT_DOMAIN_0)
 		return hose->global_number != 0;
 	return 1;
-#endif
 }
 
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
