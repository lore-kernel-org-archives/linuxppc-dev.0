Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvLGT2cDXzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 10:20:49 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id o123so12974049pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 16:20:49 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id p19sm6421827pfl.15.2017.03.30.16.20.45
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Mar 2017 16:20:46 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: utilising darn instruction for
 get_random_seed on p9
Date: Fri, 31 Mar 2017 10:20:23 +1100
Message-Id: <20170330232023.15294-1-matthew.brown.dev@gmail.com>
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
'darn' instruction, introduced in power 9, allows us to bypass this by
directly obtaining a value from the mmio region.

This patch adds an alternative function for ppc_md.get_random_seed on p9,
utilising the darn instruction.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  4 ++++
 arch/powerpc/platforms/powernv/rng.c  | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

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
index 5dcbdea..db34f32 100644
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
@@ -67,6 +69,22 @@ int powernv_get_random_real_mode(unsigned long *v)
 	return 1;
 }
 
+int powernv_get_random_darn(unsigned long *v)
+{
+	int n = 0;
+	unsigned long val;
+
+	do {
+		/* Using DARN with L=1 - conditioned random number */
+		asm (PPC_DARN(%0, 1)"\n" : "=r"(val) :);
+		n++;
+	} while (val == DARN_ERR && n < 10);
+
+	*v = val;
+
+	return (val == DARN_ERR) ? 0 : 1;
+}
+
 int powernv_get_random_long(unsigned long *v)
 {
 	struct powernv_rng *rng;
@@ -128,7 +146,10 @@ static __init int rng_create(struct device_node *dn)
 
 	pr_info_once("Registering arch random hook.\n");
 
-	ppc_md.get_random_seed = powernv_get_random_long;
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		ppc_md.get_random_seed = powernv_get_random_darn;
+	else
+		ppc_md.get_random_seed = powernv_get_random_long;
 
 	return 0;
 }
-- 
2.9.3
