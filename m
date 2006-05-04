Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EFAB467B23
	for <linuxppc-dev@ozlabs.org>; Thu,  4 May 2006 13:49:21 +1000 (EST)
Date: Thu, 4 May 2006 13:48:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 4/4] powerpc: update iSeries viocd and viotape device-tree
Message-Id: <20060504134841.2cb47b81.sfr@canb.auug.org.au>
In-Reply-To: <20060504134747.0db5233b.sfr@canb.auug.org.au>
References: <20060504134544.2fc295db.sfr@canb.auug.org.au>
	<20060504134650.7dd45964.sfr@canb.auug.org.au>
	<20060504134747.0db5233b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make their device_type entries more generic and their compatible entries
more specific.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/setup.c |    8 ++++----
 drivers/cdrom/viocd.c                  |    2 +-
 drivers/char/viotape.c                 |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

8e995399fbca7e9fe918e90653dd78fedd634f69
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index d3f94b4..074d1d9 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -982,8 +982,8 @@ void dt_vdevices(struct iseries_flat_dt 
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++) {
 		snprintf(buf, 32, "viocd@%08x", reg + i);
 		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "viocd");
-		dt_prop_str(dt, "compatible", "");
+		dt_prop_str(dt, "device_type", "block");
+		dt_prop_str(dt, "compatible", "IBM,iSeries-viocd");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
@@ -992,8 +992,8 @@ void dt_vdevices(struct iseries_flat_dt 
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++) {
 		snprintf(buf, 32, "viotape@%08x", reg + i);
 		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "viotape");
-		dt_prop_str(dt, "compatible", "");
+		dt_prop_str(dt, "device_type", "byte");
+		dt_prop_str(dt, "compatible", "IBM,iSeries-viotape");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index c0f817b..af6b3bf 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -731,7 +731,7 @@ static int viocd_remove(struct vio_dev *
  * support.
  */
 static struct vio_device_id viocd_device_table[] __devinitdata = {
-	{ "viocd", "" },
+	{ "block", "IBM,iSeries-viocd" },
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, viocd_device_table);
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 60aabdb..11c7e9d 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -989,7 +989,7 @@ static int viotape_remove(struct vio_dev
  * support.
  */
 static struct vio_device_id viotape_device_table[] __devinitdata = {
-	{ "viotape", "" },
+	{ "byte", "IBM,iSeries-viotape" },
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, viotape_device_table);
-- 
1.3.1.ge923
