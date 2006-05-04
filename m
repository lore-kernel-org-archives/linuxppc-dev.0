Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 56C5367AC6
	for <linuxppc-dev@ozlabs.org>; Thu,  4 May 2006 13:49:20 +1000 (EST)
Date: Thu, 4 May 2006 13:46:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/4] powerpc: update iSeries viodasd device-tree entries
Message-Id: <20060504134650.7dd45964.sfr@canb.auug.org.au>
In-Reply-To: <20060504134544.2fc295db.sfr@canb.auug.org.au>
References: <20060504134544.2fc295db.sfr@canb.auug.org.au>
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

These devices should have device_type block and a unique compatible entry.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/setup.c |    4 ++--
 drivers/block/viodasd.c                |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

1f5b48ad3ece3e3f35ec05cc3ffd028e16c22732
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 0a08257..285f2b2 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -971,8 +971,8 @@ void dt_vdevices(struct iseries_flat_dt 
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++) {
 		snprintf(buf, 32, "viodasd@%08x", reg + i);
 		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "viodasd");
-		dt_prop_str(dt, "compatible", "");
+		dt_prop_str(dt, "device_type", "block");
+		dt_prop_str(dt, "compatible", "IBM,iSeries-viodasd");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index f63e07b..b0df4f5 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -747,7 +747,7 @@ static int viodasd_remove(struct vio_dev
  * support.
  */
 static struct vio_device_id viodasd_device_table[] __devinitdata = {
-	{ "viodasd", "" },
+	{ "block", "IBM,iSeries-viodasd" },
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, viodasd_device_table);
-- 
1.3.1.ge923
