Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3ltc3jvpzDr5N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 17:03:04 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id q85so3399034pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 00:03:04 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [PATCH v2] powerpc/powernv: Use darn instr for random_seed on p9
Date: Fri,  7 Jul 2017 17:02:49 +1000
Message-Id: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently ppc_md.get_random_seed uses the powernv_get_random_long function.
A guest calling this function would have to go through the hypervisor. The
'darn' instruction, introduced in POWER9, allows us to bypass this by
directly obtaining a value from the mmio region.

This patch adds a function for ppc_md.get_random_seed on p9,
utilising the darn instruction.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v2:
	- remove repeat darn attempts
	- move hook to rng_init
---
 arch/powerpc/include/asm/ppc-opcode.h |  4 ++++
 arch/powerpc/platforms/powernv/rng.c  | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index c4ced1d..d5f7082 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -134,6 +134,7 @@
 #define PPC_INST_COPY			0x7c00060c
 #define PPC_INST_COPY_FIRST		0x7c20060c
 #define PPC_INST_CP_ABORT		0x7c00068c
+#define PPC_INST_DARN			0x7c0005e6
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
@@ -325,6 +326,9 @@
 
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_CP_ABORT		stringify_in_c(.long PPC_INST_CP_ABORT)
+#define PPC_DARN(t, l)		stringify_in_c(.long PPC_INST_DARN |  \
+						___PPC_RT(t)	   |  \
+						___PPC_RA(l))
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 5dcbdea..ab6f411 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -8,6 +8,7 @@
  */
 
 #define pr_fmt(fmt)	"powernv-rng: " fmt
+#define DARN_ERR 0xFFFFFFFFFFFFFFFFul
 
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -16,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <asm/archrandom.h>
+#include <asm/cputable.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -67,6 +69,21 @@ int powernv_get_random_real_mode(unsigned long *v)
 	return 1;
 }
 
+int powernv_get_random_darn(unsigned long *v)
+{
+	unsigned long val;
+
+	/* Using DARN with L=1 - conditioned random number */
+	asm (PPC_DARN(%0, 1)"\n" : "=r"(val) :);
+
+	if (val == DARN_ERR)
+		return 0;
+
+	*v = val;
+
+	return 1;
+}
+
 int powernv_get_random_long(unsigned long *v)
 {
 	struct powernv_rng *rng;
@@ -136,6 +153,7 @@ static __init int rng_create(struct device_node *dn)
 static __init int rng_init(void)
 {
 	struct device_node *dn;
+	unsigned long drn_test;
 	int rc;
 
 	for_each_compatible_node(dn, NULL, "ibm,power-rng") {
@@ -150,6 +168,10 @@ static __init int rng_init(void)
 		of_platform_device_create(dn, NULL, NULL);
 	}
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	    powernv_get_random_darn(&drn_test))
+		ppc_md.get_random_seed = powernv_get_random_darn;
+
 	return 0;
 }
 machine_subsys_initcall(powernv, rng_init);
-- 
2.9.3
