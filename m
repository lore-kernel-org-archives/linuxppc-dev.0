Return-Path: <moilanen@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4194D679E2
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 09:21:28 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.boulder.ibm.com [9.17.249.43])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k31N4ae8017413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Apr 2006 18:04:37 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k31N4Lep020131
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Apr 2006 18:04:21 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k31N7U3O191168
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Apr 2006 16:07:30 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k31N4KRh014924
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Apr 2006 16:04:20 -0700
Date: Sat, 1 Apr 2006 16:57:23 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
Message-Id: <20060401165723.ab77c81f.moilanen@austin.ibm.com>
In-Reply-To: <17454.15223.929530.985654@cargo.ozlabs.ibm.com>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
	<17454.15223.929530.985654@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 1 Apr 2006 19:36:07 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Jake Moilanen writes:
> 
> > The NR_IRQS got bumped up to 1024, as vectors can go much higher.
> > Unfortunately, this number was arbitrarily picked as there is no claim
> > at what the max number really is by either the firmware team, or the
> > PAPR+.
> 
> What matters is the number of different vectors, not the actual value
> of the vectors, because we remap interrupt numbers that the firmware
> gives us to logical Linux irq numbers between 0 and NR_IRQS-1.  We had
> to do that when the POWER5 systems came out, because the interrupt
> numbers there occupy 24 bits.

Ah.  That sounds right.  I haven't had a chance to test this version of
the patch.  Firmware is currently broken on my machine.

Here's try #2

I ended up putting #ifdef CONFIG_PPC_RTAS around this, as non-rtas
kernels won't like all the rtas calls.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---

Index: 2.6.16/arch/powerpc/kernel/prom.c
===================================================================
--- 2.6.16.orig/arch/powerpc/kernel/prom.c	2006-04-01 16:34:45.000000000 -0600
+++ 2.6.16/arch/powerpc/kernel/prom.c	2006-04-01 16:52:53.000000000 -0600
@@ -88,6 +88,8 @@
 struct device_node *dflt_interrupt_controller;
 int num_interrupt_controllers;
 
+void __init finish_node_msi(struct device_node *dn, unsigned long *mem_start, int measure_only);
+
 /*
  * Wrapper for allocating memory for various data that needs to be
  * attached to device nodes as they are processed at boot or when
@@ -295,6 +297,7 @@
 {
 	unsigned int *ints;
 	int intlen, intrcells, intrcount;
+	int dummy;
 	int i, j, n, sense;
 	unsigned int *irq, virq;
 	struct device_node *ic;
@@ -341,6 +344,13 @@
 		return 0;
 	}
 
+#ifdef CONFIG_PPC_RTAS
+	if(of_find_property(np, "ibm,req#msi", &dummy)) {
+		finish_node_msi(np, mem_start, measure_only);
+		return 0;
+	}
+#endif
+
 	ints = (unsigned int *) get_property(np, "interrupts", &intlen);
 	TRACE("ints=%p, intlen=%d\n", ints, intlen);
 	if (ints == NULL)
@@ -503,6 +513,82 @@
 	DBG(" <- finish_device_tree\n");
 }
 
+#ifdef CONFIG_PPC_RTAS
+void __devinit finish_node_msi(struct device_node *dn, unsigned long *mem_start, int measure_only)
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
+		printk(KERN_WARNING "finish_node_msi: can't allocate space\n");
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
+#endif /* #ifdef CONFIG_PPC_RTAS */
+
 static inline char *find_flat_dt_string(u32 offset)
 {
 	return ((char *)initial_boot_params) +
Index: 2.6.16/include/asm-powerpc/pci-bridge.h
===================================================================
--- 2.6.16.orig/include/asm-powerpc/pci-bridge.h	2006-04-01 16:34:45.000000000 -0600
+++ 2.6.16/include/asm-powerpc/pci-bridge.h	2006-04-01 16:52:38.000000000 -0600
@@ -141,6 +141,7 @@
 void pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus);
 
 extern int pcibios_remove_root_bus(struct pci_controller *phb);
+extern unsigned long __devinit get_phb_buid (struct device_node *phb);
 
 static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
 {
