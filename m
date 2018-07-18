Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W50q4MqqzF3Hk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 04:15:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6IIFH9v119293
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 14:15:21 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ka7jbr947-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 14:15:18 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 18 Jul 2018 19:13:47 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 1/2] powernv:opal-sensor-groups: Add support to enable
 sensor groups
Date: Wed, 18 Jul 2018 23:43:29 +0530
In-Reply-To: <1531937610-6454-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1531937610-6454-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1531937610-6454-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support to enable/disable a sensor group at runtime. This
can be used to select the sensor groups that needs to be copied to
main memory by OCC. Sensor groups like power, temperature, current,
voltage, frequency, utilization can be enabled/disabled at runtime.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h                |  1 +
 arch/powerpc/include/asm/opal.h                    |  2 ++
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 28 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |  1 +
 4 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 3bab299..56a94a1 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -206,6 +206,7 @@
 #define OPAL_NPU_SPA_CLEAR_CACHE		160
 #define OPAL_NPU_TL_SET				161
 #define OPAL_SENSOR_READ_U64			162
+#define OPAL_SENSOR_GROUP_ENABLE		163
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
 #define OPAL_LAST				165
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e1b2910..fc0550e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -292,6 +292,7 @@ int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
 int opal_get_power_shift_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
+int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
 
 s64 opal_signal_system_reset(s32 cpu);
 s64 opal_quiesce(u64 shutdown_type, s32 cpu);
@@ -326,6 +327,7 @@ extern int opal_async_wait_response_interruptible(uint64_t token,
 		struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 extern int opal_get_sensor_data_u64(u32 sensor_hndl, u64 *sensor_data);
+extern int sensor_group_enable(u32 grp_hndl, bool enable);
 
 struct rtc_time;
 extern time64_t opal_get_boot_time(void);
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 541c9ea..f7d04b6 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -32,6 +32,34 @@ struct sg_attr {
 	struct sg_attr *sgattrs;
 } *sgs;
 
+int sensor_group_enable(u32 handle, bool enable)
+{
+	struct opal_msg msg;
+	int token, ret;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0)
+		return token;
+
+	ret = opal_sensor_group_enable(handle, token, enable);
+	if (ret == OPAL_ASYNC_COMPLETION) {
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_devel("Failed to wait for the async response\n");
+			ret = -EIO;
+			goto out;
+		}
+		ret = opal_error_code(opal_get_async_rc(msg));
+	} else {
+		ret = opal_error_code(ret);
+	}
+
+out:
+	opal_async_release_token(token);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sensor_group_enable);
+
 static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *buf, size_t count)
 {
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a8d9b40..8268a1e 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -327,3 +327,4 @@ OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
 OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
+OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
-- 
1.8.3.1
