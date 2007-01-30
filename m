Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 62999DE0B0
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:20:35 +1100 (EST)
Message-ID: <45BFD2BE.7070908@am.sony.com>
Date: Tue, 30 Jan 2007 15:20:30 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/4] PS3: Move vuart declarations to ps3.h
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

Move the structures and routines needed for PS3 vuart port device registration
to asm-powerpc/ps3.h.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/ps3/vuart.h       |   38 +-------------------------------------
 include/asm-powerpc/ps3.h |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 37 deletions(-)

--- ps3-linux-dev.orig/drivers/ps3/vuart.h
+++ ps3-linux-dev/drivers/ps3/vuart.h
@@ -21,37 +21,6 @@
 #if !defined(_PS3_VUART_H)
 #define _PS3_VUART_H
 
-struct ps3_vuart_stats {
-	unsigned long bytes_written;
-	unsigned long bytes_read;
-	unsigned long tx_interrupts;
-	unsigned long rx_interrupts;
-	unsigned long disconnect_interrupts;
-};
-
-/**
- * struct ps3_vuart_port_device - a device on a vuart port
- */
-
-struct ps3_vuart_port_device {
-	enum ps3_match_id match_id;
-	struct device core;
-
-	/* private driver variables */
-	unsigned int port_number;
-	unsigned long interrupt_mask;
-	struct {
-		spinlock_t lock;
-		struct list_head head;
-	} tx_list;
-	struct {
-		unsigned long bytes_held;
-		spinlock_t lock;
-		struct list_head head;
-	} rx_list;
-	struct ps3_vuart_stats stats;
-};
-
 /**
  * struct ps3_vuart_port_driver - a driver for a device on a vuart port
  */
@@ -68,9 +37,9 @@ struct ps3_vuart_port_driver {
 	/* int (*resume)(struct ps3_vuart_port_device *); */
 };
 
-int ps3_vuart_port_device_register(struct ps3_vuart_port_device *dev);
 int ps3_vuart_port_driver_register(struct ps3_vuart_port_driver *drv);
 void ps3_vuart_port_driver_unregister(struct ps3_vuart_port_driver *drv);
+
 int ps3_vuart_write(struct ps3_vuart_port_device *dev,
 	const void* buf, unsigned int bytes);
 int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
@@ -86,9 +55,4 @@ static inline struct ps3_vuart_port_devi
 	return container_of(_dev, struct ps3_vuart_port_device, core);
 }
 
-int ps3_vuart_write(struct ps3_vuart_port_device *dev, const void* buf,
-	unsigned int bytes);
-int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
-	unsigned int bytes);
-
 #endif
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -353,4 +353,39 @@ static inline void *ps3_system_bus_get_d
 
 extern struct bus_type ps3_system_bus_type;
 
+/* vuart routines */
+
+struct ps3_vuart_stats {
+	unsigned long bytes_written;
+	unsigned long bytes_read;
+	unsigned long tx_interrupts;
+	unsigned long rx_interrupts;
+	unsigned long disconnect_interrupts;
+};
+
+/**
+ * struct ps3_vuart_port_device - a device on a vuart port
+ */
+
+struct ps3_vuart_port_device {
+	enum ps3_match_id match_id;
+	struct device core;
+
+	/* private driver variables */
+	unsigned int port_number;
+	u64 interrupt_mask;
+	struct {
+		spinlock_t lock;
+		struct list_head head;
+	} tx_list;
+	struct {
+		unsigned long bytes_held;
+		spinlock_t lock;
+		struct list_head head;
+	} rx_list;
+	struct ps3_vuart_stats stats;
+};
+
+int ps3_vuart_port_device_register(struct ps3_vuart_port_device *dev);
+
 #endif
