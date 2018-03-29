Return-Path: <ran.wang_1@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe49::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BYrn6c8ZzF0W1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 16:55:49 +1100 (AEDT)
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Scott Wood
 <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>, Li Yang
 <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Ran
 Wang <ran.wang_1@nxp.com>
Subject: [PATCH 3/5] powerpc/cache: add cache flush operation for various e500
Date: Thu, 29 Mar 2018 09:31:41 +0800
Message-ID: <20180329013143.22527-3-ran.wang_1@nxp.com>
In-Reply-To: <20180329013143.22527-1-ran.wang_1@nxp.com>
References: <20180329013143.22527-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Various e500 core have different cache architecture, so they
need different cache flush operations. Therefore, add a callback
function cpu_flush_caches to the struct cpu_spec. The cache flush
operation for the specific kind of e500 is selected at init time.
The callback function will flush all caches in the current cpu.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Reviewed-by: Yang Li <LeoLi@freescale.com>
Reviewed-by: Jose Rivera <German.Rivera@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/powerpc/include/asm/cputable.h       |   12 ++++
 arch/powerpc/kernel/asm-offsets.c         |    3 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   81 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c            |    4 ++
 4 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a2c5c95..364e6cf 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -44,6 +44,14 @@ enum powerpc_pmc_type {
 extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
 extern int machine_check_47x(struct pt_regs *regs);
+
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+extern void __flush_caches_e500v2(void);
+extern void __flush_caches_e500mc(void);
+extern void __flush_caches_e5500(void);
+extern void __flush_caches_e6500(void);
+#endif
+
 int machine_check_8xx(struct pt_regs *regs);
 
 extern void cpu_down_flush_e500v2(void);
@@ -70,6 +78,10 @@ struct cpu_spec {
 	/* flush caches inside the current cpu */
 	void (*cpu_down_flush)(void);
 
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+	/* flush caches of the cpu which is running the function */
+	void (*cpu_flush_caches)(void);
+#endif
 	/* number of performance monitor counters */
 	unsigned int	num_pmcs;
 	enum powerpc_pmc_type pmc_type;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ea5eb91..cb4b869 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -351,6 +351,9 @@ int main(void)
 	OFFSET(CPU_SPEC_FEATURES, cpu_spec, cpu_features);
 	OFFSET(CPU_SPEC_SETUP, cpu_spec, cpu_setup);
 	OFFSET(CPU_SPEC_RESTORE, cpu_spec, cpu_restore);
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+	OFFSET(CPU_FLUSH_CACHES, cpu_spec, cpu_flush_caches);
+#endif
 
 	OFFSET(pbe_address, pbe, address);
 	OFFSET(pbe_orig_address, pbe, orig_address);
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 462aed9..e94eb41 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -345,3 +345,84 @@ _GLOBAL(cpu_down_flush_e5500)
 /* L1 Data Cache of e6500 contains no modified data, no flush is required */
 _GLOBAL(cpu_down_flush_e6500)
 	blr
+
+_GLOBAL(__flush_caches_e500v2)
+	mflr r0
+	bl	flush_dcache_L1
+	mtlr r0
+	blr
+
+_GLOBAL(__flush_caches_e500mc)
+_GLOBAL(__flush_caches_e5500)
+	mflr r0
+	bl	flush_dcache_L1
+	bl	flush_backside_L2_cache
+	mtlr r0
+	blr
+
+/* L1 Data Cache of e6500 contains no modified data, no flush is required */
+_GLOBAL(__flush_caches_e6500)
+	blr
+
+	/* r3 = virtual address of L2 controller, WIMG = 01xx */
+_GLOBAL(flush_disable_L2)
+	/* It's a write-through cache, so only invalidation is needed. */
+	mbar
+	isync
+	lwz	r4, 0(r3)
+	li	r5, 1
+	rlwimi	r4, r5, 30, 0xc0000000
+	stw	r4, 0(r3)
+
+	/* Wait for the invalidate to finish */
+1:	lwz	r4, 0(r3)
+	andis.	r4, r4, 0x4000
+	bne	1b
+	mbar
+
+	blr
+
+	/* r3 = virtual address of L2 controller, WIMG = 01xx */
+_GLOBAL(invalidate_enable_L2)
+	mbar
+	isync
+	lwz	r4, 0(r3)
+	li	r5, 3
+	rlwimi	r4, r5, 30, 0xc0000000
+	stw	r4, 0(r3)
+
+	/* Wait for the invalidate to finish */
+1:	lwz	r4, 0(r3)
+	andis.	r4, r4, 0x4000
+	bne	1b
+	mbar
+
+	blr
+
+/* Flush L1 d-cache, invalidate and disable d-cache and i-cache */
+_GLOBAL(__flush_disable_L1)
+	mflr	r10
+	bl	flush_dcache_L1	/* Flush L1 d-cache */
+	mtlr	r10
+
+	mfspr	r4, SPRN_L1CSR0	/* Invalidate and disable d-cache */
+	li	r5, 2
+	rlwimi	r4, r5, 0, 3
+
+	msync
+	isync
+	mtspr	SPRN_L1CSR0, r4
+	isync
+
+1:	mfspr	r4, SPRN_L1CSR0	/* Wait for the invalidate to finish */
+	andi.	r4, r4, 2
+	bne	1b
+
+	mfspr	r4, SPRN_L1CSR1	/* Invalidate and disable i-cache */
+	li	r5, 2
+	rlwimi	r4, r5, 0, 3
+
+	mtspr	SPRN_L1CSR1, r4
+	isync
+
+	blr
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c40a9fc..eec3ca7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2100,6 +2100,7 @@
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 		.cpu_down_flush		= cpu_down_flush_e500v2,
+		.cpu_flush_caches	= __flush_caches_e500v2,
 	},
 #else
 	{	/* e500mc */
@@ -2120,6 +2121,7 @@
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
 		.cpu_down_flush		= cpu_down_flush_e500mc,
+		.cpu_flush_caches	= __flush_caches_e500mc,
 	},
 #endif /* CONFIG_PPC_E500MC */
 #endif /* CONFIG_PPC32 */
@@ -2145,6 +2147,7 @@
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce5500",
 		.cpu_down_flush		= cpu_down_flush_e5500,
+		.cpu_flush_caches	= __flush_caches_e5500,
 	},
 	{	/* e6500 */
 		.pvr_mask		= 0xffff0000,
@@ -2168,6 +2171,7 @@
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce6500",
 		.cpu_down_flush		= cpu_down_flush_e6500,
+		.cpu_flush_caches	= __flush_caches_e6500,
 	},
 #endif /* CONFIG_PPC_E500MC */
 #ifdef CONFIG_PPC32
-- 
1.7.1
