Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzLMf5WjfzDrF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 00:38:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH 6/6] powerpc/kernel: Check features don't change after patching
Date: Wed, 27 Jul 2016 00:38:15 +1000
Message-Id: <1469543895-27934-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469543895-27934-1-git-send-email-mpe@ellerman.id.au>
References: <1469543895-27934-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Early in boot we binary patch some sections of code based on the CPU and
MMU feature bits. But it is a one-time patching, there is no facility
for repatching the code later if the set of features change.

It is a major bug if the set of features changes after we've done the
code patching - so add a check for it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index defb2998b818..854b8ba40f8e 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -152,10 +152,19 @@ static void do_final_fixups(void)
 #endif
 }
 
-void apply_feature_fixups(void)
+static unsigned long __initdata saved_cpu_features;
+static unsigned int __initdata saved_mmu_features;
+#ifdef CONFIG_PPC64
+static unsigned long __initdata saved_firmware_features;
+#endif
+
+void __init apply_feature_fixups(void)
 {
 	struct cpu_spec *spec = *PTRRELOC(&cur_cpu_spec);
 
+	saved_cpu_features = spec->cpu_features;
+	saved_mmu_features = spec->mmu_features;
+
 	/*
 	 * Apply the CPU-specific and firmware specific fixups to kernel text
 	 * (nop out sections not relevant to this CPU or this firmware).
@@ -173,12 +182,28 @@ void apply_feature_fixups(void)
 			 PTRRELOC(&__stop___lwsync_fixup));
 
 #ifdef CONFIG_PPC64
+	saved_firmware_features = powerpc_firmware_features;
 	do_feature_fixups(powerpc_firmware_features,
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 #endif
 	do_final_fixups();
 }
 
+static int __init check_features(void)
+{
+	WARN(saved_cpu_features != cur_cpu_spec->cpu_features,
+	     "CPU features changed after feature patching!\n");
+	WARN(saved_mmu_features != cur_cpu_spec->mmu_features,
+	     "MMU features changed after feature patching!\n");
+#ifdef CONFIG_PPC64
+	WARN(saved_firmware_features != powerpc_firmware_features,
+	     "Firmware features changed after feature patching!\n");
+#endif
+
+	return 0;
+}
+late_initcall(check_features);
+
 #ifdef CONFIG_FTR_FIXUP_SELFTEST
 
 #define check(x)	\
-- 
2.7.4
