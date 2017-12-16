Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzTTR27GfzDsP7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 01:00:26 +1100 (AEDT)
Subject: [PATCH 2/2] ps3: Improve a size determination in five functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
Message-ID: <7aed1208-aa55-edb6-54be-f47fb1498bfd@users.sourceforge.net>
Date: Sat, 16 Dec 2017 14:54:03 +0100
MIME-Version: 1.0
In-Reply-To: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 16 Dec 2017 14:21:04 +0100

Replace the specification of data structures by variable references
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ps3/ps3-sys-manager.c |  9 ++-------
 drivers/ps3/ps3-vuart.c       | 11 +++--------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/ps3/ps3-sys-manager.c b/drivers/ps3/ps3-sys-manager.c
index 73e496a72113..e7d8ef93576a 100644
--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -249,9 +249,7 @@ static int ps3_sys_manager_write(struct ps3_system_bus_device *dev,
 	BUG_ON(header->payload_size != 8 && header->payload_size != 16);
 	BUG_ON(header->service_id > 8);
 
-	result = ps3_vuart_write(dev, header,
-		sizeof(struct ps3_sys_manager_header));
-
+	result = ps3_vuart_write(dev, header, sizeof(*header));
 	if (!result)
 		result = ps3_vuart_write(dev, payload, header->payload_size);
 
@@ -537,11 +535,8 @@ static int ps3_sys_manager_handle_cmd(struct ps3_system_bus_device *dev)
 
 static int ps3_sys_manager_handle_msg(struct ps3_system_bus_device *dev)
 {
-	int result;
 	struct ps3_sys_manager_header header;
-
-	result = ps3_vuart_read(dev, &header,
-		sizeof(struct ps3_sys_manager_header));
+	int result = ps3_vuart_read(dev, &header, sizeof(header));
 
 	if (result)
 		return result;
diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index bbaad30a876f..c82362cbaf4a 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -522,8 +522,7 @@ int ps3_vuart_write(struct ps3_system_bus_device *dev, const void *buf,
 	} else
 		spin_unlock_irqrestore(&priv->tx_list.lock, flags);
 
-	lb = kmalloc(sizeof(struct list_buffer) + bytes, GFP_KERNEL);
-
+	lb = kmalloc(sizeof(*lb) + bytes, GFP_KERNEL);
 	if (!lb)
 		return -ENOMEM;
 
@@ -575,9 +574,7 @@ static int ps3_vuart_queue_rx_bytes(struct ps3_system_bus_device *dev,
 	/* Add some extra space for recently arrived data. */
 
 	bytes += 128;
-
-	lb = kmalloc(sizeof(struct list_buffer) + bytes, GFP_ATOMIC);
-
+	lb = kmalloc(sizeof(*lb) + bytes, GFP_ATOMIC);
 	if (!lb)
 		return -ENOMEM;
 
@@ -925,9 +922,7 @@ static int ps3_vuart_bus_interrupt_get(void)
 		return 0;
 
 	BUG_ON(vuart_bus_priv.bmp);
-
-	vuart_bus_priv.bmp = kzalloc(sizeof(struct ports_bmp), GFP_KERNEL);
-
+	vuart_bus_priv.bmp = kzalloc(sizeof(*vuart_bus_priv.bmp), GFP_KERNEL);
 	if (!vuart_bus_priv.bmp) {
 		result = -ENOMEM;
 		goto fail_bmp_malloc;
-- 
2.15.1
