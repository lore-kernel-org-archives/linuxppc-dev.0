Return-Path: <baolex.ni@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3Zr56cD5zDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 22:14:13 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: imunsie@au1.ibm.com, mikey@neuling.org,
 suganath-prabu.subramani@broadcom.com, mchehab@redhat.com,
 m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com,
 kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com, geliangtang@163.com
Subject: [PATCH 0683/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:36:30 +0800
Message-Id: <20160802113630.27598-1-baolex.ni@intel.com>
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
 drivers/misc/cxl/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index ae68c32..98b36a6 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -29,7 +29,7 @@ static DEFINE_SPINLOCK(adapter_idr_lock);
 static DEFINE_IDR(cxl_adapter_idr);
 
 uint cxl_verbose;
-module_param_named(verbose, cxl_verbose, uint, 0600);
+module_param_named(verbose, cxl_verbose, uint, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
 
 const struct cxl_backend_ops *cxl_ops;
-- 
2.9.2
