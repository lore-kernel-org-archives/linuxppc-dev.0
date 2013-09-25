Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] hwrng: Use KBUILD_MODNAME in pseries-rng.c
Date: Wed, 25 Sep 2013 19:24:16 +1000
Message-Id: <1380101057-29903-1-git-send-email-michael@ellerman.id.au>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, mpm@selenic.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/char/hw_random/pseries-rng.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/pseries-rng.c
index 5f11979..9dbeed3 100644
--- a/drivers/char/hw_random/pseries-rng.c
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -21,7 +21,6 @@
 #include <linux/hw_random.h>
 #include <asm/vio.h>
 
-#define MODULE_NAME "pseries-rng"
 
 static int pseries_rng_data_read(struct hwrng *rng, u32 *data)
 {
@@ -47,7 +46,7 @@ static unsigned long pseries_rng_get_desired_dma(struct vio_dev *vdev)
 };
 
 static struct hwrng pseries_rng = {
-	.name		= MODULE_NAME,
+	.name		= KBUILD_MODNAME,
 	.data_read	= pseries_rng_data_read,
 };
 
@@ -70,7 +69,7 @@ static struct vio_device_id pseries_rng_driver_ids[] = {
 MODULE_DEVICE_TABLE(vio, pseries_rng_driver_ids);
 
 static struct vio_driver pseries_rng_driver = {
-	.name = MODULE_NAME,
+	.name = KBUILD_MODNAME,
 	.probe = pseries_rng_probe,
 	.remove = pseries_rng_remove,
 	.get_desired_dma = pseries_rng_get_desired_dma,
-- 
1.8.1.2
