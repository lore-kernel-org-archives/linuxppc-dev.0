Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail17-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CD6E5DDF3C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:16 +1100 (EST)
Message-ID: <47910CE6.8050901@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:38 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 12/16] PS3: Add logical performance monitor device support
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add PS3 logical performance monitor device support to the
PS3 system-bus and platform device registration routines.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2: o Add enum ps3_lpm_tb_type.
    o Remove redundant enclosing structure and return proper
      error codes from ps3_register_lpm_devices().
v3: o Add lpm.node_id to struct ps3_system_bus_device.
    o Cleanup repository discovery logic.


 arch/powerpc/platforms/ps3/device-init.c |   85 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/system-bus.c  |    5 +
 include/asm-powerpc/ps3.h                |    8 ++
 3 files changed, 98 insertions(+)
 create mode 100644 arch/powerpc/platforms/ps3/lpm.c

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -31,6 +31,89 @@
 
 #include "platform.h"
 
+static int __init ps3_register_lpm_devices(void)
+{
+	int result;
+	u64 tmp1;
+	u64 tmp2;
+	struct ps3_system_bus_device *dev;
+
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->match_id = PS3_MATCH_ID_LPM;
+	dev->dev_type = PS3_DEVICE_TYPE_LPM;
+
+	/* The current lpm driver only supports a single BE processor. */
+
+	result = ps3_repository_read_be_node_id(0, &dev->lpm.node_id);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_repository_read_be_node_id failed \n",
+			__func__, __LINE__);
+		goto fail_read_repo;
+	}
+
+	result = ps3_repository_read_lpm_privileges(dev->lpm.node_id, &tmp1,
+		&dev->lpm.rights);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_repository_read_lpm_privleges failed \n",
+			__func__, __LINE__);
+		goto fail_read_repo;
+	}
+
+	lv1_get_logical_partition_id(&tmp2);
+
+	if (tmp1 != tmp2) {
+		pr_debug("%s:%d: wrong lpar\n",
+			__func__, __LINE__);
+		result = -ENODEV;
+		goto fail_rights;
+	}
+
+	if (!(dev->lpm.rights & PS3_LPM_RIGHTS_USE_LPM)) {
+		pr_debug("%s:%d: don't have rights to use lpm\n",
+			__func__, __LINE__);
+		result = -EPERM;
+		goto fail_rights;
+	}
+
+	pr_debug("%s:%d: pu_id %lu, rights %lu(%lxh)\n",
+		__func__, __LINE__, dev->lpm.pu_id, dev->lpm.rights,
+		dev->lpm.rights);
+
+	result = ps3_repository_read_pu_id(0, &dev->lpm.pu_id);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_repository_read_pu_id failed \n",
+			__func__, __LINE__);
+		goto fail_read_repo;
+	}
+
+	result = ps3_system_bus_device_register(dev);
+
+	if (result) {
+		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
+			__func__, __LINE__);
+		goto fail_register;
+	}
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	return 0;
+
+
+fail_register:
+fail_rights:
+fail_read_repo:
+	kfree(dev);
+	pr_debug(" <- %s:%d: failed\n", __func__, __LINE__);
+	return result;
+}
+
 /**
  * ps3_setup_gelic_device - Setup and register a gelic device instance.
  *
@@ -827,6 +910,8 @@ static int __init ps3_register_devices(v
 
 	ps3_register_sound_devices();
 
+	ps3_register_lpm_devices();
+
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return 0;
 }
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -715,6 +715,7 @@ int ps3_system_bus_device_register(struc
 	static unsigned int dev_ioc0_count;
 	static unsigned int dev_sb_count;
 	static unsigned int dev_vuart_count;
+	static unsigned int dev_lpm_count;
 
 	if (!dev->core.parent)
 		dev->core.parent = &ps3_system_bus;
@@ -737,6 +738,10 @@ int ps3_system_bus_device_register(struc
 		snprintf(dev->core.bus_id, sizeof(dev->core.bus_id),
 			"vuart_%02x", ++dev_vuart_count);
 		break;
+	case PS3_DEVICE_TYPE_LPM:
+		snprintf(dev->core.bus_id, sizeof(dev->core.bus_id),
+			"lpm_%02x", ++dev_lpm_count);
+		break;
 	default:
 		BUG();
 	};
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -317,6 +317,7 @@ enum ps3_match_id {
 	PS3_MATCH_ID_STOR_FLASH     = 8,
 	PS3_MATCH_ID_SOUND          = 9,
 	PS3_MATCH_ID_GRAPHICS       = 10,
+	PS3_MATCH_ID_LPM            = 11,
 };
 
 #define PS3_MODULE_ALIAS_EHCI           "ps3:1"
@@ -329,11 +330,13 @@ enum ps3_match_id {
 #define PS3_MODULE_ALIAS_STOR_FLASH     "ps3:8"
 #define PS3_MODULE_ALIAS_SOUND          "ps3:9"
 #define PS3_MODULE_ALIAS_GRAPHICS       "ps3:10"
+#define PS3_MODULE_ALIAS_LPM            "ps3:11"
 
 enum ps3_system_bus_device_type {
 	PS3_DEVICE_TYPE_IOC0 = 1,
 	PS3_DEVICE_TYPE_SB,
 	PS3_DEVICE_TYPE_VUART,
+	PS3_DEVICE_TYPE_LPM,
 };
 
 /**
@@ -350,6 +353,11 @@ struct ps3_system_bus_device {
 	struct ps3_dma_region *d_region;  /* SB, IOC0 */
 	struct ps3_mmio_region *m_region; /* SB, IOC0*/
 	unsigned int port_number;         /* VUART */
+	struct {                          /* LPM */
+		u64 node_id;
+		u64 pu_id;
+		u64 rights;
+	} lpm;
 
 /*	struct iommu_table *iommu_table; -- waiting for BenH's cleanups */
 	struct device core;

-- 
