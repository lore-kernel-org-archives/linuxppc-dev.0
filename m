Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail27-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8A828DE01D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:14 +1100 (EST)
Message-ID: <47910CD3.2050305@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 09/16] PS3: Checkpatch cleanups for drivers/ps3/ps3-vuart.c
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Cleanup coding errors in drivers/ps3/ps3-vuart.c as reported by
checkpatch.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-vuart.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -108,18 +108,18 @@ static struct ps3_vuart_port_priv *to_po
 struct ports_bmp {
 	u64 status;
 	u64 unused[3];
-} __attribute__ ((aligned (32)));
+} __attribute__((aligned(32)));
 
 #define dump_ports_bmp(_b) _dump_ports_bmp(_b, __func__, __LINE__)
 static void __maybe_unused _dump_ports_bmp(
-	const struct ports_bmp* bmp, const char* func, int line)
+	const struct ports_bmp *bmp, const char *func, int line)
 {
 	pr_debug("%s:%d: ports_bmp: %016lxh\n", func, line, bmp->status);
 }
 
 #define dump_port_params(_b) _dump_port_params(_b, __func__, __LINE__)
 static void __maybe_unused _dump_port_params(unsigned int port_number,
-	const char* func, int line)
+	const char *func, int line)
 {
 #if defined(DEBUG)
 	static const char *strings[] = {
@@ -363,7 +363,7 @@ int ps3_vuart_disable_interrupt_disconne
  */
 
 static int ps3_vuart_raw_write(struct ps3_system_bus_device *dev,
-	const void* buf, unsigned int bytes, unsigned long *bytes_written)
+	const void *buf, unsigned int bytes, unsigned long *bytes_written)
 {
 	int result;
 	struct ps3_vuart_port_priv *priv = to_port_priv(dev);
@@ -431,7 +431,7 @@ void ps3_vuart_clear_rx_bytes(struct ps3
 	int result;
 	struct ps3_vuart_port_priv *priv = to_port_priv(dev);
 	u64 bytes_waiting;
-	void* tmp;
+	void *tmp;
 
 	result = ps3_vuart_get_rx_bytes_waiting(dev, &bytes_waiting);
 
@@ -526,9 +526,8 @@ int ps3_vuart_write(struct ps3_system_bu
 
 	lb = kmalloc(sizeof(struct list_buffer) + bytes, GFP_KERNEL);
 
-	if (!lb) {
+	if (!lb)
 		return -ENOMEM;
-	}
 
 	memcpy(lb->data, buf, bytes);
 	lb->head = lb->data;
@@ -926,9 +925,8 @@ static int ps3_vuart_bus_interrupt_get(v
 
 	BUG_ON(vuart_bus_priv.use_count > 2);
 
-	if (vuart_bus_priv.use_count != 1) {
+	if (vuart_bus_priv.use_count != 1)
 		return 0;
-	}
 
 	BUG_ON(vuart_bus_priv.bmp);
 

-- 
