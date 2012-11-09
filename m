Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/12] powerpc: Move get_longbusy_msecs into hvcall.h and
 remove duplicate function
Date: Fri,  9 Nov 2012 17:19:09 +1100
Message-Id: <1352441953-29096-12-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

I am going to use this in the next patch, better to have this code in
one place rather than three.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hvcall.h         |   20 ++++++++++++++++++++
 drivers/infiniband/hw/ehca/hcp_if.c       |   20 --------------------
 drivers/net/ethernet/ibm/ehea/ehea_phyp.h |   20 --------------------
 3 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a3d26d8..0975e5c 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -356,6 +356,26 @@ struct hvcall_mpp_x_data {
 
 int h_get_mpp_x(struct hvcall_mpp_x_data *mpp_x_data);
 
+static inline unsigned int get_longbusy_msecs(int longbusy_rc)
+{
+	switch (longbusy_rc) {
+	case H_LONG_BUSY_ORDER_1_MSEC:
+		return 1;
+	case H_LONG_BUSY_ORDER_10_MSEC:
+		return 10;
+	case H_LONG_BUSY_ORDER_100_MSEC:
+		return 100;
+	case H_LONG_BUSY_ORDER_1_SEC:
+		return 1000;
+	case H_LONG_BUSY_ORDER_10_SEC:
+		return 10000;
+	case H_LONG_BUSY_ORDER_100_SEC:
+		return 100000;
+	default:
+		return 1;
+	}
+}
+
 #ifdef CONFIG_PPC_PSERIES
 extern int CMO_PrPSP;
 extern int CMO_SecPSP;
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 2d41d04..89517ff 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -90,26 +90,6 @@
 
 static DEFINE_SPINLOCK(hcall_lock);
 
-static u32 get_longbusy_msecs(int longbusy_rc)
-{
-	switch (longbusy_rc) {
-	case H_LONG_BUSY_ORDER_1_MSEC:
-		return 1;
-	case H_LONG_BUSY_ORDER_10_MSEC:
-		return 10;
-	case H_LONG_BUSY_ORDER_100_MSEC:
-		return 100;
-	case H_LONG_BUSY_ORDER_1_SEC:
-		return 1000;
-	case H_LONG_BUSY_ORDER_10_SEC:
-		return 10000;
-	case H_LONG_BUSY_ORDER_100_SEC:
-		return 100000;
-	default:
-		return 1;
-	}
-}
-
 static long ehca_plpar_hcall_norets(unsigned long opcode,
 				    unsigned long arg1,
 				    unsigned long arg2,
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_phyp.h b/drivers/net/ethernet/ibm/ehea/ehea_phyp.h
index 8364815..99b6c2a 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_phyp.h
+++ b/drivers/net/ethernet/ibm/ehea/ehea_phyp.h
@@ -39,26 +39,6 @@
  * hcp_*  - structures, variables and functions releated to Hypervisor Calls
  */
 
-static inline u32 get_longbusy_msecs(int long_busy_ret_code)
-{
-	switch (long_busy_ret_code) {
-	case H_LONG_BUSY_ORDER_1_MSEC:
-		return 1;
-	case H_LONG_BUSY_ORDER_10_MSEC:
-		return 10;
-	case H_LONG_BUSY_ORDER_100_MSEC:
-		return 100;
-	case H_LONG_BUSY_ORDER_1_SEC:
-		return 1000;
-	case H_LONG_BUSY_ORDER_10_SEC:
-		return 10000;
-	case H_LONG_BUSY_ORDER_100_SEC:
-		return 100000;
-	default:
-		return 1;
-	}
-}
-
 /* Number of pages which can be registered at once by H_REGISTER_HEA_RPAGES */
 #define EHEA_MAX_RPAGE 512
 
-- 
1.7.9.5
