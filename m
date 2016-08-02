Return-Path: <baolex.ni@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3YSX66QRzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:12:12 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0016/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:34:30 +0800
Message-Id: <20160802103430.14824-1-baolex.ni@intel.com>
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
 arch/powerpc/platforms/cell/cbe_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/cbe_thermal.c b/arch/powerpc/platforms/cell/cbe_thermal.c
index 2c15ff0..39bc790 100644
--- a/arch/powerpc/platforms/cell/cbe_thermal.c
+++ b/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -254,9 +254,9 @@ static struct device_attribute attr_spu_temperature = {
 	.show = spu_show_temp,
 };
 
-static DEVICE_PREFIX_ATTR(spu, throttle_end, 0600);
-static DEVICE_PREFIX_ATTR(spu, throttle_begin, 0600);
-static DEVICE_PREFIX_ATTR(spu, throttle_full_stop, 0600);
+static DEVICE_PREFIX_ATTR(spu, throttle_end, S_IRUSR | S_IWUSR);
+static DEVICE_PREFIX_ATTR(spu, throttle_begin, S_IRUSR | S_IWUSR);
+static DEVICE_PREFIX_ATTR(spu, throttle_full_stop, S_IRUSR | S_IWUSR);
 
 
 static struct attribute *spu_attributes[] = {
@@ -282,9 +282,9 @@ static struct device_attribute attr_ppe_temperature1 = {
 	.show = ppe_show_temp1,
 };
 
-static DEVICE_PREFIX_ATTR(ppe, throttle_end, 0600);
-static DEVICE_PREFIX_ATTR(ppe, throttle_begin, 0600);
-static DEVICE_PREFIX_ATTR(ppe, throttle_full_stop, 0600);
+static DEVICE_PREFIX_ATTR(ppe, throttle_end, S_IRUSR | S_IWUSR);
+static DEVICE_PREFIX_ATTR(ppe, throttle_begin, S_IRUSR | S_IWUSR);
+static DEVICE_PREFIX_ATTR(ppe, throttle_full_stop, S_IRUSR | S_IWUSR);
 
 static struct attribute *ppe_attributes[] = {
 	&attr_ppe_temperature0.attr,
-- 
2.9.2
