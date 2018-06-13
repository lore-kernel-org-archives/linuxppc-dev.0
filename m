Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 415NWL4x8SzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 20:38:06 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <de5703e6c8e86ae86a9ac0d2a71f2103c4a1d30a.1528885172.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
Date: Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
device found in those models was never supported by this driver.
Attempting to load the driver usually causes a boot hang.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/mac/misc.c           | 6 ++----
 drivers/macintosh/via-pmu68k.c | 4 ----
 include/uapi/linux/pmu.h       | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index c68054361615..7ccb799eeb57 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -478,8 +478,7 @@ void mac_poweroff(void)
 		cuda_shutdown();
 #endif
 #ifdef CONFIG_ADB_PMU68K
-	} else if (macintosh_config->adb_type == MAC_ADB_PB1
-		|| macintosh_config->adb_type == MAC_ADB_PB2) {
+	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_shutdown();
 #endif
 	}
@@ -520,8 +519,7 @@ void mac_reset(void)
 		cuda_restart();
 #endif
 #ifdef CONFIG_ADB_PMU68K
-	} else if (macintosh_config->adb_type == MAC_ADB_PB1
-		|| macintosh_config->adb_type == MAC_ADB_PB2) {
+	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
 #endif
 	} else if (CPU_IS_030) {
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
index d545ed45e482..bec8e1837d7d 100644
--- a/drivers/macintosh/via-pmu68k.c
+++ b/drivers/macintosh/via-pmu68k.c
@@ -175,9 +175,6 @@ static s8 pmu_data_len[256][2] = {
 int __init find_via_pmu(void)
 {
 	switch (macintosh_config->adb_type) {
-	case MAC_ADB_PB1:
-		pmu_kind = PMU_68K_V1;
-		break;
 	case MAC_ADB_PB2:
 		pmu_kind = PMU_68K_V2;
 		break;
@@ -785,7 +782,6 @@ pmu_enable_backlight(int on)
 	    /* first call: get current backlight value */
 	    if (backlight_level < 0) {
 		switch(pmu_kind) {
-		    case PMU_68K_V1:
 		    case PMU_68K_V2:
 			pmu_request(&req, NULL, 3, PMU_READ_NVRAM, 0x14, 0xe);
 			while (!req.complete)
diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
index 89cb1acea93a..e128f609281a 100644
--- a/include/uapi/linux/pmu.h
+++ b/include/uapi/linux/pmu.h
@@ -93,7 +93,7 @@ enum {
 	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
 	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
 	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
-	PMU_68K_V1,		/* 68K PMU, version 1 */
+	PMU_68K_V1,		/* Unused/deprecated */
 	PMU_68K_V2, 		/* 68K PMU, version 2 */
 };
 
-- 
2.16.4
