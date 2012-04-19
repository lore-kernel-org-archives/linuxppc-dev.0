Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B530DB6FDC
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:53:44 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 09:10:49 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DD2M2187294
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:13 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JnAG014210
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:50 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/15] powerpc/pmac: Convert windfarm_smu_sat to new i2c
 probing
Date: Thu, 19 Apr 2012 18:16:46 +1000
Message-Id: <1334823416-9138-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplifies the driver to stop using the deprecated attach interface.

While at it we also implement teardown properly and fix the refcounting
by using a kref.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/windfarm_smu_sat.c |  126 +++++++++++++---------------------
 1 file changed, 47 insertions(+), 79 deletions(-)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index 65a8ff3..72dfe19 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -20,7 +20,7 @@
 
 #include "windfarm.h"
 
-#define VERSION "0.2"
+#define VERSION "1.0"
 
 #define DEBUG
 
@@ -34,11 +34,12 @@
 #define MAX_AGE		msecs_to_jiffies(800)
 
 struct wf_sat {
+	struct kref		ref;
 	int			nr;
-	atomic_t		refcnt;
 	struct mutex		mutex;
 	unsigned long		last_read; /* jiffies when cache last updated */
 	u8			cache[16];
+	struct list_head	sensors;
 	struct i2c_client	*i2c;
 	struct device_node	*node;
 };
@@ -46,11 +47,12 @@ struct wf_sat {
 static struct wf_sat *sats[2];
 
 struct wf_sat_sensor {
-	int		index;
-	int		index2;		/* used for power sensors */
-	int		shift;
-	struct wf_sat	*sat;
-	struct wf_sensor sens;
+	struct list_head	link;
+	int			index;
+	int			index2;		/* used for power sensors */
+	int			shift;
+	struct wf_sat		*sat;
+	struct wf_sensor 	sens;
 };
 
 #define wf_to_sat(c)	container_of(c, struct wf_sat_sensor, sens)
@@ -142,7 +144,7 @@ static int wf_sat_read_cache(struct wf_sat *sat)
 	return 0;
 }
 
-static int wf_sat_get(struct wf_sensor *sr, s32 *value)
+static int wf_sat_sensor_get(struct wf_sensor *sr, s32 *value)
 {
 	struct wf_sat_sensor *sens = wf_to_sat(sr);
 	struct wf_sat *sat = sens->sat;
@@ -175,58 +177,30 @@ static int wf_sat_get(struct wf_sensor *sr, s32 *value)
 	return err;
 }
 
-static void wf_sat_release(struct wf_sensor *sr)
+static void wf_sat_release(struct kref *ref)
+{
+	struct wf_sat *sat = container_of(ref, struct wf_sat, ref);
+
+	if (sat->nr >= 0)
+		sats[sat->nr] = NULL;
+	kfree(sat);
+}
+
+static void wf_sat_sensor_release(struct wf_sensor *sr)
 {
 	struct wf_sat_sensor *sens = wf_to_sat(sr);
 	struct wf_sat *sat = sens->sat;
 
-	if (atomic_dec_and_test(&sat->refcnt)) {
-		if (sat->nr >= 0)
-			sats[sat->nr] = NULL;
-		kfree(sat);
-	}
 	kfree(sens);
+	kref_put(&sat->ref, wf_sat_release);
 }
 
 static struct wf_sensor_ops wf_sat_ops = {
-	.get_value	= wf_sat_get,
-	.release	= wf_sat_release,
+	.get_value	= wf_sat_sensor_get,
+	.release	= wf_sat_sensor_release,
 	.owner		= THIS_MODULE,
 };
 
