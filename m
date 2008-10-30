Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E865C474E5
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 06:56:35 +1100 (EST)
Date: Thu, 30 Oct 2008 22:56:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] mmc: Add mmc_vddrange_to_ocrmask() helper function
Message-ID: <20081030195632.GB13640@oksana.dev.rtsoft.ru>
References: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This function sets the OCR mask bits according to provided voltage
ranges. Will be used by the mmc_spi OpenFirmware bindings.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/core/core.c  |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h |    3 ++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 044d84e..d4afae8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/leds.h>
 #include <linux/scatterlist.h>
+#include <linux/log2.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -444,6 +445,60 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 	mmc_set_ios(host);
 }
 
+static int mmc_vdd_to_ocrbit(int vdd)
+{
+	int bit;
+	const int max_bit = ilog2(MMC_VDD_35_36);
+
+	if (vdd < 1650 || vdd > 3600)
+		return -EINVAL;
+
+	if (vdd >= 1650 && vdd <= 1950)
+		return ilog2(MMC_VDD_165_195);
+
+	/* base 2000 mV, step 100 mV, bit's base 8 */
+	bit = (vdd - 2000) / 100 + 8;
+	if (bit > max_bit)
+		return max_bit;
+	return bit;
+}
+
+/**
+ * mmc_vddrange_to_ocrmask - Convert a voltage range to the OCR mask
+ * @vdd_min:	minimum voltage value (mV)
+ * @vdd_max:	maximum voltage value (mV)
+ * @mask:	pointer to the mask
+ *
+ * This function sets the OCR mask bits according to the provided @vdd_min
+ * and @vdd_max values.
+ *
+ * NOTE: You _must_ set the mask value to 0 before calling this function the
+ *       first time. This is done so that you can call this function several
+ *       times to set OCR mask for discontinuous voltage ranges.
+ *
+ * The function returns 0 on success and a negative errno value when
+ * a conversion is not possible.
+ */
+int mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max, unsigned int *mask)
+{
+	if (vdd_max < vdd_min)
+		return -EINVAL;
+
+	vdd_max = mmc_vdd_to_ocrbit(vdd_max);
+	if (vdd_max < 0)
+		return -EINVAL;
+
+	vdd_min = mmc_vdd_to_ocrbit(vdd_min);
+	if (vdd_min < 0)
+		return -EINVAL;
+
+	/* fill the mask, from max bit to min bit */
+	while (vdd_max >= vdd_min)
+		*mask |= 1 << vdd_max--;
+	return 0;
+}
+EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
+
 /*
  * Mask off any voltages we don't support and select
  * the lowest voltage
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 143cebf..3b139b0 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -151,4 +151,7 @@ static inline void mmc_claim_host(struct mmc_host *host)
 	__mmc_claim_host(host, NULL);
 }
 
+extern int mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max,
+				   unsigned int *mask);
+
 #endif
-- 
1.5.6.3
