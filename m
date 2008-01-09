Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2ABAEDE3A9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 17:42:47 +1100 (EST)
Message-ID: <47846B3F.6060003@am.sony.com>
Date: Tue, 08 Jan 2008 22:35:43 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 3/4 v2] PS3: Add logical performance monitor device support
References: <477EF59C.2070809@am.sony.com>
In-Reply-To: <477EF59C.2070809@am.sony.com>
Content-Type: text/plain; charset=ISO-8859-1
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

 arch/powerpc/platforms/ps3/device-init.c |   91 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/system-bus.c  |    5 +
 include/asm-powerpc/ps3.h                |    7 ++
 3 files changed, 103 insertions(+)
 create mode 100644 arch/powerpc/platforms/ps3/lpm.c

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -30,6 +30,95 @@
 
 #include "platform.h"
 
+static int __init ps3_register_lpm_devices(void)
+{
+	int result;
+	unsigned int pu_count;
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
+	result = ps3_repository_read_num_pu(&pu_count);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_repository_read_num_pu failed \n",
+			__func__, __LINE__);
+		goto fail_read_repo;
+	}
+
+	/* The current lpm driver only supports a single BE processor. */
+
+	if (pu_count > 1) {
+		pr_info("%s:%d: found %u BE processors, only one supported\n",
+			__func__, __LINE__, pu_count);
+	}
+
+	result = ps3_repository_read_pu_id(0, &dev->lpm.pu_id);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_repository_read_pu_id failed \n",
+			__func__, __LINE__);
+		goto fail_read_repo;
+	}
+
+	result = ps3_repository_read_lpm_privileges(0, &tmp1,
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
@@ -787,6 +876,8 @@ static int __init ps3_register_devices(v
 
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
@@ -350,6 +353,10 @@ struct ps3_system_bus_device {
 	struct ps3_dma_region *d_region;  /* SB, IOC0 */
 	struct ps3_mmio_region *m_region; /* SB, IOC0*/
 	unsigned int port_number;         /* VUART */
+	struct {                          /* LPM */
+		u64 pu_id;
+		u64 rights;
+	} lpm;
 
 /*	struct iommu_table *iommu_table; -- waiting for BenH's cleanups */
 	struct device core;
