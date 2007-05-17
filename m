Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EDFCDDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 00:46:18 +1000 (EST)
Date: Thu, 17 May 2007 09:38:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: i2c@lm-sensors.org
Subject: [PATCH 2/5] i2c: Allow preallocation of I2C bus numbers.
Message-ID: <20070517143829.GB29795@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new-style i2c device model requires the bus number to be known before
adapter registration; this provides a mechanism by which such numbers can
be allocated globally before calling i2c_register_board_info().

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/i2c/i2c-core.c |   67 ++++++++++++++++++++++++++++++++++++++---------
 include/linux/i2c.h    |    2 +
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 64f8e56..37e9002 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -377,20 +377,15 @@ out_list:
 }
 
 /**
- * i2c_add_adapter - declare i2c adapter, use dynamic bus number
- * @adapter: the adapter to add
- *
- * This routine is used to declare an I2C adapter when its bus number
- * doesn't matter.  Examples: for I2C adapters dynamically added by
- * USB links or PCI plugin cards.
+ * i2c_alloc_bus_number - Request a number for an i2c adapter
  *
- * When this returns zero, a new bus number was allocated and stored
- * in adap->nr, and the specified adapter became available for clients.
- * Otherwise, a negative errno value is returned.
+ * Allocates an i2c bus number to be used later with
+ * i2c_add_prenumbered_adapter(), allowing i2c_register_board_info()
+ * to be called in the meantime.
  */
-int i2c_add_adapter(struct i2c_adapter *adapter)
+int i2c_alloc_bus_number(void)
 {
-	int	id, res = 0;
+	int id, res;
 
 retry:
 	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
@@ -398,8 +393,8 @@ retry:
 
 	mutex_lock(&core_lists);
 	/* "above" here means "above or equal to", sigh */
-	res = idr_get_new_above(&i2c_adapter_idr, adapter,
-				__i2c_first_dynamic_bus_num, &id);
+	res = idr_get_new_above(&i2c_adapter_idr, NULL,
+	                        __i2c_first_dynamic_bus_num, &id);
 	mutex_unlock(&core_lists);
 
 	if (res < 0) {
@@ -408,9 +403,55 @@ retry:
 		return res;
 	}
 
+	return id;
+}
+EXPORT_SYMBOL(i2c_alloc_bus_number);
+
+/**
+ * i2c_add_prenumbered_adapter - declare i2c adapter using preallocated number
+ * @adapter: the adapter to add
+ * @id: the result of a previous call to i2c_alloc_bus_number()
+ *
+ * This routine is used to declare an I2C adapter when its bus number
+ * doesn't matter.  Examples: for I2C adapters dynamically added by
+ * USB links or PCI plugin cards.
+ *
+ * When this returns zero, a new bus number was allocated and stored
+ * in adap->nr, and the specified adapter became available for clients.
+ * Otherwise, a negative errno value is returned.
+ */
+int i2c_add_prenumbered_adapter(struct i2c_adapter *adapter, int id)
+{
 	adapter->nr = id;
+
+	mutex_lock(&core_lists);
+	idr_replace(&i2c_adapter_idr, adapter, id);
+	mutex_unlock(&core_lists);
+
 	return i2c_register_adapter(adapter);
 }
+EXPORT_SYMBOL(i2c_add_prenumbered_adapter);
+
+/**
+ * i2c_add_adapter - declare i2c adapter, use dynamic bus number
+ * @adapter: the adapter to add
+ *
+ * This routine is used to declare an I2C adapter when its bus number
+ * doesn't matter.  Examples: for I2C adapters dynamically added by
+ * USB links or PCI plugin cards.
+ *
+ * When this returns zero, a new bus number was allocated and stored
+ * in adap->nr, and the specified adapter became available for clients.
+ * Otherwise, a negative errno value is returned.
+ */
+int i2c_add_adapter(struct i2c_adapter *adapter)
+{
+	int id = i2c_alloc_bus_number();
+	if (id < 0)
+		return id;
+
+	return i2c_add_prenumbered_adapter(adapter, id);
+}
 EXPORT_SYMBOL(i2c_add_adapter);
 
 /**
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index cae7d61..da2b4f5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -369,8 +369,10 @@ struct i2c_client_address_data {
 
 /* administration...
  */
+extern int i2c_alloc_bus_number(void);
 extern int i2c_add_adapter(struct i2c_adapter *);
 extern int i2c_del_adapter(struct i2c_adapter *);
+extern int i2c_add_prenumbered_adapter(struct i2c_adapter *, int id);
 extern int i2c_add_numbered_adapter(struct i2c_adapter *);
 
 extern int i2c_register_driver(struct module *, struct i2c_driver *);
-- 
1.5.0.3
