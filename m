Return-Path: <baolex.ni@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3YSp4fqZzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:12:26 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 adam.buchbinder@gmail.com, stewart@linux.vnet.ibm.com,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0018/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:34:39 +0800
Message-Id: <20160802103439.14958-1-baolex.ni@intel.com>
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
 arch/powerpc/platforms/powernv/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index fcc8b68..69232b1 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -226,7 +226,7 @@ fail:
 	return -EIO;
 }
 
-static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
+static DEVICE_ATTR(fastsleep_workaround_applyonce, S_IRUSR | S_IWUSR,
 			show_fastsleep_workaround_applyonce,
 			store_fastsleep_workaround_applyonce);
 
-- 
2.9.2
