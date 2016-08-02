Return-Path: <baolex.ni@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3YSV2FHQzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 21:12:08 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux@armlinux.org.uk
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0015/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:34:27 +0800
Message-Id: <20160802103427.14758-1-baolex.ni@intel.com>
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
 arch/powerpc/kernel/sysfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 692873b..b2495e8 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -63,7 +63,7 @@ static ssize_t show_smt_snooze_delay(struct device *dev,
 	return sprintf(buf, "%ld\n", per_cpu(smt_snooze_delay, cpu->dev.id));
 }
 
-static DEVICE_ATTR(smt_snooze_delay, 0644, show_smt_snooze_delay,
+static DEVICE_ATTR(smt_snooze_delay, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, show_smt_snooze_delay,
 		   store_smt_snooze_delay);
 
 static int __init setup_smt_snooze_delay(char *str)
@@ -360,8 +360,8 @@ static ssize_t store_altivec_idle_wait_time(struct device *dev,
  * Enable/Disable interface:
  * 0, disable. 1, enable.
  */
-static DEVICE_ATTR(pw20_state, 0600, show_pw20_state, store_pw20_state);
-static DEVICE_ATTR(altivec_idle, 0600, show_altivec_idle, store_altivec_idle);
+static DEVICE_ATTR(pw20_state, S_IRUSR | S_IWUSR, show_pw20_state, store_pw20_state);
+static DEVICE_ATTR(altivec_idle, S_IRUSR | S_IWUSR, show_altivec_idle, store_altivec_idle);
 
 /*
  * Set wait time interface:(Nanosecond)
@@ -374,10 +374,10 @@ static DEVICE_ATTR(altivec_idle, 0600, show_altivec_idle, store_altivec_idle);
  * 781~1560(ns): TB[58]
  * ...
  */
-static DEVICE_ATTR(pw20_wait_time, 0600,
+static DEVICE_ATTR(pw20_wait_time, S_IRUSR | S_IWUSR,
 			show_pw20_wait_time,
 			store_pw20_wait_time);
-static DEVICE_ATTR(altivec_idle_wait_time, 0600,
+static DEVICE_ATTR(altivec_idle_wait_time, S_IRUSR | S_IWUSR,
 			show_altivec_idle_wait_time,
 			store_altivec_idle_wait_time);
 #endif
@@ -491,10 +491,10 @@ SYSFS_SPRSETUP(pir, SPRN_PIR);
   enable write when needed with a separate function.
   Lets be conservative and default to pseries.
 */
-static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
-static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
-static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
-static DEVICE_ATTR(pir, 0400, show_pir, NULL);
+static DEVICE_ATTR(mmcra, S_IRUSR | S_IWUSR, show_mmcra, store_mmcra);
+static DEVICE_ATTR(spurr, S_IRUSR, show_spurr, NULL);
+static DEVICE_ATTR(purr, S_IRUSR, show_purr, store_purr);
+static DEVICE_ATTR(pir, S_IRUSR, show_pir, NULL);
 
 /*
  * This is the system wide DSCR register default value. Any
@@ -534,7 +534,7 @@ static void write_dscr(void *val)
 }
 
 SYSFS_SPRSETUP_SHOW_STORE(dscr);
-static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
+static DEVICE_ATTR(dscr, S_IRUSR | S_IWUSR, show_dscr, store_dscr);
 
 static void add_write_permission_dev_attr(struct device_attribute *attr)
 {
@@ -581,7 +581,7 @@ static ssize_t __used store_dscr_default(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dscr_default, 0600,
+static DEVICE_ATTR(dscr_default, S_IRUSR | S_IWUSR,
 		show_dscr_default, store_dscr_default);
 
 static void sysfs_create_dscr_default(void)
@@ -1019,7 +1019,7 @@ static ssize_t show_physical_id(struct device *dev,
 
 	return sprintf(buf, "%d\n", get_hard_smp_processor_id(cpu->dev.id));
 }
-static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
+static DEVICE_ATTR(physical_id, S_IRUSR | S_IRGRP | S_IROTH, show_physical_id, NULL);
 
 static int __init topology_init(void)
 {
-- 
2.9.2
