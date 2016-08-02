Return-Path: <baolex.ni@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3bDL6tp8zDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 22:31:46 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: geoff@infradead.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, dwmw2@infradead.org, m.chehab@samsung.com,
 pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com,
 k.kozlowski@samsung.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0867/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:53:33 +0800
Message-Id: <20160802115333.7780-1-baolex.ni@intel.com>
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
 drivers/ps3/ps3av.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 437fc35..9753ed0 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -38,7 +38,7 @@
 static int safe_mode;
 
 static int timeout = 5000;	/* in msec ( 5 sec ) */
-module_param(timeout, int, 0644);
+module_param(timeout, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static struct ps3av {
 	struct mutex mutex;
-- 
2.9.2
