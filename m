Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCRc51YvczDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 21:17:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, benh@kernel.crashing.org, stewart@linux.vnet.ibm.com,
 cyrilbur@gmail.com
Subject: [PATCH 1/4] powerpc/tm: Add commandline option to disable hardware
 transactional memory
Date: Thu, 12 Oct 2017 21:17:16 +1100
Message-Id: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cyril Bur <cyrilbur@gmail.com>

Currently the kernel relies on firmware to inform it whether or not the
CPU supports HTM and as long as the kernel was built with
CONFIG_PPC_TRANSACTIONAL_MEM=y then it will allow userspace to make
use of the facility.

There may be situations where it would be advantageous for the kernel
to not allow userspace to use HTM, currently the only way to achieve
this is to recompile the kernel with CONFIG_PPC_TRANSACTIONAL_MEM=n.

This patch adds a simple commandline option so that HTM can be
disabled at boot time.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
[mpe: Simplify to a bool, move to prom.c, put doco in the right place.
 Always disable, regardless of initial state, to avoid user confusion.]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/powerpc/kernel/prom.c                      | 31 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 05496622b4ef..ef03e6e16bdb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3185,6 +3185,10 @@
 			allowed (eg kernel_enable_fpu()/kernel_disable_fpu()).
 			There is some performance impact when enabling this.
 
+	ppc_tm=		[PPC]
+			Format: {"off"}
+			Disable Hardware Transactional Memory
+
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f83056297441..d9bd6555f980 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -658,6 +658,35 @@ static void __init early_reserve_mem(void)
 #endif
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static bool tm_disabled __initdata;
+
+static int __init parse_ppc_tm(char *str)
+{
+	bool res;
+
+	if (kstrtobool(str, &res))
+		return -EINVAL;
+
+	tm_disabled = !res;
+
+	return 0;
+}
+early_param("ppc_tm", parse_ppc_tm);
+
+static void __init tm_init(void)
+{
+	if (tm_disabled) {
+		pr_info("Disabling hardware transactional memory (HTM)\n");
+		cur_cpu_spec->cpu_user_features2 &=
+			~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_TM;
+	}
+}
+#else
+static void tm_init(void) { }
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+
 void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
@@ -767,6 +796,8 @@ void __init early_init_devtree(void *params)
 		powerpc_firmware_features |= FW_FEATURE_PS3_POSSIBLE;
 #endif
 
+	tm_init();
+
 	DBG(" <- early_init_devtree()\n");
 }
 
-- 
2.7.4
