Return-Path: <baolex.ni@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3YSc3w8SzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:12:15 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0017/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:34:34 +0800
Message-Id: <20160802103434.14890-1-baolex.ni@intel.com>
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
 arch/powerpc/platforms/cell/spu_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 3cbe38f..0236844 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -674,7 +674,7 @@ static ssize_t spu_stat_show(struct device *dev,
 		spu->stats.libassist);
 }
 
-static DEVICE_ATTR(stat, 0444, spu_stat_show, NULL);
+static DEVICE_ATTR(stat, S_IRUSR | S_IRGRP | S_IROTH, spu_stat_show, NULL);
 
 #ifdef CONFIG_KEXEC
 
-- 
2.9.2