-static struct i2c_driver wf_sat_driver;
-
-static void wf_sat_create(struct i2c_adapter *adapter, struct device_node *dev)
-{
-	struct i2c_board_info info;
-	struct i2c_client *client;
-	const u32 *reg;
-	u8 addr;
-
-	reg = of_get_property(dev, "reg", NULL);
-	if (reg == NULL)
-		return;
-	addr = *reg;
-	DBG(KERN_DEBUG "wf_sat: creating sat at address %x\n", addr);
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = (addr >> 1) & 0x7f;
-	info.platform_data = dev;
-	strlcpy(info.type, "wf_sat", I2C_NAME_SIZE);
-
-	client = i2c_new_device(adapter, &info);
-	if (client == NULL) {
-		printk(KERN_ERR "windfarm: failed to attach smu-sat to i2c\n");
-		return;
-	}
-
-	/*
-	 * Let i2c-core delete that device on driver removal.
-	 * This is safe because i2c-core holds the core_lock mutex for us.
-	 */
-	list_add_tail(&client->detected, &wf_sat_driver.clients);
-}
-
 static int wf_sat_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -246,9 +220,10 @@ static int wf_sat_probe(struct i2c_client *client,
 		return -ENOMEM;
 	sat->nr = -1;
 	sat->node = of_node_get(dev);
-	atomic_set(&sat->refcnt, 0);
+	kref_init(&sat->ref);
 	mutex_init(&sat->mutex);
 	sat->i2c = client;
+	INIT_LIST_HEAD(&sat->sensors);
 	i2c_set_clientdata(client, sat);
 
 	vsens[0] = vsens[1] = -1;
@@ -310,14 +285,15 @@ static int wf_sat_probe(struct i2c_client *client,
 		sens->index2 = -1;
 		sens->shift = shift;
 		sens->sat = sat;
-		atomic_inc(&sat->refcnt);
 		sens->sens.ops = &wf_sat_ops;
 		sens->sens.name = (char *) (sens + 1);
 		snprintf(sens->sens.name, 16, "%s-%d", name, cpu);
 
-		if (wf_register_sensor(&sens->sens)) {
-			atomic_dec(&sat->refcnt);
+		if (wf_register_sensor(&sens->sens))
 			kfree(sens);
+		else {
+			list_add(&sens->link, &sat->sensors);
+			kref_get(&sat->ref);
 		}
 	}
 
@@ -336,14 +312,15 @@ static int wf_sat_probe(struct i2c_client *client,
 		sens->index2 = isens[core];
 		sens->shift = 0;
 		sens->sat = sat;
-		atomic_inc(&sat->refcnt);
 		sens->sens.ops = &wf_sat_ops;
 		sens->sens.name = (char *) (sens + 1);
 		snprintf(sens->sens.name, 16, "cpu-power-%d", cpu);
 
-		if (wf_register_sensor(&sens->sens)) {
-			atomic_dec(&sat->refcnt);
+		if (wf_register_sensor(&sens->sens))
 			kfree(sens);
+		else {
+			list_add(&sens->link, &sat->sensors);
+			kref_get(&sat->ref);
 		}
 	}
 
@@ -353,42 +330,35 @@ static int wf_sat_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int wf_sat_attach(struct i2c_adapter *adapter)
-{
-	struct device_node *busnode, *dev = NULL;
-	struct pmac_i2c_bus *bus;
-
-	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
-	busnode = pmac_i2c_get_bus_node(bus);
-
-	while ((dev = of_get_next_child(busnode, dev)) != NULL)
-		if (of_device_is_compatible(dev, "smu-sat"))
-			wf_sat_create(adapter, dev);
-	return 0;
-}
-
 static int wf_sat_remove(struct i2c_client *client)
 {
 	struct wf_sat *sat = i2c_get_clientdata(client);
+	struct wf_sat_sensor *sens;
 
-	/* XXX TODO */
-
+	/* release sensors */
+	while(!list_empty(&sat->sensors)) {
+		sens = list_first_entry(&sat->sensors,
+					struct wf_sat_sensor, link);
+		list_del(&sens->link);
+		wf_unregister_sensor(&sens->sens);
+	}
 	sat->i2c = NULL;
+	i2c_set_clientdata(client, NULL);
+	kref_put(&sat->ref, wf_sat_release);
+
 	return 0;
 }
 
 static const struct i2c_device_id wf_sat_id[] = {
-	{ "wf_sat", 0 },
+	{ "MAC,smu-sat", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, wf_sat_id);
 
 static struct i2c_driver wf_sat_driver = {
 	.driver = {
 		.name		= "wf_smu_sat",
 	},
-	.attach_adapter	= wf_sat_attach,
 	.probe		= wf_sat_probe,
 	.remove		= wf_sat_remove,
 	.id_table	= wf_sat_id,
@@ -399,15 +369,13 @@ static int __init sat_sensors_init(void)
 	return i2c_add_driver(&wf_sat_driver);
 }
 
-#if 0	/* uncomment when module_exit() below is uncommented */
 static void __exit sat_sensors_exit(void)
 {
 	i2c_del_driver(&wf_sat_driver);
 }
-#endif
 
 module_init(sat_sensors_init);
-/*module_exit(sat_sensors_exit); Uncomment when cleanup is implemented */
+module_exit(sat_sensors_exit);
 
 MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
 MODULE_DESCRIPTION("SMU satellite sensors for PowerMac thermal control");
-- 
1.7.9.5
