Return-Path: <baolex.ni@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3YSp0y3szDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:12:25 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mikey@neuling.org, ego@linux.vnet.ibm.com, chuansheng.liu@intel.com,
 baolex.ni@intel.com
Subject: [PATCH 0019/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:34:45 +0800
Message-Id: <20160802103445.15027-1-baolex.ni@intel.com>
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
 arch/powerpc/platforms/powernv/subcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 0babef1..efffe94 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -402,7 +402,7 @@ static ssize_t show_subcores_per_core(struct device *dev,
 	return sprintf(buf, "%x\n", subcores_per_core);
 }
 
-static DEVICE_ATTR(subcores_per_core, 0644,
+static DEVICE_ATTR(subcores_per_core, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		show_subcores_per_core, store_subcores_per_core);
 
 static int subcore_init(void)
-- 
2.9.2
