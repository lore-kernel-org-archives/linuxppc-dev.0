Return-Path: <baolex.ni@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3Z161Vm6zDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:36:57 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: colin@colino.net, benh@kernel.crashing.org, hal.rosenstock@gmail.com,
 dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0313/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:59:11 +0800
Message-Id: <20160802105911.2408-1-baolex.ni@intel.com>
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
 drivers/macintosh/therm_adt746x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f433521..23c2e3c 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -58,11 +58,11 @@ MODULE_DESCRIPTION("Driver for ADT746x thermostat in iBook G4 and "
 		   "Powerbook G4 Alu");
 MODULE_LICENSE("GPL");
 
-module_param(limit_adjust, int, 0644);
+module_param(limit_adjust, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50 sensor1, 70 sensor2) "
 		 "by N degrees.");
 
-module_param(fan_speed, int, 0644);
+module_param(fan_speed, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fan_speed,"Specify starting fan speed (0-255) "
 		 "(default 64)");
 
-- 
2.9.2
