Return-Path: <b10716@zro03-ws408.ea.freescale.net>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE95B2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 00:14:00 +1000 (EST)
Received: from mail11-co9 (localhost [127.0.0.1])	by mail11-co9-R.bigfish.com
 (Postfix) with ESMTP id 8A7C84203AE	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 14:13:56 +0000 (UTC)
Received: from CO9EHSMHS020.bigfish.com (unknown [10.236.132.239])	by
 mail11-co9.bigfish.com (Postfix) with ESMTP id 17BC34E01A4	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 14:13:26 +0000 (UTC)
From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH][v3] powerpc/85xx: Move ePAPR paravirt initialization earlier
Date: Wed, 3 Jul 2013 17:13:15 +0300
Message-ID: <1372860795-14934-1-git-send-email-Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At console init, when the kernel tries to flush the log buffer
the ePAPR byte-channel based console write fails silently,
losing the buffered messages.
This happens because The ePAPR para-virtualization init isn't
done early enough so that the hcall instruction to be set,
causing the byte-channel write hcall to be a nop.
To fix, change the ePAPR para-virt init to use early device
tree functions and move it in early init.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
---
v3:
 - removed compatible check because qemu/kvm doesn't set it as per epapr
 - rearranged code
v2:
 - moved epapr init even earlier (in early init stage). context here:
     http://lists.ozlabs.org/pipermail/linuxppc-dev/2013-June/108116.html
 - reworded commit msg
 - re-based on git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

 arch/powerpc/include/asm/epapr_hcalls.h |    6 ++++++
 arch/powerpc/kernel/epapr_paravirt.c    |   28 ++++++++++++++++------------
 arch/powerpc/kernel/setup_32.c          |    4 +++-
 arch/powerpc/kernel/setup_64.c          |    3 +++
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index d3d6342..86b0ac7 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -105,6 +105,12 @@
 extern bool epapr_paravirt_enabled;
 extern u32 epapr_hypercall_start[];
 
+#ifdef CONFIG_EPAPR_PARAVIRT
+int __init epapr_paravirt_early_init(void);
+#else
+static inline int epapr_paravirt_early_init(void) { return 0; }
+#endif
+
 /*
  * We use "uintptr_t" to define a register because it's guaranteed to be a
  * 32-bit integer on a 32-bit platform, and a 64-bit integer on a 64-bit
diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index d44a571..6300c13 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -30,22 +30,20 @@ extern u32 epapr_ev_idle_start[];
 
 bool epapr_paravirt_enabled;
 
-static int __init epapr_paravirt_init(void)
+static int __init early_init_dt_scan_epapr(unsigned long node,
+					   const char *uname,
+					   int depth, void *data)
 {
-	struct device_node *hyper_node;
 	const u32 *insts;
-	int len, i;
+	unsigned long len;
+	int i;
 
-	hyper_node = of_find_node_by_path("/hypervisor");
-	if (!hyper_node)
-		return -ENODEV;
-
-	insts = of_get_property(hyper_node, "hcall-instructions", &len);
+	insts = of_get_flat_dt_prop(node, "hcall-instructions", &len);
 	if (!insts)
-		return -ENODEV;
+		return 0;
 
 	if (len % 4 || len > (4 * 4))
-		return -ENODEV;
+		return -1;
 
 	for (i = 0; i < (len / 4); i++) {
 		patch_instruction(epapr_hypercall_start + i, insts[i]);
@@ -55,13 +53,19 @@ static int __init epapr_paravirt_init(void)
 	}
 
 #if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
-	if (of_get_property(hyper_node, "has-idle", NULL))
+	if (of_get_flat_dt_prop(node, "has-idle", NULL))
 		ppc_md.power_save = epapr_ev_idle;
 #endif
 
 	epapr_paravirt_enabled = true;
 
+	return 1;
+}
+
+int __init epapr_paravirt_early_init(void)
+{
+	of_scan_flat_dt(early_init_dt_scan_epapr, NULL);
+
 	return 0;
 }
 
-early_initcall(epapr_paravirt_init);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a8f54ec..a4bbcae 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -38,6 +38,7 @@
 #include <asm/serial.h>
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
+#include <asm/epapr_hcalls.h>
 
 #include "setup.h"
 
@@ -128,6 +129,8 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
+	epapr_paravirt_early_init();
+
 	early_init_mmu();
 
 	probe_machine();
@@ -326,5 +329,4 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize the MMU context management stuff */
 	mmu_context_init();
-
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e379d3f..fd9941a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -66,6 +66,7 @@
 #include <asm/code-patching.h>
 #include <asm/kvm_ppc.h>
 #include <asm/hugetlb.h>
+#include <asm/epapr_hcalls.h>
 
 #include "setup.h"
 
@@ -215,6 +216,8 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	early_init_devtree(__va(dt_ptr));
 
+	epapr_paravirt_early_init();
+
 	/* Now we know the logical id of our boot cpu, setup the paca. */
 	setup_paca(&paca[boot_cpuid]);
 	fixup_boot_paca();
-- 
1.7.6.5
