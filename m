Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BAAC66846F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:11:58 +1000 (EST)
Date: Fri, 19 May 2006 17:06:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 14/14] powerpc: cleanup of iSeries flat device tree
Message-Id: <20060519170638.7d47ec13.sfr@canb.auug.org.au>
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

Consolidate the vio device node creation.  Make some parameters const.
Make a few more things __initdata. Get the device_type strings out of
the device tree blob.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/dt.c |  199 ++++++++++++++++++-----------------
 1 files changed, 101 insertions(+), 98 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

89435c92f9a6d37d8d47bf40acde012726780f7f
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 2a51ec1..d3444aa 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -47,16 +47,34 @@ #else
 #define DBG(fmt...)
 #endif
 
+/*
+ * These are created by the linker script at the start and end
+ * of the section containing all the strings from this file.
+ */
 extern char __dt_strings_start[];
 extern char __dt_strings_end[];
 
 struct iseries_flat_dt {
 	struct boot_param_header header;
 	u64 reserve_map[2];
-	void *data;
 };
 
-static struct iseries_flat_dt *iseries_dt;
+static void * __initdata dt_data;
+
+/*
+ * Putting these strings here keeps them out of the section
+ * that we rename to .dt_strings using objcopy and capture
+ * for the strings blob of the flattened device tree.
+ */
+static char __initdata device_type_cpu[] = "cpu";
+static char __initdata device_type_memory[] = "memory";
+static char __initdata device_type_serial[] = "serial";
+static char __initdata device_type_network[] = "network";
+static char __initdata device_type_block[] = "block";
+static char __initdata device_type_byte[] = "byte";
+static char __initdata device_type_pci[] = "pci";
+static char __initdata device_type_vdevice[] = "vdevice";
+static char __initdata device_type_vscsi[] = "vscsi";
 
 static struct iseries_flat_dt * __init dt_init(void)
 {
@@ -70,7 +88,7 @@ static struct iseries_flat_dt * __init d
 	dt->header.off_dt_strings = ALIGN(sizeof(*dt), 8);
 	dt->header.off_dt_struct = dt->header.off_dt_strings
 		+ ALIGN(str_len, 8);
-	dt->data = (void *)((unsigned long)dt + dt->header.off_dt_struct);
+	dt_data = (void *)((unsigned long)dt + dt->header.off_dt_struct);
 	dt->header.dt_strings_size = str_len;
 
 	/* There is no notion of hardware cpu id on iSeries */
@@ -91,26 +109,26 @@ static struct iseries_flat_dt * __init d
 
 static void __init dt_push_u32(struct iseries_flat_dt *dt, u32 value)
 {
-	*((u32 *)dt->data) = value;
-	dt->data += sizeof(u32);
+	*((u32 *)dt_data) = value;
+	dt_data += sizeof(u32);
 }
 
 #ifdef notyet
 static void __init dt_push_u64(struct iseries_flat_dt *dt, u64 value)
 {
-	*((u64 *)dt->data) = value;
-	dt->data += sizeof(u64);
+	*((u64 *)dt_data) = value;
+	dt_data += sizeof(u64);
 }
 #endif
 
-static void __init dt_push_bytes(struct iseries_flat_dt *dt, char *data,
+static void __init dt_push_bytes(struct iseries_flat_dt *dt, const char *data,
 		int len)
 {
-	memcpy(dt->data, data, len);
-	dt->data += ALIGN(len, 4);
+	memcpy(dt_data, data, len);
+	dt_data += ALIGN(len, 4);
 }
 
-static void __init dt_start_node(struct iseries_flat_dt *dt, char *name)
+static void __init dt_start_node(struct iseries_flat_dt *dt, const char *name)
 {
 	dt_push_u32(dt, OF_DT_BEGIN_NODE);
 	dt_push_bytes(dt, name, strlen(name) + 1);
@@ -118,8 +136,8 @@ static void __init dt_start_node(struct 
 
 #define dt_end_node(dt) dt_push_u32(dt, OF_DT_END_NODE)
 
-static void __init dt_prop(struct iseries_flat_dt *dt, char *name,
-		void *data, int len)
+static void __init dt_prop(struct iseries_flat_dt *dt, const char *name,
+		const void *data, int len)
 {
 	unsigned long offset;
 
@@ -137,36 +155,40 @@ static void __init dt_prop(struct iserie
 	dt_push_bytes(dt, data, len);
 }
 
-static void __init dt_prop_str(struct iseries_flat_dt *dt, char *name,
-		char *data)
+static void __init dt_prop_str(struct iseries_flat_dt *dt, const char *name,
+		const char *data)
 {
 	dt_prop(dt, name, data, strlen(data) + 1); /* + 1 for NULL */
 }
 
-static void __init dt_prop_u32(struct iseries_flat_dt *dt, char *name, u32 data)
+static void __init dt_prop_u32(struct iseries_flat_dt *dt, const char *name,
+		u32 data)
 {
 	dt_prop(dt, name, &data, sizeof(u32));
 }
 
-static void __init dt_prop_u64(struct iseries_flat_dt *dt, char *name, u64 data)
+#ifdef notyet
+static void __init dt_prop_u64(struct iseries_flat_dt *dt, const char *name,
+		u64 data)
 {
 	dt_prop(dt, name, &data, sizeof(u64));
 }
+#endif
 
-static void __init dt_prop_u64_list(struct iseries_flat_dt *dt, char *name,
-		u64 *data, int n)
+static void __init dt_prop_u64_list(struct iseries_flat_dt *dt,
+		const char *name, u64 *data, int n)
 {
 	dt_prop(dt, name, data, sizeof(u64) * n);
 }
 
-static void __init dt_prop_u32_list(struct iseries_flat_dt *dt, char *name,
-		u32 *data, int n)
+static void __init dt_prop_u32_list(struct iseries_flat_dt *dt,
+		const char *name, u32 *data, int n)
 {
 	dt_prop(dt, name, data, sizeof(u32) * n);
 }
 
 #ifdef notyet
-static void __init dt_prop_empty(struct iseries_flat_dt *dt, char *name)
+static void __init dt_prop_empty(struct iseries_flat_dt *dt, const char *name)
 {
 	dt_prop(dt, name, NULL, 0);
 }
@@ -199,7 +221,7 @@ static void __init dt_cpus(struct iserie
 		snprintf(p, 32 - (p - buf), "@%d", i);
 		dt_start_node(dt, buf);
 
-		dt_prop_str(dt, "device_type", "cpu");
+		dt_prop_str(dt, "device_type", device_type_cpu);
 
 		index = lppaca[i].dyn_hv_phys_proc_index;
 		d = &xIoHriProcessorVpd[index];
@@ -244,32 +266,41 @@ static void __init dt_model(struct iseri
 	dt_prop_str(dt, "compatible", "IBM,iSeries");
 }
 
+static void __init dt_do_vdevice(struct iseries_flat_dt *dt,
+		const char *name, u32 reg, int unit,
+		const char *type, const char *compat, int end)
+{
+	char buf[32];
+
+	snprintf(buf, 32, "%s@%08x", name, reg + ((unit >= 0) ? unit : 0));
+	dt_start_node(dt, buf);
+	dt_prop_str(dt, "device_type", type);
+	if (compat)
+		dt_prop_str(dt, "compatible", compat);
+	dt_prop_u32(dt, "reg", reg + ((unit >= 0) ? unit : 0));
+	if (unit >= 0)
+		dt_prop_u32(dt, "linux,unit_address", unit);
+	if (end)
+		dt_end_node(dt);
+}
+
 static void __init dt_vdevices(struct iseries_flat_dt *dt)
 {
 	u32 reg = 0;
 	HvLpIndexMap vlan_map;
 	int i;
-	char buf[32];
 
 	dt_start_node(dt, "vdevice");
-	dt_prop_str(dt, "device_type", "vdevice");
+	dt_prop_str(dt, "device_type", device_type_vdevice);
 	dt_prop_str(dt, "compatible", "IBM,iSeries-vdevice");
 	dt_prop_u32(dt, "#address-cells", 1);
 	dt_prop_u32(dt, "#size-cells", 0);
 
-	snprintf(buf, sizeof(buf), "vty@%08x", reg);
-	dt_start_node(dt, buf);
-	dt_prop_str(dt, "device_type", "serial");
-	dt_prop_u32(dt, "reg", reg);
-	dt_end_node(dt);
+	dt_do_vdevice(dt, "vty", reg, -1, device_type_serial, NULL, 1);
 	reg++;
 
-	snprintf(buf, sizeof(buf), "v-scsi@%08x", reg);
-	dt_start_node(dt, buf);
-	dt_prop_str(dt, "device_type", "vscsi");
-	dt_prop_str(dt, "compatible", "IBM,v-scsi");
-	dt_prop_u32(dt, "reg", reg);
-	dt_end_node(dt);
+	dt_do_vdevice(dt, "v-scsi", reg, -1, device_type_vscsi,
+			"IBM,v-scsi", 1);
 	reg++;
 
 	vlan_map = HvLpConfig_getVirtualLanIndexMap();
@@ -278,13 +309,8 @@ static void __init dt_vdevices(struct is
 
 		if ((vlan_map & (0x8000 >> i)) == 0)
 			continue;
-		snprintf(buf, 32, "l-lan@%08x", reg + i);
-		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "network");
-		dt_prop_str(dt, "compatible", "IBM,iSeries-l-lan");
-		dt_prop_u32(dt, "reg", reg + i);
-		dt_prop_u32(dt, "linux,unit_address", i);
-
+		dt_do_vdevice(dt, "l-lan", reg, i, device_type_network,
+				"IBM,iSeries-l-lan", 0);
 		mac_addr[0] = 0x02;
 		mac_addr[1] = 0x01;
 		mac_addr[2] = 0xff;
@@ -300,47 +326,31 @@ static void __init dt_vdevices(struct is
 	}
 	reg += HVMAXARCHITECTEDVIRTUALLANS;
 
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++) {
-		snprintf(buf, 32, "viodasd@%08x", reg + i);
-		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "block");
-		dt_prop_str(dt, "compatible", "IBM,iSeries-viodasd");
-		dt_prop_u32(dt, "reg", reg + i);
-		dt_prop_u32(dt, "linux,unit_address", i);
-		dt_end_node(dt);
-	}
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++)
+		dt_do_vdevice(dt, "viodasd", reg, i, device_type_block,
+				"IBM,iSeries-viodasd", 1);
 	reg += HVMAXARCHITECTEDVIRTUALDISKS;
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++) {
-		snprintf(buf, 32, "viocd@%08x", reg + i);
-		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "block");
-		dt_prop_str(dt, "compatible", "IBM,iSeries-viocd");
-		dt_prop_u32(dt, "reg", reg + i);
-		dt_prop_u32(dt, "linux,unit_address", i);
-		dt_end_node(dt);
-	}
+
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++)
+		dt_do_vdevice(dt, "viocd", reg, i, device_type_block,
+				"IBM,iSeries-viocd", 1);
 	reg += HVMAXARCHITECTEDVIRTUALCDROMS;
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++) {
-		snprintf(buf, 32, "viotape@%08x", reg + i);
-		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "byte");
-		dt_prop_str(dt, "compatible", "IBM,iSeries-viotape");
-		dt_prop_u32(dt, "reg", reg + i);
-		dt_prop_u32(dt, "linux,unit_address", i);
-		dt_end_node(dt);
-	}
+
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++)
+		dt_do_vdevice(dt, "viotape", reg, i, device_type_byte,
+				"IBM,iSeries-viotape", 1);
 
 	dt_end_node(dt);
 }
 
 struct pci_class_name {
 	u16 code;
-	char *name;
-	char *type;
+	const char *name;
+	const char *type;
 };
 
 static struct pci_class_name __initdata pci_class_name[] = {
-	{ PCI_CLASS_NETWORK_ETHERNET, "ethernet", "network" },
+	{ PCI_CLASS_NETWORK_ETHERNET, "ethernet", device_type_network },
 };
 
 static struct pci_class_name * __init dt_find_pci_class_name(u16 class_code)
