Return-Path: <baolex.ni@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3Z0r75cZzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:36:44 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: benh@kernel.crashing.org, j.anaszewski@samsung.com,
 hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com,
 bp@alien8.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0311/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:59:03 +0800
Message-Id: <20160802105903.2209-1-baolex.ni@intel.com>
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
 drivers/macintosh/adbhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 09d72bb..d6cbd1d 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -53,7 +53,7 @@
 MODULE_AUTHOR("Franz Sirl <Franz.Sirl-kernel@lauterbach.com>");
 
 static int restore_capslock_events;
-module_param(restore_capslock_events, int, 0644);
+module_param(restore_capslock_events, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(restore_capslock_events,
 	"Produce keypress events for capslock on both keyup and keydown.");
 
-- 
2.9.2
