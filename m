Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4D27E2C0509
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 16:35:14 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 7 Mar 2014 11:05:12 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5F64E3940058
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 11:05:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s275ZE5n4063674
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 11:05:14 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s275ZAiL027772
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 11:05:10 +0530
Subject: [PATCH 1/2] powerpc/powernv: Enable fetching of platform sensor data
To: linuxppc-dev@lists.ozlabs.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Fri, 07 Mar 2014 11:03:27 +0530
Message-ID: <20140307053320.3547.10656.stgit@neelegup-tp-t420.in.ibm.com>
In-Reply-To: <20140307053236.3547.55729.stgit@neelegup-tp-t420.in.ibm.com>
References: <20140307053236.3547.55729.stgit@neelegup-tp-t420.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sbhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables fetching of various platform sensor data through
OPAL and expects a sensor handle from the driver to pass to OPAL.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h                |    4 ++
 arch/powerpc/platforms/powernv/Makefile        |    2 -
 arch/powerpc/platforms/powernv/opal-sensor.c   |   64 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-sensor.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 60b3edc..a1cc4dd 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -159,6 +159,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_GET_MSG				85
 #define OPAL_CHECK_ASYNC_COMPLETION		86
 #define OPAL_SYNC_HOST_REBOOT			87
+#define OPAL_SENSOR_READ			88
 #define OPAL_GET_PARAM				89
 #define OPAL_SET_PARAM				90
 
@@ -847,6 +848,8 @@ int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		size_t length);
 int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		size_t length);
+int64_t opal_sensor_read(uint32_t sensor_hndl, int token,
+		uint32_t *sensor_data);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
@@ -875,6 +878,7 @@ extern int opal_async_get_token_interruptible(void);
 extern int __opal_async_release_token(int token);
 extern int opal_async_release_token(int token);
 extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
+extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 
 extern void hvc_opal_init_early(void);
 
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index e6166d3..00ae938 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,6 +1,6 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o opal-sysparam.o
-obj-y			+= rng.o
+obj-y			+= rng.o opal-sensor.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
new file mode 100644
index 0000000..663cc9c
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -0,0 +1,64 @@
+/*
+ * PowerNV sensor code
+ *
+ * Copyright (C) 2013 IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <asm/opal.h>
+
+static DEFINE_MUTEX(opal_sensor_mutex);
+
+/*
+ * This will return sensor information to driver based on the requested sensor
+ * handle. A handle is an opaque id for the powernv, read by the driver from the
+ * device tree..
+ */
+int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
+{
+	int ret, token;
+	struct opal_msg msg;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		pr_err("%s: Couldn't get the token, returning\n", __func__);
+		ret = token;
+		goto out;
+	}
+
+	mutex_lock(&opal_sensor_mutex);
+	ret = opal_sensor_read(sensor_hndl, token, sensor_data);
+	if (ret != OPAL_ASYNC_COMPLETION)
+		goto out_token;
+
+	ret = opal_async_wait_response(token, &msg);
+	if (ret) {
+		pr_err("%s: Failed to wait for the async response, %d\n",
+				__func__, ret);
+		goto out_token;
+	}
+
+	ret = msg.params[1];
+
+out_token:
+	mutex_unlock(&opal_sensor_mutex);
+	opal_async_release_token(token);
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(opal_get_sensor_data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 0afdeca..4279e30 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -129,5 +129,6 @@ OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
 OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
 OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
 OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
+OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
