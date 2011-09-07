Return-Path: <yong.zhang0@gmail.com>
From: Yong Zhang <yong.zhang0@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 51/62] powerpc/ps3: irq: Remove IRQF_DISABLED
Date: Wed,  7 Sep 2011 16:10:48 +0800
Message-Id: <1315383059-3673-52-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This flag is a NOOP and can be removed now.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 drivers/ps3/ps3-vuart.c   |    2 +-
 drivers/ps3/ps3stor_lib.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index d9fb729..fb73008 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -952,7 +952,7 @@ static int ps3_vuart_bus_interrupt_get(void)
 	}
 
 	result = request_irq(vuart_bus_priv.virq, ps3_vuart_irq_handler,
-		IRQF_DISABLED, "vuart", &vuart_bus_priv);
+		0, "vuart", &vuart_bus_priv);
 
 	if (result) {
 		pr_debug("%s:%d: request_irq failed (%d)\n",
diff --git a/drivers/ps3/ps3stor_lib.c b/drivers/ps3/ps3stor_lib.c
index af0afa1..73acc12 100644
--- a/drivers/ps3/ps3stor_lib.c
+++ b/drivers/ps3/ps3stor_lib.c
@@ -166,7 +166,7 @@ int ps3stor_setup(struct ps3_storage_device *dev, irq_handler_t handler)
 		goto fail_close_device;
 	}
 
-	error = request_irq(dev->irq, handler, IRQF_DISABLED,
+	error = request_irq(dev->irq, handler, 0,
 			    dev->sbd.core.driver->name, dev);
 	if (error) {
 		dev_err(&dev->sbd.core, "%s:%u: request_irq failed %d\n",
-- 
1.7.4.1
