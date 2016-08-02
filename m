Return-Path: <baolex.ni@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3c5Q0s02zDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 23:10:49 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, kadlec@blackhole.kfki.hu, davem@davemloft.net,
 m.szyprowski@samsung.com, kyungmin.park@samsung.com,
 k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
 baolex.ni@intel.com, aryabinin@virtuozzo.com
Subject: [PATCH 1263/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:32:41 +0800
Message-Id: <20160802123241.2166-1-baolex.ni@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/ppc/powermac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/powermac.c b/sound/ppc/powermac.c
index 33c6be9..d6498cd 100644
--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -38,11 +38,11 @@ static int index = SNDRV_DEFAULT_IDX1;		/* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;		/* ID for this card */
 static bool enable_beep = 1;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CHIP_NAME " soundchip.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CHIP_NAME " soundchip.");
-module_param(enable_beep, bool, 0444);
+module_param(enable_beep, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable_beep, "Enable beep using PCM.");
 
 static struct platform_device *device;
-- 
2.9.2
