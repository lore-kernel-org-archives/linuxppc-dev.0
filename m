Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id 1688BB7B99
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 23:30:48 +1000 (EST)
Date: Wed, 30 Sep 2009 15:21:11 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: [PATCH] macintosh: Don't assume i2c device probing always succeeds
Message-ID: <20090930152111.6c1a3453@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Colin Leroy <colin@colino.net>, linuxppc-dev@ozlabs.org,
	Tim Shepard <shep@alum.mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If i2c device probing fails, then there is no driver to dereference
after calling i2c_new_device(). Stop assuming that probing will always
succeed, to avoid NULL pointer dereferences. We have an easier access
to the driver anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Tested-by: Tim Shepard <shep@alum.mit.edu>
Cc: Colin Leroy <colin@colino.net>
---
This fixes a real-world oops and should be pushed to Linus ASAP, thanks.

 drivers/macintosh/therm_adt746x.c           |    4 +++-
 drivers/macintosh/therm_pm72.c              |    4 +++-
 drivers/macintosh/windfarm_lm75_sensor.c    |    4 +++-
 drivers/macintosh/windfarm_max6690_sensor.c |    4 +++-
 drivers/macintosh/windfarm_smu_sat.c        |    4 +++-
 5 files changed, 15 insertions(+), 5 deletions(-)

--- linux-2.6.32-rc1.orig/drivers/macintosh/therm_adt746x.c	2009-09-30 15:12:12.000000000 +0200
+++ linux-2.6.32-rc1/drivers/macintosh/therm_adt746x.c	2009-09-30 15:13:04.000000000 +0200
@@ -124,6 +124,8 @@ read_reg(struct thermostat* th, int reg)
 	return data;
 }
 
+static struct i2c_driver thermostat_driver;
+
 static int
 attach_thermostat(struct i2c_adapter *adapter)
 {
@@ -148,7 +150,7 @@ attach_thermostat(struct i2c_adapter *ad
 	 * Let i2c-core delete that device on driver removal.
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
-	list_add_tail(&client->detected, &client->driver->clients);
+	list_add_tail(&client->detected, &thermostat_driver.clients);
 	return 0;
 }
 
--- linux-2.6.32-rc1.orig/drivers/macintosh/therm_pm72.c	2009-09-30 15:12:12.000000000 +0200
+++ linux-2.6.32-rc1/drivers/macintosh/therm_pm72.c	2009-09-30 15:13:04.000000000 +0200
@@ -286,6 +286,8 @@ struct fcu_fan_table	fcu_fans[] = {
 	},
 };
 
+static struct i2c_driver therm_pm72_driver;
+
 /*
  * Utility function to create an i2c_client structure and
  * attach it to one of u3 adapters
@@ -318,7 +320,7 @@ static struct i2c_client *attach_i2c_chi
 	 * Let i2c-core delete that device on driver removal.
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
-	list_add_tail(&clt->detected, &clt->driver->clients);
+	list_add_tail(&clt->detected, &therm_pm72_driver.clients);
 	return clt;
 }
 
--- linux-2.6.32-rc1.orig/drivers/macintosh/windfarm_lm75_sensor.c	2009-09-30 15:12:12.000000000 +0200
+++ linux-2.6.32-rc1/drivers/macintosh/windfarm_lm75_sensor.c	2009-09-30 15:13:04.000000000 +0200
@@ -115,6 +115,8 @@ static int wf_lm75_probe(struct i2c_clie
 	return rc;
 }
 
+static struct i2c_driver wf_lm75_driver;
+
 static struct i2c_client *wf_lm75_create(struct i2c_adapter *adapter,
 					     u8 addr, int ds1775,
 					     const char *loc)
@@ -157,7 +159,7 @@ static struct i2c_client *wf_lm75_create
 	 * Let i2c-core delete that device on driver removal.
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
-	list_add_tail(&client->detected, &client->driver->clients);
+	list_add_tail(&client->detected, &wf_lm75_driver.clients);
 	return client;
  fail:
 	return NULL;
--- linux-2.6.32-rc1.orig/drivers/macintosh/windfarm_max6690_sensor.c	2009-09-30 15:12:12.000000000 +0200
+++ linux-2.6.32-rc1/drivers/macintosh/windfarm_max6690_sensor.c	2009-09-30 15:13:04.000000000 +0200
@@ -88,6 +88,8 @@ static int wf_max6690_probe(struct i2c_c
 	return rc;
 }
 
+static struct i2c_driver wf_max6690_driver;
+
 static struct i2c_client *wf_max6690_create(struct i2c_adapter *adapter,
 					    u8 addr, const char *loc)
 {
@@ -119,7 +121,7 @@ static struct i2c_client *wf_max6690_cre
 	 * Let i2c-core delete that device on driver removal.
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
-	list_add_tail(&client->detected, &client->driver->clients);
+	list_add_tail(&client->detected, &wf_max6690_driver.clients);
 	return client;
 
  fail:
--- linux-2.6.32-rc1.orig/drivers/macintosh/windfarm_smu_sat.c	2009-09-30 15:12:12.000000000 +0200
+++ linux-2.6.32-rc1/drivers/macintosh/windfarm_smu_sat.c	2009-09-30 15:13:04.000000000 +0200
@@ -194,6 +194,8 @@ static struct wf_sensor_ops wf_sat_ops =
 	.owner		= THIS_MODULE,
 };
 
+static struct i2c_driver wf_sat_driver;
+
 static void wf_sat_create(struct i2c_adapter *adapter, struct device_node *dev)
 {
 	struct i2c_board_info info;
@@ -222,7 +224,7 @@ static void wf_sat_create(struct i2c_ada
 	 * Let i2c-core delete that device on driver removal.
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
-	list_add_tail(&client->detected, &client->driver->clients);
+	list_add_tail(&client->detected, &wf_sat_driver.clients);
 }
 
 static int wf_sat_probe(struct i2c_client *client,


-- 
Jean Delvare
