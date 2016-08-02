Return-Path: <baolex.ni@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3Z100bmLzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:36:51 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: linux-kernel@hansmi.ch, benh@kernel.crashing.org, hal.rosenstock@gmail.com,
 dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0312/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:59:07 +0800
Message-Id: <20160802105907.2342-1-baolex.ni@intel.com>
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
 drivers/macintosh/ams/ams-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/ams/ams-core.c b/drivers/macintosh/ams/ams-core.c
index 36a4fdd..8abbecd 100644
--- a/drivers/macintosh/ams/ams-core.c
+++ b/drivers/macintosh/ams/ams-core.c
@@ -32,7 +32,7 @@
 struct ams ams_info;
 
 static bool verbose;
-module_param(verbose, bool, 0644);
+module_param(verbose, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(verbose, "Show free falls and shocks in kernel output");
 
 /* Call with ams_info.lock held! */
-- 
2.9.2
