Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81527DE10B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 07:01:11 +1000 (EST)
Date: Thu, 16 Apr 2009 23:01:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] therm_windtunnel: Convert to a new-style i2c driver
Message-ID: <20090416230101.37f3e84f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The legacy i2c binding model is going away soon, so convert the ppc
therm_windtunnel driver to the new model or it will break.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
Can someone please test this patch for me? I could only build-test it.

Remember that you need this patch applied:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=935298696f469c0e07c73be687bd055878074ce0

Thanks.

 drivers/macintosh/therm_windtunnel.c |  126 ++++++++++++++++------------------
 1 file changed, 60 insertions(+), 66 deletions(-)

--- linux-2.6.30-rc2.orig/drivers/macintosh/therm_windtunnel.c	2009-03-24 13:40:47.000000000 +0100
+++ linux-2.6.30-rc2/drivers/macintosh/therm_windtunnel.c	2009-04-16 22:56:39.000000000 +0200
@@ -48,16 +48,6 @@
 
 #define LOG_TEMP		0			/* continously log temperature */
 
-static int 			do_probe( struct i2c_adapter *adapter, int addr, int kind);
-
-/* scan 0x48-0x4f (DS1775) and 0x2c-2x2f (ADM1030) */
-static const unsigned short	normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
-						 0x4c, 0x4d, 0x4e, 0x4f,
-						 0x2c, 0x2d, 0x2e, 0x2f,
-						 I2C_CLIENT_END };
-
-I2C_CLIENT_INSMOD;
-
 static struct {
 	volatile int		running;
 	struct task_struct	*poll_task;
@@ -315,53 +305,54 @@ static int control_loop(void *dummy)
 static int
 do_attach( struct i2c_adapter *adapter )
 {
-	int ret = 0;
+	/* scan 0x48-0x4f (DS1775) and 0x2c-2x2f (ADM1030) */
+	static const unsigned short scan_ds1775[] = {
+		0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+		I2C_CLIENT_END
+	};
+	static const unsigned short scan_adm1030[] = {
+		0x2c, 0x2d, 0x2e, 0x2f,
+		I2C_CLIENT_END
+	};
 
 	if( strncmp(adapter->name, "uni-n", 5) )
 		return 0;
 
 	if( !x.running ) {
-		ret = i2c_probe( adapter, &addr_data, &do_probe );
+		struct i2c_board_info info;
+
+		memset(&info, 0, sizeof(struct i2c_board_info));
+		strlcpy(info.type, "therm_ds1775", I2C_NAME_SIZE);
+		i2c_new_probed_device(adapter, &info, scan_ds1775);
+
+		strlcpy(info.type, "therm_adm1030", I2C_NAME_SIZE);
+		i2c_new_probed_device(adapter, &info, scan_adm1030);
+
 		if( x.thermostat && x.fan ) {
 			x.running = 1;
 			x.poll_task = kthread_run(control_loop, NULL, "g4fand");
 		}
 	}
-	return ret;
+	return 0;
 }
 
 static int
-do_detach( struct i2c_client *client )
+do_remove(struct i2c_client *client)
 {
-	int err;
-
-	if( (err=i2c_detach_client(client)) )
-		printk(KERN_ERR "failed to detach thermostat client\n");
-	else {
-		if( x.running ) {
-			x.running = 0;
-			kthread_stop(x.poll_task);
-			x.poll_task = NULL;
-		}
-		if( client == x.thermostat )
-			x.thermostat = NULL;
-		else if( client == x.fan )
-			x.fan = NULL;
-		else {
-			printk(KERN_ERR "g4fan: bad client\n");
-		}
-		kfree( client );
+	if (x.running) {
+		x.running = 0;
+		kthread_stop(x.poll_task);
+		x.poll_task = NULL;
 	}
-	return err;
-}
+	if (client == x.thermostat)
+		x.thermostat = NULL;
+	else if (client == x.fan)
+		x.fan = NULL;
+	else
+		printk(KERN_ERR "g4fan: bad client\n");
 
-static struct i2c_driver g4fan_driver = {  
-	.driver = {
-		.name	= "therm_windtunnel",
-	},
-	.attach_adapter = do_attach,
-	.detach_client	= do_detach,
-};
+	return 0;
+}
 
 static int
 attach_fan( struct i2c_client *cl )
@@ -374,13 +365,8 @@ attach_fan( struct i2c_client *cl )
 		goto out;
 	printk("ADM1030 fan controller [@%02x]\n", cl->addr );
 
-	strlcpy( cl->name, "ADM1030 fan controller", sizeof(cl->name) );
-
-	if( !i2c_attach_client(cl) )
-		x.fan = cl;
+	x.fan = cl;
  out:
-	if( cl != x.fan )
-		kfree( cl );
 	return 0;
 }
 
@@ -412,39 +398,47 @@ attach_thermostat( struct i2c_client *cl
 	x.temp = temp;
 	x.overheat_temp = os_temp;
 	x.overheat_hyst = hyst_temp;
-	
-	strlcpy( cl->name, "DS1775 thermostat", sizeof(cl->name) );
-
-	if( !i2c_attach_client(cl) )
-		x.thermostat = cl;
+	x.thermostat = cl;
 out:
-	if( cl != x.thermostat )
-		kfree( cl );
 	return 0;
 }
 
+enum chip { ds1775, adm1030 };
+
+static const struct i2c_device_id therm_windtunnel_id[] = {
+	{ "therm_ds1775", ds1775 },
+	{ "therm_adm1030", adm1030 },
+	{ }
+};
+
 static int
-do_probe( struct i2c_adapter *adapter, int addr, int kind )
+do_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 {
-	struct i2c_client *cl;
+	struct i2c_adapter *adapter = cl->adapter;
 
 	if( !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA
 				     | I2C_FUNC_SMBUS_WRITE_BYTE) )
 		return 0;
 
-	if( !(cl=kzalloc(sizeof(*cl), GFP_KERNEL)) )
-		return -ENOMEM;
-
-	cl->addr = addr;
-	cl->adapter = adapter;
-	cl->driver = &g4fan_driver;
-	cl->flags = 0;
-
-	if( addr < 0x48 )
+	switch (id->driver_data) {
+	case adm1030:
 		return attach_fan( cl );
-	return attach_thermostat( cl );
+	case ds1775:
+		return attach_thermostat(cl);
+	}
+	return 0;
 }
 
+static struct i2c_driver g4fan_driver = {
+	.driver = {
+		.name	= "therm_windtunnel",
+	},
+	.attach_adapter = do_attach,
+	.probe		= do_probe,
+	.remove		= do_remove,
+	.id_table	= therm_windtunnel_id,
+};
+
 
 /************************************************************************/
 /*	initialization / cleanup					*/


-- 
Jean Delvare
