Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C90E02C010C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 05:04:25 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 2 Oct 2013 00:34:21 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D71F9E0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 00:35:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r91J6iVM38273096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 00:36:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r91J4FR7020277
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 00:34:15 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v3] powerpc/kernel/sysfs: Disable writing to PURR in guest mode
Date: Wed,  2 Oct 2013 00:34:10 +0530
Message-Id: <1380654250-11526-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/kernel/sysfs.c exports PURR with write permission.
This may be valid for kernel in phyp mode. But writing to
the file in guest mode causes crash.

# echo 0 > purr
cpu 0x0: Vector: 700 (Program Check) at [c000000000d072b0]
    pc: c00000000001770c: .write_purr+0x1c/0x40
    lr: c000000000017708: .write_purr+0x18/0x40
    sp: c000000000d07530
   msr: 8000000000049032
  current = 0xc000000000c53de0
  paca    = 0xc00000000ec70000	 softe: 0	 irq_happened: 0x01
    pid   = 0, comm = swapper/0
enter ? for help
[c000000000d075b0] c0000000000fba64
.generic_smp_call_function_single_interrupt+0x104/0x190
[c000000000d07650] c000000000037748 .smp_ipi_demux+0xa8/0xf0
[c000000000d076e0] c000000000035314 .doorbell_exception+0x74/0xb0
[c000000000d07760] c000000000002950 doorbell_super_common+0x150/0x180
--- Exception: a01 (Doorbell) at c000000000060904
.plpar_hcall_norets+0x84/0xd4
[link register   ] c00000000006dbd4 .check_and_cede_processor+0x24/0x40
[c000000000d07a50] c000000001002558 (unreliable)
[c000000000d07ac0] c00000000006dd0c .shared_cede_loop+0x2c/0x70
[c000000000d07b40] c0000000006ae954 .cpuidle_enter_state+0x64/0x150
[c000000000d07c00] c0000000006aeb30 .cpuidle_idle_call+0xf0/0x300
[c000000000d07cb0] c000000000062fa0 .pseries_lpar_idle+0x10/0x50
[c000000000d07d20] c000000000016d14 .arch_cpu_idle+0x64/0x150
[c000000000d07da0] c0000000000e0060 .cpu_startup_entry+0x1a0/0x2c0
[c000000000d07e80] c00000000000bca4 .rest_init+0x94/0xb0
[c000000000d07ef0] c000000000b54530 .start_kernel+0x478/0x494
[c000000000d07f90] c000000000009be0 .start_here_common+0x20/0x40
0:mon>

v3 changes:
1) Changed the test for to firmware lpar feature support instead of hypervisor
2) Removed type cast
3) changed the commit to explain better.

v2 changes:
1) Changed the test for to hypervisor mode instead of platform

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 27a90b9..b4e6676 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -17,6 +17,7 @@
 #include <asm/machdep.h>
 #include <asm/smp.h>
 #include <asm/pmc.h>
+#include <asm/firmware.h>
 
 #include "cacheinfo.h"
 
@@ -179,15 +180,25 @@ SYSFS_PMCSETUP(spurr, SPRN_SPURR);
 SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 SYSFS_PMCSETUP(pir, SPRN_PIR);
 
+/*
+  Lets only enable read for phyp resources and
+  enable write when needed with a separate function.
+  Lets be conservative and default to pseries.
+*/
 static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
 static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
 static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
-static DEVICE_ATTR(purr, 0600, show_purr, store_purr);
+static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
 static DEVICE_ATTR(pir, 0400, show_pir, NULL);
 
 unsigned long dscr_default = 0;
 EXPORT_SYMBOL(dscr_default);
 
+static void add_write_permission_dev_attr(struct device_attribute *attr)
+{
+	attr->attr.mode |= 0200;
+}
+
 static ssize_t show_dscr_default(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -394,8 +405,11 @@ static void register_cpu_online(unsigned int cpu)
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		device_create_file(s, &dev_attr_mmcra);
 
-	if (cpu_has_feature(CPU_FTR_PURR))
+	if (cpu_has_feature(CPU_FTR_PURR)) {
+		if (!firmware_has_feature(FW_FEATURE_LPAR))
+			add_write_permission_dev_attr(&dev_attr_purr);
 		device_create_file(s, &dev_attr_purr);
+	}
 
 	if (cpu_has_feature(CPU_FTR_SPURR))
 		device_create_file(s, &dev_attr_spurr);
-- 
1.7.10.4
