Return-Path: <geoff@infradead.org>
Message-Id: <9d6cfa7d7c68d4041275f694bf2c37dd58eb9b39.1421109719.git.geoff@infradead.org>
In-Reply-To: <cover.1421109719.git.geoff@infradead.org>
References: <cover.1421109719.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 4/6] powerpc/ps3: Fix vuart sparse warnings
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Jan 2015 01:00:20 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix sparse warnings like these:

  drivers/ps3/ps3-vuart.c: warning: symbol 'ps3_vuart_disable_interrupt_tx' was not declared. Should it be static?

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/ps3/ps3-vuart.c |  5 -----
 drivers/ps3/vuart.h     | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index bc1e513..d6db822 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -151,11 +151,6 @@ static void __maybe_unused _dump_port_params(unsigned int port_number,
 #endif
 }
 
-struct vuart_triggers {
-	unsigned long rx;
-	unsigned long tx;
-};
-
 int ps3_vuart_get_triggers(struct ps3_system_bus_device *dev,
 	struct vuart_triggers *trig)
 {
diff --git a/drivers/ps3/vuart.h b/drivers/ps3/vuart.h
index eb7f6d9..23358b7 100644
--- a/drivers/ps3/vuart.h
+++ b/drivers/ps3/vuart.h
@@ -82,4 +82,20 @@ void ps3_vuart_cancel_async(struct ps3_system_bus_device *dev);
 void ps3_vuart_clear_rx_bytes(struct ps3_system_bus_device *dev,
 	unsigned int bytes);
 
+struct vuart_triggers {
+	unsigned long rx;
+	unsigned long tx;
+};
+
+int ps3_vuart_get_triggers(struct ps3_system_bus_device *dev,
+	struct vuart_triggers *trig);
+int ps3_vuart_set_triggers(struct ps3_system_bus_device *dev, unsigned int tx,
+	unsigned int rx);
+int ps3_vuart_enable_interrupt_tx(struct ps3_system_bus_device *dev);
+int ps3_vuart_disable_interrupt_tx(struct ps3_system_bus_device *dev);
+int ps3_vuart_enable_interrupt_rx(struct ps3_system_bus_device *dev);
+int ps3_vuart_disable_interrupt_rx(struct ps3_system_bus_device *dev);
+int ps3_vuart_enable_interrupt_disconnect(struct ps3_system_bus_device *dev);
+int ps3_vuart_disable_interrupt_disconnect(struct ps3_system_bus_device *dev);
+
 #endif
-- 
1.9.1
