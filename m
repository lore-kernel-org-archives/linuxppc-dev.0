Return-Path: <baolex.ni@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3Yhx73LvzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:22:57 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: mchehab@kernel.org, maurochehab@gmail.com, mchehab@infradead.org,
 mchehab@redhat.com, m.chehab@samsung.com, olof@lixom.net, egor@pasemi.com,
 dougthompson@xmission.com, bp@alien8.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
 baolex.ni@intel.com, lee.jones@linaro.org
Subject: [PATCH 0157/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:45:15 +0800
Message-Id: <20160802104515.24206-1-baolex.ni@intel.com>
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
 drivers/edac/pasemi_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 9c971b5..8150e95 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -310,6 +310,6 @@ module_exit(pasemi_edac_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Egor Martovetsky <egor@pasemi.com>");
 MODULE_DESCRIPTION("MC support for PA Semi PWRficient memory controller");
-module_param(edac_op_state, int, 0444);
+module_param(edac_op_state, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
 
-- 
2.9.2
