Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] hwrng: Return errors to upper levels in pseries-rng.c
Date: Wed, 25 Sep 2013 19:24:17 +1000
Message-Id: <1380101057-29903-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1380101057-29903-1-git-send-email-michael@ellerman.id.au>
References: <1380101057-29903-1-git-send-email-michael@ellerman.id.au>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, mpm@selenic.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't expect to get errors from the hypervisor when reading the rng,
but if we do we should pass the error up to the hwrng driver. Otherwise
the hwrng driver will continue calling us forever.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/char/hw_random/pseries-rng.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/pseries-rng.c
index 9dbeed3..ab7ffde 100644
--- a/drivers/char/hw_random/pseries-rng.c
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -17,6 +17,9 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/hw_random.h>
 #include <asm/vio.h>
@@ -24,10 +27,15 @@
 
 static int pseries_rng_data_read(struct hwrng *rng, u32 *data)
 {
-	if (plpar_hcall(H_RANDOM, (unsigned long *)data) != H_SUCCESS) {
-		printk(KERN_ERR "pseries rng hcall error\n");
-		return 0;
+	int rc;
+
+	rc = plpar_hcall(H_RANDOM, (unsigned long *)data);
+	if (rc != H_SUCCESS) {
+		pr_err_ratelimited("H_RANDOM call failed %d\n", rc);
+		return -EIO;
 	}
+
+	/* The hypervisor interface returns 64 bits */
 	return 8;
 }
 
-- 
1.8.1.2
