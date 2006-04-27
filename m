Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 67429679F4
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:14 +1000 (EST)
Received: from localhost (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 4AF853682CD
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:14 +1000 (EST)
Date: Thu, 27 Apr 2006 17:09:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc: add all the iSeries virtual devices to the
	device tree
Message-Id: <20060427170902.51a5a098.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We do this by putting them in the flattened device tree at setup time.
This required the flattened device tree blob to be made bigger.

Currenly we don't do anything with these.

Also make a function static.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/setup.c |   88 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/iseries/vio.c   |    2 -
 2 files changed, 88 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

ea41f9a9099decfb4f7b9c061e7e38defa6b4744
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 3c51448..4862b8e 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -28,6 +28,7 @@ #include <linux/kdev_t.h>
 #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/kernel.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -45,6 +46,7 @@ #include <asm/paca.h>
 #include <asm/cache.h>
 #include <asm/sections.h>
 #include <asm/abs_addr.h>
+#include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_call_event.h>
 #include <asm/iseries/hv_call_xm.h>
@@ -710,7 +712,7 @@ define_machine(iseries) {
 };
 
 struct blob {
-	unsigned char data[PAGE_SIZE];
+	unsigned char data[PAGE_SIZE * 2];
 	unsigned long next;
 };
 
@@ -911,6 +913,88 @@ void dt_model(struct iseries_flat_dt *dt
 	dt_prop_str(dt, "compatible", "IBM,iSeries");
 }
 
+void dt_vdevices(struct iseries_flat_dt *dt)
+{
+	u32 reg = 0;
+	HvLpIndexMap vlan_map;
+	int i;
+	char buf[32];
+
+	dt_start_node(dt, "vdevice");
+	dt_prop_u32(dt, "#address-cells", 1);
+	dt_prop_u32(dt, "#size-cells", 0);
+
+	snprintf(buf, sizeof(buf), "viocons@%08x", reg);
+	dt_start_node(dt, buf);
+	dt_prop_str(dt, "device_type", "serial");
+	dt_prop_empty(dt, "compatible");
+	dt_prop_u32(dt, "reg", reg);
+	dt_end_node(dt);
+	reg++;
+
+	snprintf(buf, sizeof(buf), "v-scsi@%08x", reg);
+	dt_start_node(dt, buf);
+	dt_prop_str(dt, "device_type", "vscsi");
+	dt_prop_str(dt, "compatible", "IBM,v-scsi");
+	dt_prop_u32(dt, "reg", reg);
+	dt_end_node(dt);
+	reg++;
+
+	vlan_map = HvLpConfig_getVirtualLanIndexMap();
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
+		unsigned char mac_addr[ETH_ALEN];
+
+		if ((vlan_map & (0x8000 >> i)) == 0)
+			continue;
+		snprintf(buf, 32, "vlan@%08x", reg + i);
+		dt_start_node(dt, buf);
+		dt_prop_str(dt, "device_type", "vlan");
+		dt_prop_empty(dt, "compatible");
+		dt_prop_u32(dt, "reg", reg + i);
+
+		mac_addr[0] = 0x02;
+		mac_addr[1] = 0x01;
+		mac_addr[2] = 0xff;
+		mac_addr[3] = i;
+		mac_addr[4] = 0xff;
+		mac_addr[5] = HvLpConfig_getLpIndex_outline();
+		dt_prop(dt, "local-mac-address", (char *)mac_addr, ETH_ALEN);
+		dt_prop(dt, "mac-address", (char *)mac_addr, ETH_ALEN);
+
+		dt_end_node(dt);
+	}
+	reg += HVMAXARCHITECTEDVIRTUALLANS;
+
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++) {
+		snprintf(buf, 32, "viodasd@%08x", reg + i);
+		dt_start_node(dt, buf);
+		dt_prop_str(dt, "device_type", "viodasd");
+		dt_prop_empty(dt, "compatible");
+		dt_prop_u32(dt, "reg", reg + i);
+		dt_end_node(dt);
+	}
+	reg += HVMAXARCHITECTEDVIRTUALDISKS;
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++) {
+		snprintf(buf, 32, "viocd@%08x", reg + i);
+		dt_start_node(dt, buf);
+		dt_prop_str(dt, "device_type", "viocd");
+		dt_prop_empty(dt, "compatible");
+		dt_prop_u32(dt, "reg", reg + i);
+		dt_end_node(dt);
+	}
+	reg += HVMAXARCHITECTEDVIRTUALCDROMS;
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++) {
+		snprintf(buf, 32, "viotape@%08x", reg + i);
+		dt_start_node(dt, buf);
+		dt_prop_str(dt, "device_type", "viotape");
+		dt_prop_empty(dt, "compatible");
+		dt_prop_u32(dt, "reg", reg + i);
+		dt_end_node(dt);
+	}
+
+	dt_end_node(dt);
+}
+
 void build_flat_dt(struct iseries_flat_dt *dt, unsigned long phys_mem_size)
 {
 	u64 tmp[2];
@@ -941,6 +1025,8 @@ void build_flat_dt(struct iseries_flat_d
 
 	dt_cpus(dt);
 
+	dt_vdevices(dt);
+
 	dt_end_node(dt);
 
 	dt_push_u32(dt, OF_DT_END);
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index ad36ab0..22045a2 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -71,7 +71,7 @@ static struct vio_dev *__init vio_regist
 	return viodev;
 }
 
-void __init probe_bus_iseries(void)
+static void __init probe_bus_iseries(void)
 {
 	HvLpIndexMap vlan_map;
 	struct vio_dev *viodev;
-- 
1.3.1
