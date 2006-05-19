Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 41C7B679F5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:08:38 +1000 (EST)
Date: Fri, 19 May 2006 16:46:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 03/14] powerpc: move iSeries PCI devices to the device tree
Message-Id: <20060519164628.317d2a54.sfr@canb.auug.org.au>
In-Reply-To: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
References: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the probing of PCI devices to setup.c and put them all into the
flattened device tree.  The later probing is now done by traversing the
device tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/irq.c   |    7 -
 arch/powerpc/platforms/iseries/irq.h   |    2 
 arch/powerpc/platforms/iseries/pci.c   |  273 +++++++++-----------------------
 arch/powerpc/platforms/iseries/setup.c |  204 ++++++++++++++++++++++++
 4 files changed, 286 insertions(+), 200 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

97c92bf9859c9d883da1b8459f62dec2ab20804e
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index be3fbfc..62bbbcf 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -42,6 +42,7 @@ #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/it_lp_queue.h>
 
 #include "irq.h"
+#include "pci.h"
 #include "call_pci.h"
 
 #if defined(CONFIG_SMP)
@@ -312,12 +313,12 @@ static hw_irq_controller iSeries_IRQ_han
  * Note that sub_bus is always 0 (at the moment at least).
  */
 int __init iSeries_allocate_IRQ(HvBusNumber bus,
-		HvSubBusNumber sub_bus, HvAgentId dev_id)
+		HvSubBusNumber sub_bus, u32 bsubbus)
 {
 	int virtirq;
 	unsigned int realirq;
-	u8 idsel = (dev_id >> 4);
-	u8 function = dev_id & 7;
+	u8 idsel = ISERIES_GET_DEVICE_FROM_SUBBUS(bsubbus);
+	u8 function = ISERIES_GET_FUNCTION_FROM_SUBBUS(bsubbus);
 
 	realirq = (((((sub_bus << 8) + (bus - 1)) << 3) + (idsel - 1)) << 3)
 		+ function;
diff --git a/arch/powerpc/platforms/iseries/irq.h b/arch/powerpc/platforms/iseries/irq.h
index b9c801b..188aa80 100644
--- a/arch/powerpc/platforms/iseries/irq.h
+++ b/arch/powerpc/platforms/iseries/irq.h
@@ -2,7 +2,7 @@ #ifndef	_ISERIES_IRQ_H
 #define	_ISERIES_IRQ_H
 
 extern void iSeries_init_IRQ(void);
-extern int  iSeries_allocate_IRQ(HvBusNumber, HvSubBusNumber, HvAgentId);
+extern int  iSeries_allocate_IRQ(HvBusNumber, HvSubBusNumber, u32);
 extern void iSeries_activate_IRQs(void);
 extern int iSeries_get_irq(struct pt_regs *);
 
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 91a9474..9d571e7 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -49,14 +49,9 @@ #include "call_pci.h"
  * Forward declares of prototypes.
  */
 static struct device_node *find_Device_Node(int bus, int devfn);
-static void scan_PHB_slots(struct pci_controller *Phb);
-static void scan_EADS_bridge(HvBusNumber Bus, HvSubBusNumber SubBus, int IdSel);
-static int scan_bridge_slot(HvBusNumber Bus, struct HvCallPci_BridgeInfo *Info);
 
 LIST_HEAD(iSeries_Global_Device_List);
 
-static int DeviceCount;
-
 static int Pci_Retry_Max = 3;	/* Only retry 3 times  */
 static int Pci_Error_Flag = 1;	/* Set Retry Error on. */
 
@@ -162,32 +157,6 @@ static void pci_Log_Error(char *Error_Te
 }
 
 /*
- * build_device_node(u16 Bus, int SubBus, u8 DevFn)
- */
-static struct device_node *build_device_node(HvBusNumber Bus,
-		HvSubBusNumber SubBus, int AgentId, int Function)
-{
-	struct device_node *node;
-	struct pci_dn *pdn;
-
-	node = kzalloc(sizeof(struct device_node), GFP_KERNEL);
-	if (node == NULL)
-		return NULL;
-	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
-	if (pdn == NULL) {
-		kfree(node);
-		return NULL;
-	}
-	node->data = pdn;
-	pdn->node = node;
-	list_add_tail(&pdn->Device_List, &iSeries_Global_Device_List);
-	pdn->busno = Bus;
-	pdn->bussubno = SubBus;
-	pdn->devfn = PCI_DEVFN(ISERIES_ENCODE_DEVICE(AgentId), Function);
-	return node;
-}
-
-/*
  * iSeries_pcibios_init
  *
  * Description:
@@ -199,33 +168,86 @@ static struct device_node *build_device_
 void iSeries_pcibios_init(void)
 {
 	struct pci_controller *phb;
-	HvBusNumber bus;
-
-	/* Check all possible buses. */
-	for (bus = 0; bus < 256; bus++) {
-		int ret = HvCallXm_testBus(bus);
-		if (ret == 0) {
-			printk("bus %d appears to exist\n", bus);
-
-			phb = pcibios_alloc_controller(NULL);
-			if (phb == NULL)
-				return -ENOMEM;
+	struct device_node *node;
+	struct device_node *dn;
+
+	for_each_node_by_type(node, "pci") {
+		HvBusNumber bus;
+		u32 *busp;
+
+		busp = (u32 *)get_property(node, "bus-range", NULL);
+		if (busp == NULL)
+			continue;
+		bus = *busp;
+		printk("bus %d appears to exist\n", bus);
+		phb = pcibios_alloc_controller(node);
+		if (phb == NULL)
+			continue;
+
+		phb->pci_mem_offset = phb->local_number = bus;
+		phb->first_busno = bus;
+		phb->last_busno = bus;
+		phb->ops = &iSeries_pci_ops;
+
+		/* Find and connect the devices. */
+		for (dn = NULL; (dn = of_get_next_child(node, dn)) != NULL;) {
+			struct pci_dn *pdn;
+			u8 irq;
+			int err;
+			u32 *agent;
+			u32 *reg;
+			u32 *lsn;
+
+			reg = (u32 *)get_property(dn, "reg", NULL);
+			if (reg == NULL) {
+				printk(KERN_DEBUG "no reg property!\n");
+				continue;
+			}
+			busp = (u32 *)get_property(dn, "linux,subbus", NULL);
+			if (busp == NULL) {
+				printk(KERN_DEBUG "no subbus property!\n");
+				continue;
+			}
+			agent = (u32 *)get_property(dn, "linux,agent-id", NULL);
+			if (agent == NULL) {
+				printk(KERN_DEBUG "no agent-id\n");
+				continue;
+			}
+			lsn = (u32 *)get_property(dn,
+					"linux,logical-slot-number", NULL);
+			if (lsn == NULL) {
+				printk(KERN_DEBUG "no logical-slot-number\n");
+				continue;
+			}
 
-			phb->pci_mem_offset = phb->local_number = bus;
-			phb->first_busno = bus;
-			phb->last_busno = bus;
-			phb->ops = &iSeries_pci_ops;
+			irq = iSeries_allocate_IRQ(bus, 0, *busp);
+			err = HvCallXm_connectBusUnit(bus, *busp, *agent, irq);
+			if (err) {
+				pci_Log_Error("Connect Bus Unit",
+					      bus, *busp, *agent, err);
+				continue;
+			}
+			err = HvCallPci_configStore8(bus, *busp, *agent,
+					PCI_INTERRUPT_LINE, irq);
+			if (err) {
+				pci_Log_Error("PciCfgStore Irq Failed!",
+						bus, *busp, *agent, err);
+				continue;
+			}
 
-			/* Find and connect the devices. */
-			scan_PHB_slots(phb);
+			pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
+			if (pdn == NULL)
+				return;
+			dn->data = pdn;
+			pdn->node = dn;
+			pdn->busno = bus;
+			pdn->devfn = (reg[0] >> 8) & 0xff;
+			pdn->bussubno = *busp;
+			pdn->Irq = irq;
+			pdn->LogicalSlot = *lsn;
+			list_add_tail(&pdn->Device_List,
+					&iSeries_Global_Device_List);
 		}
-		/*
-		 * Check for Unexpected Return code, a clue that something
-		 * has gone wrong.
-		 */
-		else if (ret != 0x0301)
-			printk(KERN_ERR "Unexpected Return on Probe(0x%04X): 0x%04X",
-			       bus, ret);
 	}
 }
 
@@ -272,147 +294,6 @@ void pcibios_fixup_resources(struct pci_
 }
 
 /*
- * Loop through each node function to find usable EADs bridges.
- */
-static void scan_PHB_slots(struct pci_controller *Phb)
-{
-	struct HvCallPci_DeviceInfo *DevInfo;
-	HvBusNumber bus = Phb->local_number;	/* System Bus */
-	const HvSubBusNumber SubBus = 0;	/* EADs is always 0. */
-	int HvRc = 0;
-	int IdSel;
-	const int MaxAgents = 8;
-
-	DevInfo = kmalloc(sizeof(struct HvCallPci_DeviceInfo), GFP_KERNEL);
-	if (DevInfo == NULL)
-		return;
-
-	/*
-	 * Probe for EADs Bridges
-	 */
-	for (IdSel = 1; IdSel < MaxAgents; ++IdSel) {
-		HvRc = HvCallPci_getDeviceInfo(bus, SubBus, IdSel,
-				iseries_hv_addr(DevInfo),
-				sizeof(struct HvCallPci_DeviceInfo));
-		if (HvRc == 0) {
-			if (DevInfo->deviceType == HvCallPci_NodeDevice)
-				scan_EADS_bridge(bus, SubBus, IdSel);
-			else
-				printk("PCI: Invalid System Configuration(0x%02X)"
-				       " for bus 0x%02x id 0x%02x.\n",
-				       DevInfo->deviceType, bus, IdSel);
-		}
-		else
-			pci_Log_Error("getDeviceInfo", bus, SubBus, IdSel, HvRc);
-	}
-	kfree(DevInfo);
-}
-
-static void scan_EADS_bridge(HvBusNumber bus, HvSubBusNumber SubBus,
-		int IdSel)
-{
-	struct HvCallPci_BridgeInfo *BridgeInfo;
-	HvAgentId AgentId;
-	int Function;
-	int HvRc;
-
-	BridgeInfo = (struct HvCallPci_BridgeInfo *)
-		kmalloc(sizeof(struct HvCallPci_BridgeInfo), GFP_KERNEL);
-	if (BridgeInfo == NULL)
-		return;
-
-	/* Note: hvSubBus and irq is always be 0 at this level! */
-	for (Function = 0; Function < 8; ++Function) {
-		AgentId = ISERIES_PCI_AGENTID(IdSel, Function);
-		HvRc = HvCallXm_connectBusUnit(bus, SubBus, AgentId, 0);
-		if (HvRc == 0) {
-			printk("found device at bus %d idsel %d func %d (AgentId %x)\n",
-			       bus, IdSel, Function, AgentId);
-			/*  Connect EADs: 0x18.00.12 = 0x00 */
-			HvRc = HvCallPci_getBusUnitInfo(bus, SubBus, AgentId,
-					iseries_hv_addr(BridgeInfo),
-					sizeof(struct HvCallPci_BridgeInfo));
-			if (HvRc == 0) {
-				printk("bridge info: type %x subbus %x maxAgents %x maxsubbus %x logslot %x\n",
-					BridgeInfo->busUnitInfo.deviceType,
-					BridgeInfo->subBusNumber,
-					BridgeInfo->maxAgents,
-					BridgeInfo->maxSubBusNumber,
-					BridgeInfo->logicalSlotNumber);
-				if (BridgeInfo->busUnitInfo.deviceType ==
-						HvCallPci_BridgeDevice)  {
-					/* Scan_Bridge_Slot...: 0x18.00.12 */
-					scan_bridge_slot(bus, BridgeInfo);
-				} else
-					printk("PCI: Invalid Bridge Configuration(0x%02X)",
-						BridgeInfo->busUnitInfo.deviceType);
-			}
-		} else if (HvRc != 0x000B)
-			pci_Log_Error("EADs Connect",
-					bus, SubBus, AgentId, HvRc);
-	}
-	kfree(BridgeInfo);
-}
-
-/*
- * This assumes that the node slot is always on the primary bus!
- */
-static int scan_bridge_slot(HvBusNumber Bus,
-		struct HvCallPci_BridgeInfo *BridgeInfo)
-{
-	struct device_node *node;
-	HvSubBusNumber SubBus = BridgeInfo->subBusNumber;
-	u16 VendorId = 0;
-	int HvRc = 0;
-	u8 Irq = 0;
-	int IdSel = ISERIES_GET_DEVICE_FROM_SUBBUS(SubBus);
-	int Function = ISERIES_GET_FUNCTION_FROM_SUBBUS(SubBus);
-	HvAgentId EADsIdSel = ISERIES_PCI_AGENTID(IdSel, Function);
-
-	/* iSeries_allocate_IRQ.: 0x18.00.12(0xA3) */
-	Irq = iSeries_allocate_IRQ(Bus, 0, EADsIdSel);
-
-	/*
-	 * Connect all functions of any device found.
-	 */
-	for (IdSel = 1; IdSel <= BridgeInfo->maxAgents; ++IdSel) {
-		for (Function = 0; Function < 8; ++Function) {
-			HvAgentId AgentId = ISERIES_PCI_AGENTID(IdSel, Function);
-			HvRc = HvCallXm_connectBusUnit(Bus, SubBus,
-					AgentId, Irq);
-			if (HvRc != 0) {
-				pci_Log_Error("Connect Bus Unit",
-					      Bus, SubBus, AgentId, HvRc);
-				continue;
-			}
-
-			HvRc = HvCallPci_configLoad16(Bus, SubBus, AgentId,
-						      PCI_VENDOR_ID, &VendorId);
-			if (HvRc != 0) {
-				pci_Log_Error("Read Vendor",
-					      Bus, SubBus, AgentId, HvRc);
-				continue;
-			}
-			printk("read vendor ID: %x\n", VendorId);
-
-			/* FoundDevice: 0x18.28.10 = 0x12AE */
-			HvRc = HvCallPci_configStore8(Bus, SubBus, AgentId,
-						      PCI_INTERRUPT_LINE, Irq);
-			if (HvRc != 0)
-				pci_Log_Error("PciCfgStore Irq Failed!",
-					      Bus, SubBus, AgentId, HvRc);
-
-			++DeviceCount;
-			node = build_device_node(Bus, SubBus, EADsIdSel, Function);
-			PCI_DN(node)->Irq = Irq;
-			PCI_DN(node)->LogicalSlot = BridgeInfo->logicalSlotNumber;
-
-		} /* for (Function = 0; Function < 8; ++Function) */
-	} /* for (IdSel = 1; IdSel <= MaxAgents; ++IdSel) */
-	return HvRc;
-}
-
-/*
  * I/0 Memory copy MUST use mmio commands on iSeries
  * To do; For performance, include the hv call directly
  */
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index fd6d0eb..d83f5ed 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -66,6 +66,8 @@ #include "processor_vpd.h"
 #include "main_store.h"
 #include "call_sm.h"
 #include "call_hpt.h"
+#include "call_pci.h"
+#include "pci.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1000,6 +1002,207 @@ void dt_vdevices(struct iseries_flat_dt 
 	dt_end_node(dt);
 }
 
+/*
+ * This assumes that the node slot is always on the primary bus!
+ */
+static void scan_bridge_slot(struct iseries_flat_dt *dt, HvBusNumber bus,
+		struct HvCallPci_BridgeInfo *bridge_info)
+{
+	HvSubBusNumber sub_bus = bridge_info->subBusNumber;
+	u16 vendor_id;
+	u16 device_id;
+	u32 class_id;
+	int err;
+	char buf[32];
+	u32 reg[5];
+	int id_sel = ISERIES_GET_DEVICE_FROM_SUBBUS(sub_bus);
+	int function = ISERIES_GET_FUNCTION_FROM_SUBBUS(sub_bus);
+	HvAgentId eads_id_sel = ISERIES_PCI_AGENTID(id_sel, function);
+
+	/*
+	 * Connect all functions of any device found.
+	 */
+	for (id_sel = 1; id_sel <= bridge_info->maxAgents; id_sel++) {
+		for (function = 0; function < 8; function++) {
+			u8 devfn;
+
+			HvAgentId agent_id = ISERIES_PCI_AGENTID(id_sel,
+					function);
+			err = HvCallXm_connectBusUnit(bus, sub_bus,
+					agent_id, 0);
+			if (err) {
+				if (err != 0x302)
+					printk(KERN_DEBUG
+						"connectBusUnit(%x, %x, %x) "
+						"== %x\n",
+						bus, sub_bus, agent_id, err);
+				continue;
+			}
+
+			err = HvCallPci_configLoad16(bus, sub_bus, agent_id,
+					PCI_VENDOR_ID, &vendor_id);
+			if (err) {
+				printk(KERN_DEBUG
+					"ReadVendor(%x, %x, %x) == %x\n",
+					bus, sub_bus, agent_id, err);
+				continue;
+			}
+			err = HvCallPci_configLoad16(bus, sub_bus, agent_id,
+					PCI_DEVICE_ID, &device_id);
+			if (err) {
+				printk(KERN_DEBUG
+					"ReadDevice(%x, %x, %x) == %x\n",
+					bus, sub_bus, agent_id, err);
+				continue;
+			}
+			err = HvCallPci_configLoad32(bus, sub_bus, agent_id,
+					PCI_CLASS_REVISION , &class_id);
+			if (err) {
+				printk(KERN_DEBUG
+					"ReadClass(%x, %x, %x) == %x\n",
+					bus, sub_bus, agent_id, err);
+				continue;
+			}
+
+			devfn = PCI_DEVFN(ISERIES_ENCODE_DEVICE(eads_id_sel),
+					function);
+			if (function == 0)
+				snprintf(buf, sizeof(buf), "pci@%x",
+						PCI_SLOT(devfn));
+			else
+				snprintf(buf, sizeof(buf), "pci@%x,%d",
+						PCI_SLOT(devfn), function);
+			dt_start_node(dt, buf);
+			reg[0] = (bus << 18) | (devfn << 8);
+			reg[1] = 0;
+			reg[2] = 0;
+			reg[3] = 0;
+			reg[4] = 0;
+			dt_prop_u32_list(dt, "reg", reg, 5);
+			dt_prop_u32(dt, "vendor-id", vendor_id);
+			dt_prop_u32(dt, "device-id", device_id);
+			dt_prop_u32(dt, "class-code", class_id >> 8);
+			dt_prop_u32(dt, "revision-id", class_id & 0xff);
+			dt_prop_u32(dt, "linux,subbus", sub_bus);
+			dt_prop_u32(dt, "linux,agent-id", agent_id);
+			dt_prop_u32(dt, "linux,logical-slot-number",
+					bridge_info->logicalSlotNumber);
+			dt_end_node(dt);
+
+		}
+	}
+}
+
+static void scan_bridge(struct iseries_flat_dt *dt, HvBusNumber bus,
+		HvSubBusNumber sub_bus, int id_sel)
+{
+	struct HvCallPci_BridgeInfo bridge_info;
+	HvAgentId agent_id;
+	int function;
+	int ret;
+
+	/* Note: hvSubBus and irq is always be 0 at this level! */
+	for (function = 0; function < 8; ++function) {
+		agent_id = ISERIES_PCI_AGENTID(id_sel, function);
+		ret = HvCallXm_connectBusUnit(bus, sub_bus, agent_id, 0);
+		if (ret != 0) {
+			if (ret != 0xb)
+				printk(KERN_DEBUG "connectBusUnit(%x, %x, %x) "
+						"== %x\n",
+						bus, sub_bus, agent_id, ret);
+			continue;
+		}
+		printk("found device at bus %d idsel %d func %d (AgentId %x)\n",
+				bus, id_sel, function, agent_id);
+		ret = HvCallPci_getBusUnitInfo(bus, sub_bus, agent_id,
+				iseries_hv_addr(&bridge_info),
+				sizeof(struct HvCallPci_BridgeInfo));
+		if (ret != 0)
+			continue;
+		printk("bridge info: type %x subbus %x "
+			"maxAgents %x maxsubbus %x logslot %x\n",
+			bridge_info.busUnitInfo.deviceType,
+			bridge_info.subBusNumber,
+			bridge_info.maxAgents,
+			bridge_info.maxSubBusNumber,
+			bridge_info.logicalSlotNumber);
+		if (bridge_info.busUnitInfo.deviceType ==
+				HvCallPci_BridgeDevice)
+			scan_bridge_slot(dt, bus, &bridge_info);
+		else
+			printk("PCI: Invalid Bridge Configuration(0x%02X)",
+				bridge_info.busUnitInfo.deviceType);
+	}
+}
+
+static void scan_phb(struct iseries_flat_dt *dt, HvBusNumber bus)
+{
+	struct HvCallPci_DeviceInfo dev_info;
+	const HvSubBusNumber sub_bus = 0;	/* EADs is always 0. */
+	int err;
+	int id_sel;
+	const int max_agents = 8;
+
+	/*
+	 * Probe for EADs Bridges
+	 */
+	for (id_sel = 1; id_sel < max_agents; ++id_sel) {
+		err = HvCallPci_getDeviceInfo(bus, sub_bus, id_sel,
+				iseries_hv_addr(&dev_info),
+				sizeof(struct HvCallPci_DeviceInfo));
+		if (err) {
+			if (err != 0x302)
+				printk(KERN_DEBUG "getDeviceInfo(%x, %x, %x) "
+						"== %x\n",
+						bus, sub_bus, id_sel, err);
+			continue;
+		}
+		if (dev_info.deviceType != HvCallPci_NodeDevice) {
+			printk(KERN_DEBUG "PCI: Invalid System Configuration"
+					"(0x%02X) for bus 0x%02x id 0x%02x.\n",
+					dev_info.deviceType, bus, id_sel);
+			continue;
+		}
+		scan_bridge(dt, bus, sub_bus, id_sel);
+	}
+}
+
+static void dt_pci_devices(struct iseries_flat_dt *dt)
+{
+	HvBusNumber bus;
+	char buf[32];
+	u32 buses[2];
+	int phb_num = 0;
+
+	/* Check all possible buses. */
+	for (bus = 0; bus < 256; bus++) {
+		int err = HvCallXm_testBus(bus);
+
+		if (err) {
+			/*
+			 * Check for Unexpected Return code, a clue that
+			 * something has gone wrong.
+			 */
+			if (err != 0x0301)
+				printk(KERN_ERR "Unexpected Return on Probe"
+						"(0x%02X): 0x%04X", bus, err);
+			continue;
+		}
+		printk("bus %d appears to exist\n", bus);
+		snprintf(buf, 32, "pci@%d", phb_num);
+		dt_start_node(dt, buf);
+		dt_prop_str(dt, "device_type", "pci");
+		dt_prop_str(dt, "compatible", "IBM,iSeries-Logical-PHB");
+		dt_prop_u32(dt, "#address-cells", 3);
+		dt_prop_u32(dt, "#size-cells", 2);
+		buses[0] = buses[1] = bus;
+		dt_prop_u32_list(dt, "bus-range", buses, 2);
+		scan_phb(dt, bus);
+		dt_end_node(dt);
+		phb_num++;
+	}
+}
+
 void build_flat_dt(struct iseries_flat_dt *dt, unsigned long phys_mem_size)
 {
 	u64 tmp[2];
@@ -1029,6 +1232,7 @@ void build_flat_dt(struct iseries_flat_d
 	dt_cpus(dt);
 
 	dt_vdevices(dt);
+	dt_pci_devices(dt);
 
 	dt_end_node(dt);
 
-- 
1.3.1.ge923
