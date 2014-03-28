Return-Path: <anton@samba.org>
Date: Fri, 28 Mar 2014 16:34:10 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, neelegup@linux.vnet.ibm.com,
 sbhat@linux.vnet.ibm.com
Subject: [PATCH 2/2] powerpc/powernv: Fix endian issues with sensor code
Message-ID: <20140328163410.79ba511b@kryten>
In-Reply-To: <20140328163333.4b1d3df4@kryten>
References: <20140328163333.4b1d3df4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


One OPAL call and one device tree property needed byte swapping.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/platforms/powernv/opal-sensor.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -33,6 +33,7 @@ int opal_get_sensor_data(u32 sensor_hndl
 {
 	int ret, token;
 	struct opal_msg msg;
+	__be32 data;
 
 	token = opal_async_get_token_interruptible();
 	if (token < 0) {
@@ -42,7 +43,7 @@ int opal_get_sensor_data(u32 sensor_hndl
 	}
 
 	mutex_lock(&opal_sensor_mutex);
-	ret = opal_sensor_read(sensor_hndl, token, sensor_data);
+	ret = opal_sensor_read(sensor_hndl, token, &data);
 	if (ret != OPAL_ASYNC_COMPLETION)
 		goto out_token;
 
@@ -53,6 +54,7 @@ int opal_get_sensor_data(u32 sensor_hndl
 		goto out_token;
 	}
 
+	*sensor_data = be32_to_cpu(data);
 	ret = be64_to_cpu(msg.params[1]);
 
 out_token:
Index: b/arch/powerpc/include/asm/opal.h
===================================================================
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -880,8 +880,7 @@ int64_t opal_get_param(uint64_t token, u
 		uint64_t length);
 int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		uint64_t length);
-int64_t opal_sensor_read(uint32_t sensor_hndl, int token,
-		uint32_t *sensor_data);
+int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
Index: b/drivers/hwmon/ibmpowernv.c
===================================================================
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -471,7 +471,7 @@ static int __init powernv_hwmon_init(voi
 	struct device_node *opal, *np = NULL;
 	enum attributes attr_type;
 	enum sensors type;
-	const u32 *sensor_id;
+	u32 sensor_id;
 	u32 sensor_index;
 	int err;
 
@@ -497,14 +497,13 @@ static int __init powernv_hwmon_init(voi
 				&sensor_index))
 			continue;
 
-		sensor_id = of_get_property(np, "sensor-id", NULL);
-		if (!sensor_id) {
+		if (of_property_read_u32(np, "sensor-id", &sensor_id)) {
 			pr_info("%s: %s doesn't have sensor-id\n", __func__,
 					np->name);
 			continue;
 		}
 
-		err = powernv_sensor_init(*sensor_id, np, type, attr_type,
+		err = powernv_sensor_init(sensor_id, np, type, attr_type,
 				sensor_index);
 		if (err) {
 			of_node_put(opal);
