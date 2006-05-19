Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B427567B1F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:10:56 +1000 (EST)
Date: Fri, 19 May 2006 16:58:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 10/14] powerpc: give iSeries device tree nodes better names
Message-Id: <20060519165813.6e06ec93.sfr@canb.auug.org.au>
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

Use the PCI class code to choose a name for the PCI device nodes and
to guess a device_type.  Failing that, base the name on the vendor and
device ids as specified in the spec.

Mark just about everything __init{data}.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/setup.c |   95 ++++++++++++++++++++++----------
 1 files changed, 66 insertions(+), 29 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

753e3e7ff975a03dbcc5a761041f0f855215e7c5
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 9586414..5661bd0 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -725,7 +725,7 @@ struct iseries_flat_dt {
 
 static struct iseries_flat_dt iseries_dt;
 
-static void dt_init(struct iseries_flat_dt *dt)
+static void __init dt_init(struct iseries_flat_dt *dt)
 {
 	dt->header.off_mem_rsvmap =
 		offsetof(struct iseries_flat_dt, reserve_map);
@@ -748,7 +748,7 @@ static void dt_init(struct iseries_flat_
 	dt->reserve_map[1] = 0;
 }
 
-static void dt_check_blob(struct blob *b)
+static void __init dt_check_blob(struct blob *b)
 {
 	if (b->next >= (unsigned long)&b->next) {
 		DBG("Ran out of space in flat device tree blob!\n");
@@ -756,7 +756,7 @@ static void dt_check_blob(struct blob *b
 	}
 }
 
-static void dt_push_u32(struct iseries_flat_dt *dt, u32 value)
+static void __init dt_push_u32(struct iseries_flat_dt *dt, u32 value)
 {
 	*((u32*)dt->dt.next) = value;
 	dt->dt.next += sizeof(u32);
@@ -765,7 +765,7 @@ static void dt_push_u32(struct iseries_f
 }
 
 #ifdef notyet
-static void dt_push_u64(struct iseries_flat_dt *dt, u64 value)
+static void __init dt_push_u64(struct iseries_flat_dt *dt, u64 value)
 {
 	*((u64*)dt->dt.next) = value;
 	dt->dt.next += sizeof(u64);
@@ -774,7 +774,7 @@ static void dt_push_u64(struct iseries_f
 }
 #endif
 
-static unsigned long dt_push_bytes(struct blob *blob, char *data, int len)
+static unsigned long __init dt_push_bytes(struct blob *blob, char *data, int len)
 {
 	unsigned long start = blob->next - (unsigned long)blob->data;
 
@@ -786,7 +786,7 @@ static unsigned long dt_push_bytes(struc
 	return start;
 }
 
-static void dt_start_node(struct iseries_flat_dt *dt, char *name)
+static void __init dt_start_node(struct iseries_flat_dt *dt, char *name)
 {
 	dt_push_u32(dt, OF_DT_BEGIN_NODE);
 	dt_push_bytes(&dt->dt, name, strlen(name) + 1);
@@ -794,7 +794,8 @@ static void dt_start_node(struct iseries
 
 #define dt_end_node(dt) dt_push_u32(dt, OF_DT_END_NODE)
 
-static void dt_prop(struct iseries_flat_dt *dt, char *name, char *data, int len)
+static void __init dt_prop(struct iseries_flat_dt *dt, char *name,
+		char *data, int len)
 {
 	unsigned long offset;
 
@@ -813,39 +814,42 @@ static void dt_prop(struct iseries_flat_
 	dt_push_bytes(&dt->dt, data, len);
 }
 
-static void dt_prop_str(struct iseries_flat_dt *dt, char *name, char *data)
+static void __init dt_prop_str(struct iseries_flat_dt *dt, char *name,
+		char *data)
 {
 	dt_prop(dt, name, data, strlen(data) + 1); /* + 1 for NULL */
 }
 
-static void dt_prop_u32(struct iseries_flat_dt *dt, char *name, u32 data)
+static void __init dt_prop_u32(struct iseries_flat_dt *dt, char *name, u32 data)
 {
 	dt_prop(dt, name, (char *)&data, sizeof(u32));
 }
 
-static void dt_prop_u64(struct iseries_flat_dt *dt, char *name, u64 data)
+static void __init dt_prop_u64(struct iseries_flat_dt *dt, char *name, u64 data)
 {
 	dt_prop(dt, name, (char *)&data, sizeof(u64));
 }
 
-static void dt_prop_u64_list(struct iseries_flat_dt *dt, char *name, u64 *data, int n)
+static void __init dt_prop_u64_list(struct iseries_flat_dt *dt, char *name,
+		u64 *data, int n)
 {
 	dt_prop(dt, name, (char *)data, sizeof(u64) * n);
 }
 
-static void dt_prop_u32_list(struct iseries_flat_dt *dt, char *name, u32 *data, int n)
+static void __init dt_prop_u32_list(struct iseries_flat_dt *dt, char *name,
+		u32 *data, int n)
 {
 	dt_prop(dt, name, (char *)data, sizeof(u32) * n);
 }
 
 #ifdef notyet
-static void dt_prop_empty(struct iseries_flat_dt *dt, char *name)
+static void __init dt_prop_empty(struct iseries_flat_dt *dt, char *name)
 {
 	dt_prop(dt, name, NULL, 0);
 }
 #endif
 
-static void dt_cpus(struct iseries_flat_dt *dt)
+static void __init dt_cpus(struct iseries_flat_dt *dt)
 {
 	unsigned char buf[32];
 	unsigned char *p;
@@ -899,7 +903,7 @@ static void dt_cpus(struct iseries_flat_
 	dt_end_node(dt);
 }
 
-static void dt_model(struct iseries_flat_dt *dt)
+static void __init dt_model(struct iseries_flat_dt *dt)
 {
 	char buf[16] = "IBM,";
 
@@ -917,7 +921,7 @@ static void dt_model(struct iseries_flat
 	dt_prop_str(dt, "compatible", "IBM,iSeries");
 }
 
-static void dt_vdevices(struct iseries_flat_dt *dt)
+static void __init dt_vdevices(struct iseries_flat_dt *dt)
 {
 	u32 reg = 0;
 	HvLpIndexMap vlan_map;
@@ -1006,11 +1010,32 @@ static void dt_vdevices(struct iseries_f
 	dt_end_node(dt);
 }
 
+struct pci_class_name {
+	u16 code;
+	char *name;
+	char *type;
+};
+
+static struct pci_class_name __initdata pci_class_name[] = {
+	{ PCI_CLASS_NETWORK_ETHERNET, "ethernet", "network" },
+};
+
+static struct pci_class_name * __init dt_find_pci_class_name(u16 class_code)
+{
+	struct pci_class_name *cp;
+
+	for (cp = pci_class_name;
+			cp < &pci_class_name[ARRAY_SIZE(pci_class_name)]; cp++)
+		if (cp->code == class_code)
+			return cp;
+	return NULL;
+}
+
 /*
  * This assumes that the node slot is always on the primary bus!
  */
-static void scan_bridge_slot(struct iseries_flat_dt *dt, HvBusNumber bus,
-		struct HvCallPci_BridgeInfo *bridge_info)
+static void __init scan_bridge_slot(struct iseries_flat_dt *dt,
+		HvBusNumber bus, struct HvCallPci_BridgeInfo *bridge_info)
 {
 	HvSubBusNumber sub_bus = bridge_info->subBusNumber;
 	u16 vendor_id;
@@ -1022,14 +1047,14 @@ static void scan_bridge_slot(struct iser
 	int id_sel = ISERIES_GET_DEVICE_FROM_SUBBUS(sub_bus);
 	int function = ISERIES_GET_FUNCTION_FROM_SUBBUS(sub_bus);
 	HvAgentId eads_id_sel = ISERIES_PCI_AGENTID(id_sel, function);
+	u8 devfn;
+	struct pci_class_name *cp;
 
 	/*
 	 * Connect all functions of any device found.
 	 */
 	for (id_sel = 1; id_sel <= bridge_info->maxAgents; id_sel++) {
 		for (function = 0; function < 8; function++) {
-			u8 devfn;
-
 			HvAgentId agent_id = ISERIES_PCI_AGENTID(id_sel,
 					function);
 			err = HvCallXm_connectBusUnit(bus, sub_bus,
@@ -1070,12 +1095,20 @@ static void scan_bridge_slot(struct iser
 
 			devfn = PCI_DEVFN(ISERIES_ENCODE_DEVICE(eads_id_sel),
 					function);
-			if (function == 0)
-				snprintf(buf, sizeof(buf), "pci@%x",
-						PCI_SLOT(devfn));
+			cp = dt_find_pci_class_name(class_id >> 16);
+			if (cp && cp->name)
+				strncpy(buf, cp->name, sizeof(buf) - 1);
 			else
-				snprintf(buf, sizeof(buf), "pci@%x,%d",
-						PCI_SLOT(devfn), function);
+				snprintf(buf, sizeof(buf), "pci%x,%x",
+						vendor_id, device_id);
+			buf[sizeof(buf) - 1] = '\0';
+			snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf),
+					"@%x", PCI_SLOT(devfn));
+			buf[sizeof(buf) - 1] = '\0';
+			if (function != 0)
+				snprintf(buf + strlen(buf),
+					sizeof(buf) - strlen(buf),
+					",%x", function);
 			dt_start_node(dt, buf);
 			reg[0] = (bus << 16) | (devfn << 8);
 			reg[1] = 0;
@@ -1083,6 +1116,9 @@ static void scan_bridge_slot(struct iser
 			reg[3] = 0;
 			reg[4] = 0;
 			dt_prop_u32_list(dt, "reg", reg, 5);
+			if (cp && (cp->type || cp->name))
+				dt_prop_str(dt, "device_type",
+					cp->type ? cp->type : cp->name);
 			dt_prop_u32(dt, "vendor-id", vendor_id);
 			dt_prop_u32(dt, "device-id", device_id);
 			dt_prop_u32(dt, "class-code", class_id >> 8);
@@ -1097,7 +1133,7 @@ static void scan_bridge_slot(struct iser
 	}
 }
 
-static void scan_bridge(struct iseries_flat_dt *dt, HvBusNumber bus,
+static void __init scan_bridge(struct iseries_flat_dt *dt, HvBusNumber bus,
 		HvSubBusNumber sub_bus, int id_sel)
 {
 	struct HvCallPci_BridgeInfo bridge_info;
@@ -1139,7 +1175,7 @@ static void scan_bridge(struct iseries_f
 	}
 }
 
-static void scan_phb(struct iseries_flat_dt *dt, HvBusNumber bus)
+static void __init scan_phb(struct iseries_flat_dt *dt, HvBusNumber bus)
 {
 	struct HvCallPci_DeviceInfo dev_info;
 	const HvSubBusNumber sub_bus = 0;	/* EADs is always 0. */
@@ -1171,7 +1207,7 @@ static void scan_phb(struct iseries_flat
 	}
 }
 
-static void dt_pci_devices(struct iseries_flat_dt *dt)
+static void __init dt_pci_devices(struct iseries_flat_dt *dt)
 {
 	HvBusNumber bus;
 	char buf[32];
@@ -1207,7 +1243,8 @@ static void dt_pci_devices(struct iserie
 	}
 }
 
-static void build_flat_dt(struct iseries_flat_dt *dt, unsigned long phys_mem_size)
+static void __init build_flat_dt(struct iseries_flat_dt *dt,
+		unsigned long phys_mem_size)
 {
 	u64 tmp[2];
 
-- 
1.3.1.ge923
