Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp6TR3NLWzDrX5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 03:12:43 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Expose TSCR via sysfs
Date: Fri,  8 Sep 2017 03:11:12 +1000
Message-Id: <20170907171112.29579-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

The thread switch control register (TSCR) is a per core register
that configures how the CPU shares resources between SMT threads.

Exposing it via sysfs allows us to tune it at run time.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 4437c70c7c2b..b60a441092b9 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -485,6 +485,7 @@ SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
 SYSFS_SPRSETUP(purr, SPRN_PURR);
 SYSFS_SPRSETUP(spurr, SPRN_SPURR);
 SYSFS_SPRSETUP(pir, SPRN_PIR);
+SYSFS_SPRSETUP(tscr, SPRN_TSCR);
 
 /*
   Lets only enable read for phyp resources and
@@ -495,6 +496,7 @@ static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
 static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
 static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
 static DEVICE_ATTR(pir, 0400, show_pir, NULL);
+static DEVICE_ATTR(tscr, 0600, show_tscr, store_tscr);
 
 /*
  * This is the system wide DSCR register default value. Any
@@ -774,6 +776,9 @@ static int register_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
 		device_create_file(s, &dev_attr_pir);
+
+	if (cpu_has_feature(CPU_FTR_ARCH_206))
+		device_create_file(s, &dev_attr_tscr);
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
@@ -856,6 +861,9 @@ static int unregister_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
 		device_remove_file(s, &dev_attr_pir);
+
+	if (cpu_has_feature(CPU_FTR_ARCH_206))
+		device_remove_file(s, &dev_attr_tscr);
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
-- 
2.11.0