@@ -384,9 +394,7 @@ static void __init scan_bridge_slot(stru
 					agent_id, 0);
 			if (err) {
 				if (err != 0x302)
-					printk(KERN_DEBUG
-						"connectBusUnit(%x, %x, %x) "
-						"== %x\n",
+					DBG("connectBusUnit(%x, %x, %x) %x\n",
 						bus, sub_bus, agent_id, err);
 				continue;
 			}
@@ -394,24 +402,21 @@ static void __init scan_bridge_slot(stru
 			err = HvCallPci_configLoad16(bus, sub_bus, agent_id,
 					PCI_VENDOR_ID, &vendor_id);
 			if (err) {
-				printk(KERN_DEBUG
-					"ReadVendor(%x, %x, %x) == %x\n",
+				DBG("ReadVendor(%x, %x, %x) %x\n",
 					bus, sub_bus, agent_id, err);
 				continue;
 			}
 			err = HvCallPci_configLoad16(bus, sub_bus, agent_id,
 					PCI_DEVICE_ID, &device_id);
 			if (err) {
-				printk(KERN_DEBUG
-					"ReadDevice(%x, %x, %x) == %x\n",
+				DBG("ReadDevice(%x, %x, %x) %x\n",
 					bus, sub_bus, agent_id, err);
 				continue;
 			}
 			err = HvCallPci_configLoad32(bus, sub_bus, agent_id,
 					PCI_CLASS_REVISION , &class_id);
 			if (err) {
-				printk(KERN_DEBUG
-					"ReadClass(%x, %x, %x) == %x\n",
+				DBG("ReadClass(%x, %x, %x) %x\n",
 					bus, sub_bus, agent_id, err);
 				continue;
 			}
@@ -470,19 +475,18 @@ static void __init scan_bridge(struct is
 		ret = HvCallXm_connectBusUnit(bus, sub_bus, agent_id, 0);
 		if (ret != 0) {
 			if (ret != 0xb)
-				printk(KERN_DEBUG "connectBusUnit(%x, %x, %x) "
-						"== %x\n",
+				DBG("connectBusUnit(%x, %x, %x) %x\n",
 						bus, sub_bus, agent_id, ret);
 			continue;
 		}
-		printk("found device at bus %d idsel %d func %d (AgentId %x)\n",
+		DBG("found device at bus %d idsel %d func %d (AgentId %x)\n",
 				bus, id_sel, function, agent_id);
 		ret = HvCallPci_getBusUnitInfo(bus, sub_bus, agent_id,
 				iseries_hv_addr(&bridge_info),
 				sizeof(struct HvCallPci_BridgeInfo));
 		if (ret != 0)
 			continue;
-		printk("bridge info: type %x subbus %x "
+		DBG("bridge info: type %x subbus %x "
 			"maxAgents %x maxsubbus %x logslot %x\n",
 			bridge_info.busUnitInfo.deviceType,
 			bridge_info.subBusNumber,
@@ -493,7 +497,7 @@ static void __init scan_bridge(struct is
 				HvCallPci_BridgeDevice)
 			scan_bridge_slot(dt, bus, &bridge_info);
 		else
-			printk("PCI: Invalid Bridge Configuration(0x%02X)",
+			DBG("PCI: Invalid Bridge Configuration(0x%02X)",
 				bridge_info.busUnitInfo.deviceType);
 	}
 }
@@ -515,13 +519,12 @@ static void __init scan_phb(struct iseri
 				sizeof(struct HvCallPci_DeviceInfo));
 		if (err) {
 			if (err != 0x302)
-				printk(KERN_DEBUG "getDeviceInfo(%x, %x, %x) "
-						"== %x\n",
+				DBG("getDeviceInfo(%x, %x, %x) %x\n",
 						bus, sub_bus, id_sel, err);
 			continue;
 		}
 		if (dev_info.deviceType != HvCallPci_NodeDevice) {
-			printk(KERN_DEBUG "PCI: Invalid System Configuration"
+			DBG("PCI: Invalid System Configuration"
 					"(0x%02X) for bus 0x%02x id 0x%02x.\n",
 					dev_info.deviceType, bus, id_sel);
 			continue;
@@ -547,14 +550,14 @@ static void __init dt_pci_devices(struct
 			 * something has gone wrong.
 			 */
 			if (err != 0x0301)
-				printk(KERN_ERR "Unexpected Return on Probe"
-						"(0x%02X): 0x%04X", bus, err);
+				DBG("Unexpected Return on Probe(0x%02X) "
+						"0x%04X\n", bus, err);
 			continue;
 		}
-		printk("bus %d appears to exist\n", bus);
+		DBG("bus %d appears to exist\n", bus);
 		snprintf(buf, 32, "pci@%d", phb_num);
 		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "pci");
+		dt_prop_str(dt, "device_type", device_type_pci);
 		dt_prop_str(dt, "compatible", "IBM,iSeries-Logical-PHB");
 		dt_prop_u32(dt, "#address-cells", 3);
 		dt_prop_u32(dt, "#size-cells", 2);
@@ -569,12 +572,13 @@ static void __init dt_pci_devices(struct
 static void dt_finish(struct iseries_flat_dt *dt)
 {
 	dt_push_u32(dt, OF_DT_END);
-	dt->header.totalsize = (unsigned long)dt->data - (unsigned long)dt;
-	klimit = ALIGN((unsigned long)dt->data, 8);
+	dt->header.totalsize = (unsigned long)dt_data - (unsigned long)dt;
+	klimit = ALIGN((unsigned long)dt_data, 8);
 }
 
 void * __init build_flat_dt(unsigned long phys_mem_size)
 {
+	struct iseries_flat_dt *iseries_dt;
 	u64 tmp[2];
 
 	iseries_dt = dt_init();
@@ -587,8 +591,7 @@ void * __init build_flat_dt(unsigned lon
 
 	/* /memory */
 	dt_start_node(iseries_dt, "memory@0");
-	dt_prop_str(iseries_dt, "name", "memory");
-	dt_prop_str(iseries_dt, "device_type", "memory");
+	dt_prop_str(iseries_dt, "device_type", device_type_memory);
 	tmp[0] = 0;
 	tmp[1] = phys_mem_size;
 	dt_prop_u64_list(iseries_dt, "reg", tmp, 2);
-- 
1.3.1.ge923
