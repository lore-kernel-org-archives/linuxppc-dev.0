Return-Path: <baolex.ni@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3c5V37B9zDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 23:10:54 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: geoff@infradead.org, perex@perex.cz, tiwai@suse.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com,
 k.kozlowski@samsung.com
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
 baolex.ni@intel.com, aryabinin@virtuozzo.com
Subject: [PATCH 1264/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:32:46 +0800
Message-Id: <20160802123246.2235-1-baolex.ni@intel.com>
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
 sound/ppc/snd_ps3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 3682425..594d694 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -51,15 +51,15 @@ static struct snd_ps3_card_info the_card;
 
 static int snd_ps3_start_delay = CONFIG_SND_PS3_DEFAULT_START_DELAY;
 
-module_param_named(start_delay, snd_ps3_start_delay, uint, 0644);
+module_param_named(start_delay, snd_ps3_start_delay, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(start_delay, "time to insert silent data in ms");
 
 static int index = SNDRV_DEFAULT_IDX1;
 static char *id = SNDRV_DEFAULT_STR1;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for PS3 soundchip.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for PS3 soundchip.");
 
 
-- 
2.9.2
