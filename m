Return-Path: <moilanen@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7699A679EA
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 09:20:29 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VMKQ7w007718
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:20:26 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VMNZ06178144
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:23:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2VMKQbQ021072
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:20:26 -0700
Date: Fri, 31 Mar 2006 16:13:30 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] Base pSeries PCIe support
Message-Id: <20060331161330.3c723103.moilanen@austin.ibm.com>
In-Reply-To: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch hooks our current interrupt subsystem and sets up a single
vector MSI as if it was a LSI.  Multiple MSI vectors is coming in the
future.

The NR_IRQS got bumped up to 1024, as vectors can go much higher.
Unfortunately, this number was arbitrarily picked as there is no claim
at what the max number really is by either the firmware team, or the
PAPR+.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---

Index: 2.6.16/arch/powerpc/kernel/prom.c
===================================================================
--- 2.6.16.orig/arch/powerpc/kernel/prom.c	2006-03-31 15:11:20.000000000 -0600
+++ 2.6.16/arch/powerpc/kernel/prom.c	2006-03-31 15:37:10.000000000 -0600
@@ -88,6 +88,8 @@
 struct device_node *dflt_interrupt_controller;
 int num_interrupt_controllers;
 
+void __init finish_msi_node(struct device_node *dn, unsigned long *mem_start, int measure_only);
+
 /*
  * Wrapper for allocating memory for various data that needs to be
  * attached to device nodes as they are processed at boot or when
@@ -120,6 +122,22 @@
 	return NULL;
 }
 
+int
+property_present(struct device_node *np, const char *name)
+{
+	struct property *pp;
+
+	read_lock(&devtree_lock);
+	for (pp = np->properties; pp != 0; pp = pp->next)
+		if (strcmp(pp->name, name) == 0) {
+			return 1;
+		}
+	read_unlock(&devtree_lock);
+
+	return 0;
+}
+
+
 /*
  * Find the interrupt parent of a node.
  */
@@ -341,6 +359,14 @@
 		return 0;
 	}
 
+#ifdef CONFIG_PPC_PSERIES
+	if(property_present(np, "ibm,req#msi")) {
+		printk(KERN_EMERG "Found MSI\n");
+		finish_msi_node(np, mem_start, measure_only);
+		return 0;
+	}
+#endif
+
 	ints = (unsigned int *) get_property(np, "interrupts", &intlen);
 	TRACE("ints=%p, intlen=%d\n", ints, intlen);
 	if (ints == NULL)
@@ -503,6 +529,80 @@
 	DBG(" <- finish_device_tree\n");
 }
 
+void __init finish_msi_node(struct device_node *dn, unsigned long *mem_start, int measure_only)
+{
+	static int seq_num = 1;
+	int i;
+	int rc;
+	int query_token = rtas_token("ibm,query-interrupt-source-number");
+	int devfn;
+	int busno;
+	u32 *reg;
+	int reglen;
+	int ret[3];
+	unsigned int virq;
+	unsigned int addr;
+	unsigned long buid = -1;
+	unsigned long wait_time;
+
+	reg = (u32 *) get_property(dn, "reg", &reglen);
+	if (reg == NULL || reglen < 20)
+		return;
+
+	devfn = (reg[0] >> 8) & 0xff;
+	busno = (reg[0] >> 16) & 0xff;
+
+	buid = get_phb_buid(dn->parent);
+	addr = (busno << 16) | (devfn << 8);
+
+	while (1) {
+		rc = rtas_call(rtas_token("ibm,change-msi"), 6, 3, ret, addr,
+			       buid >> 32, buid & 0xffffffff,
+			       1, 1, seq_num);
+
+		if (!rc)
+			break;
+		else if (rc == RTAS_BUSY)
+			udelay(1);
+		else if (rtas_is_extended_busy(rc)) {
+			wait_time = rtas_extended_busy_delay_time(rc);
+			udelay(wait_time * 1000);
+		} else {
+			printk(KERN_WARNING "error[%d]: getting the number of"
+			       "MSI interrupts for %s\n", rc, dn->name);
+			return;
+		}
+
+		seq_num = ret[1];
+	}
+
+	dn->n_intrs = ret[0];
+
+	dn->intrs = prom_alloc(dn->n_intrs * sizeof(*(dn->intrs)), mem_start);
+	if (!dn->intrs) {
+		printk(KERN_EMERG "finish_msi_node: can't allocate space\n");
+		return;
+	}
+
+	if (measure_only)
+		return;
+
+	for (i = 0; i < dn->n_intrs; i++) {
+		rc = rtas_call(query_token, 4, 3, ret, addr, buid >> 32, buid & 0xffffffff, i);
+
+		if (!rc) {
+			virq = virt_irq_create_mapping(ret[0]);
+
+			dn->intrs[i].line = irq_offset_up(virq);
+			dn->intrs[i].sense = ret[1];
+		} else {
+			printk(KERN_WARNING "error[%d]: query-interrupt-source-number for %s\n",
+			       rc, dn->name);
+		}
+	}
+
+}
+
 static inline char *find_flat_dt_string(u32 offset)
 {
 	return ((char *)initial_boot_params) +
Index: 2.6.16/include/asm-powerpc/irq.h
===================================================================
--- 2.6.16.orig/include/asm-powerpc/irq.h	2006-03-31 15:11:12.000000000 -0600
+++ 2.6.16/include/asm-powerpc/irq.h	2006-03-31 15:15:46.000000000 -0600
@@ -47,7 +47,7 @@
 /*
  * Maximum number of interrupt sources that we can handle.
  */
-#define NR_IRQS		512
+#define NR_IRQS		1024
 
 /* Interrupt numbers are virtual in case they are sparsely
  * distributed by the hardware.
Index: 2.6.16/include/asm-powerpc/pci-bridge.h
===================================================================
--- 2.6.16.orig/include/asm-powerpc/pci-bridge.h	2006-03-31 15:11:36.000000000 -0600
+++ 2.6.16/include/asm-powerpc/pci-bridge.h	2006-03-31 15:34:50.000000000 -0600
@@ -141,6 +141,7 @@
 void pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus);
 
 extern int pcibios_remove_root_bus(struct pci_controller *phb);
+extern unsigned long __devinit get_phb_buid (struct device_node *phb);
 
 static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
 {
