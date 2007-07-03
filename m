Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3FC1DDE39
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 21:42:18 +1000 (EST)
Subject: [PATCH] powermac i2c: use mutex
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 04 Jul 2007 01:01:54 +0200
Message-Id: <1183503714.4021.25.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert the semaphores in low_i2c that are used as mutexes to real
mutexes.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 arch/powerpc/platforms/powermac/low_i2c.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- wireless-dev.orig/arch/powerpc/platforms/powermac/low_i2c.c	2007-07-04 00:42:08.267749881 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/low_i2c.c	2007-07-04 00:42:48.667749881 +0200
@@ -42,6 +42,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/timer.h>
+#include <linux/mutex.h>
 #include <asm/keylargo.h>
 #include <asm/uninorth.h>
 #include <asm/io.h>
@@ -84,7 +85,7 @@ struct pmac_i2c_bus
 	void			*hostdata;
 	int			channel;	/* some hosts have multiple */
 	int			mode;		/* current mode */
-	struct semaphore	sem;
+	struct mutex		mutex;
 	int			opened;
 	int			polled;		/* open mode */
 	struct platform_device	*platform_dev;
@@ -104,7 +105,7 @@ static LIST_HEAD(pmac_i2c_busses);
 
 struct pmac_i2c_host_kw
 {
-	struct semaphore	mutex;		/* Access mutex for use by
+	struct mutex		mutex;		/* Access mutex for use by
 						 * i2c-keywest */
 	void __iomem		*base;		/* register base address */
 	int			bsteps;		/* register stepping */
@@ -375,14 +376,14 @@ static void kw_i2c_timeout(unsigned long
 static int kw_i2c_open(struct pmac_i2c_bus *bus)
 {
 	struct pmac_i2c_host_kw *host = bus->hostdata;
-	down(&host->mutex);
+	mutex_lock(&host->mutex);
 	return 0;
 }
 
 static void kw_i2c_close(struct pmac_i2c_bus *bus)
 {
 	struct pmac_i2c_host_kw *host = bus->hostdata;
-	up(&host->mutex);
+	mutex_unlock(&host->mutex);
 }
 
 static int kw_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
@@ -498,7 +499,7 @@ static struct pmac_i2c_host_kw *__init k
 		kfree(host);
 		return NULL;
 	}
-	init_MUTEX(&host->mutex);
+	mutex_init(&host->mutex);
 	init_completion(&host->complete);
 	spin_lock_init(&host->lock);
 	init_timer(&host->timeout_timer);
@@ -571,7 +572,7 @@ static void __init kw_i2c_add(struct pma
 	bus->open = kw_i2c_open;
 	bus->close = kw_i2c_close;
 	bus->xfer = kw_i2c_xfer;
-	init_MUTEX(&bus->sem);
+	mutex_init(&bus->mutex);
 	if (controller == busnode)
 		bus->flags = pmac_i2c_multibus;
 	list_add(&bus->link, &pmac_i2c_busses);
@@ -798,7 +799,7 @@ static void __init pmu_i2c_probe(void)
 		bus->mode = pmac_i2c_mode_std;
 		bus->hostdata = bus + 1;
 		bus->xfer = pmu_i2c_xfer;
-		init_MUTEX(&bus->sem);
+		mutex_init(&bus->mutex);
 		bus->flags = pmac_i2c_multibus;
 		list_add(&bus->link, &pmac_i2c_busses);
 
@@ -921,7 +922,7 @@ static void __init smu_i2c_probe(void)
 		bus->mode = pmac_i2c_mode_std;
 		bus->hostdata = bus + 1;
 		bus->xfer = smu_i2c_xfer;
-		init_MUTEX(&bus->sem);
+		mutex_init(&bus->mutex);
 		bus->flags = 0;
 		list_add(&bus->link, &pmac_i2c_busses);
 
@@ -1093,13 +1094,13 @@ int pmac_i2c_open(struct pmac_i2c_bus *b
 {
 	int rc;
 
-	down(&bus->sem);
+	mutex_lock(&bus->mutex);
 	bus->polled = polled || pmac_i2c_force_poll;
 	bus->opened = 1;
 	bus->mode = pmac_i2c_mode_std;
 	if (bus->open && (rc = bus->open(bus)) != 0) {
 		bus->opened = 0;
-		up(&bus->sem);
+		mutex_unlock(&bus->mutex);
 		return rc;
 	}
 	return 0;
@@ -1112,7 +1113,7 @@ void pmac_i2c_close(struct pmac_i2c_bus 
 	if (bus->close)
 		bus->close(bus);
 	bus->opened = 0;
-	up(&bus->sem);
+	mutex_unlock(&bus->mutex);
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_close);
 
