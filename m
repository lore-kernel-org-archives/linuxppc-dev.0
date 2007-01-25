Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F057EDE1B9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:40:01 +1100 (EST)
Message-ID: <45B81877.3020600@am.sony.com>
Date: Wed, 24 Jan 2007 18:39:51 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 3/14] ps3: system bus minor mmio fix
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Fix two minor bugs in the PS3 system bus mmio region code.  First, on error or
when freeing a region, retain the bus_addr and len fields to allow subsequent
calls to create the region.  Second, correct the region address argument to the
lv1_unmap_device_mmio_region() call.

Fixes modprobe/rmmod of some drivers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/ps3/system-bus.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- ps3-linux-dev.orig/drivers/ps3/system-bus.c
+++ ps3-linux-dev/drivers/ps3/system-bus.c
@@ -50,7 +50,7 @@ int ps3_mmio_region_create(struct ps3_mm
 	if (result) {
 		pr_debug("%s:%d: lv1_map_device_mmio_region failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
-		r->lpar_addr = r->len = r->bus_addr = 0;
+		r->lpar_addr = 0;
 	}
 
 	dump_mmio_region(r);
@@ -62,13 +62,13 @@ int ps3_free_mmio_region(struct ps3_mmio
 	int result;
 
 	result = lv1_unmap_device_mmio_region(r->did.bus_id, r->did.dev_id,
-		r->bus_addr);
+		r->lpar_addr);
 
 	if (result)
 		pr_debug("%s:%d: lv1_unmap_device_mmio_region failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
-	r->lpar_addr = r->len = r->bus_addr = 0;
+	r->lpar_addr = 0;
 	return result;
 }
 
