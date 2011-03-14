Return-Path: <brking@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62874B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 08:50:11 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2ELYspX011757
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 15:34:54 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p2ELo58n114844
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 15:50:05 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p2ELo44Q008127
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 15:50:04 -0600
Message-Id: <201103142150.p2ELo3lZ008036@d03av04.boulder.ibm.com>
Subject: [PATCH 1/1] powerpc: Add page coalescing support
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 14 Mar 2011 16:50:11 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Adds support for page coalescing, which is a feature on IBM Power servers
which allows for coalescing identical pages between logical partitions.
Hint text pages as coalesce candidates, since they are the most likely
pages to be able to be coalesced between partitions. This patch also
exports some page coalescing statistics available from firmware via
lparcfg.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/firmware.h         |    3 +-
 arch/powerpc/include/asm/hvcall.h           |   12 ++++++++
 arch/powerpc/include/asm/pSeries_reconfig.h |    6 ++++
 arch/powerpc/kernel/lparcfg.c               |   40 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/prom_init.c             |    4 ++
 arch/powerpc/kernel/rtas.c                  |    2 +
 arch/powerpc/platforms/pseries/lpar.c       |    2 +
 arch/powerpc/platforms/pseries/setup.c      |   11 +++++++
 8 files changed, 78 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/include/asm/hvcall.h~powerpc_coalesce arch/powerpc/include/asm/hvcall.h
--- linux-2.6/arch/powerpc/include/asm/hvcall.h~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/include/asm/hvcall.h	2011-03-14 15:45:12.000000000 -0500
@@ -102,6 +102,7 @@
 #define H_ANDCOND		(1UL<<(63-33))
 #define H_ICACHE_INVALIDATE	(1UL<<(63-40))	/* icbi, etc.  (ignored for IO pages) */
 #define H_ICACHE_SYNCHRONIZE	(1UL<<(63-41))	/* dcbst, icbi, etc (ignored for IO pages */
+#define H_COALESCE_CAND	(1UL<<(63-42))	/* page is a good candidate for coalescing */
 #define H_ZERO_PAGE		(1UL<<(63-48))	/* zero the page before mapping (ignored for IO pages) */
 #define H_COPY_PAGE		(1UL<<(63-49))
 #define H_N			(1UL<<(63-61))
@@ -234,6 +235,7 @@
 #define H_GET_MPP		0x2D4
 #define H_HOME_NODE_ASSOCIATIVITY 0x2EC
 #define H_BEST_ENERGY		0x2F4
+#define H_GET_MPP_X		0x314
 #define MAX_HCALL_OPCODE	H_BEST_ENERGY
 
 #ifndef __ASSEMBLY__
@@ -312,6 +314,16 @@ struct hvcall_mpp_data {
 
 int h_get_mpp(struct hvcall_mpp_data *);
 
+struct hvcall_mpp_x_data {
+	unsigned long coalesced_bytes;
+	unsigned long pool_coalesced_bytes;
+	unsigned long pool_purr_cycles;
+	unsigned long pool_spurr_cycles;
+	unsigned long reserved[3];
+};
+
+int h_get_mpp_x(struct hvcall_mpp_x_data *mpp_x_data);
+
 #ifdef CONFIG_PPC_PSERIES
 extern int CMO_PrPSP;
 extern int CMO_SecPSP;
diff -puN arch/powerpc/platforms/pseries/setup.c~powerpc_coalesce arch/powerpc/platforms/pseries/setup.c
--- linux-2.6/arch/powerpc/platforms/pseries/setup.c~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/setup.c	2011-03-14 15:45:12.000000000 -0500
@@ -392,6 +392,16 @@ static int pseries_set_xdabr(unsigned lo
 #define CMO_CHARACTERISTICS_TOKEN 44
 #define CMO_MAXLENGTH 1026
 
+void pSeries_coalesce_init(void)
+{
+	struct hvcall_mpp_x_data mpp_x_data;
+
+	if (firmware_has_feature(FW_FEATURE_CMO) && !h_get_mpp_x(&mpp_x_data))
+		powerpc_firmware_features |= FW_FEATURE_XCMO;
+	else
+		powerpc_firmware_features &= ~FW_FEATURE_XCMO;
+}
+
 /**
  * fw_cmo_feature_init - FW_FEATURE_CMO is not stored in ibm,hypertas-functions,
  * handle that here. (Stolen from parse_system_parameter_string)
@@ -461,6 +471,7 @@ void pSeries_cmo_feature_init(void)
 		pr_debug("CMO enabled, PrPSP=%d, SecPSP=%d\n", CMO_PrPSP,
 		         CMO_SecPSP);
 		powerpc_firmware_features |= FW_FEATURE_CMO;
+		pSeries_coalesce_init();
 	} else
 		pr_debug("CMO not enabled, PrPSP=%d, SecPSP=%d\n", CMO_PrPSP,
 		         CMO_SecPSP);
diff -puN arch/powerpc/kernel/prom_init.c~powerpc_coalesce arch/powerpc/kernel/prom_init.c
--- linux-2.6/arch/powerpc/kernel/prom_init.c~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/prom_init.c	2011-03-14 15:45:12.000000000 -0500
@@ -676,8 +676,10 @@ static void __init early_cmdline_parse(v
 #endif /* CONFIG_PCI_MSI */
 #ifdef CONFIG_PPC_SMLPAR
 #define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
+#define OV5_XCMO			0x40	/* Page Coalescing */
 #else
 #define OV5_CMO			0x00
+#define OV5_XCMO			0x00
 #endif
 #define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
 
@@ -732,7 +734,7 @@ static unsigned char ibm_architecture_ve
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
 	0,
-	OV5_CMO,
+	OV5_CMO | OV5_XCMO,
 	OV5_TYPE1_AFFINITY,
 	0,
 	0,
diff -puN arch/powerpc/kernel/lparcfg.c~powerpc_coalesce arch/powerpc/kernel/lparcfg.c
--- linux-2.6/arch/powerpc/kernel/lparcfg.c~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/lparcfg.c	2011-03-14 15:45:12.000000000 -0500
@@ -161,6 +161,21 @@ int h_get_mpp(struct hvcall_mpp_data *mp
 }
 EXPORT_SYMBOL(h_get_mpp);
 
+int h_get_mpp_x(struct hvcall_mpp_x_data *mpp_x_data)
+{
+	int rc;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
+
+	rc = plpar_hcall9(H_GET_MPP_X, retbuf);
+
+	mpp_x_data->coalesced_bytes = retbuf[0];
+	mpp_x_data->pool_coalesced_bytes = retbuf[1];
+	mpp_x_data->pool_purr_cycles = retbuf[2];
+	mpp_x_data->pool_spurr_cycles = retbuf[3];
+
+	return rc;
+}
+
 struct hvcall_ppp_data {
 	u64	entitlement;
 	u64	unallocated_entitlement;
@@ -345,6 +360,30 @@ static void parse_mpp_data(struct seq_fi
 	seq_printf(m, "backing_memory=%ld bytes\n", mpp_data.backing_mem);
 }
 
+/**
+ * parse_mpp_x_data
+ * Parse out data returned from h_get_mpp_x
+ */
+static void parse_mpp_x_data(struct seq_file *m)
+{
+	struct hvcall_mpp_x_data mpp_x_data;
+
+	if (!firmware_has_feature(FW_FEATURE_XCMO))
+		return;
+	if (h_get_mpp_x(&mpp_x_data))
+		return;
+
+	seq_printf(m, "coalesced_bytes=%ld\n", mpp_x_data.coalesced_bytes);
+
+	if (mpp_x_data.pool_coalesced_bytes)
+		seq_printf(m, "pool_coalesced_bytes=%ld\n",
+			   mpp_x_data.pool_coalesced_bytes);
+	if (mpp_x_data.pool_purr_cycles)
+		seq_printf(m, "coalesce_pool_purr=%ld\n", mpp_x_data.pool_purr_cycles);
+	if (mpp_x_data.pool_spurr_cycles)
+		seq_printf(m, "coalesce_pool_spurr=%ld\n", mpp_x_data.pool_spurr_cycles);
+}
+
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
 #define SPLPAR_MAXLENGTH 1026*(sizeof(char))
 
@@ -520,6 +559,7 @@ static int pseries_lparcfg_data(struct s
 		parse_system_parameter_string(m);
 		parse_ppp_data(m);
 		parse_mpp_data(m);
+		parse_mpp_x_data(m);
 		pseries_cmo_data(m);
 		splpar_dispatch_data(m);
 
diff -puN arch/powerpc/include/asm/firmware.h~powerpc_coalesce arch/powerpc/include/asm/firmware.h
--- linux-2.6/arch/powerpc/include/asm/firmware.h~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/include/asm/firmware.h	2011-03-14 15:45:12.000000000 -0500
@@ -47,6 +47,7 @@
 #define FW_FEATURE_BEAT		ASM_CONST(0x0000000001000000)
 #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
 #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
+#define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
 
 #ifndef __ASSEMBLY__
 
@@ -60,7 +61,7 @@ enum {
 		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
 		FW_FEATURE_BULK_REMOVE | FW_FEATURE_XDABR |
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
-		FW_FEATURE_CMO | FW_FEATURE_VPHN,
+		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
diff -puN arch/powerpc/platforms/pseries/lpar.c~powerpc_coalesce arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6/arch/powerpc/platforms/pseries/lpar.c~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/lpar.c	2011-03-14 15:45:12.000000000 -0500
@@ -329,6 +329,8 @@ static long pSeries_lpar_hpte_insert(uns
 	/* Make pHyp happy */
 	if ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU))
 		hpte_r &= ~_PAGE_COHERENT;
+	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
+		flags |= H_COALESCE_CAND;
 
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);
 	if (unlikely(lpar_rc == H_PTEG_FULL)) {
diff -puN arch/powerpc/include/asm/pSeries_reconfig.h~powerpc_coalesce arch/powerpc/include/asm/pSeries_reconfig.h
--- linux-2.6/arch/powerpc/include/asm/pSeries_reconfig.h~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/include/asm/pSeries_reconfig.h	2011-03-14 15:45:12.000000000 -0500
@@ -14,6 +14,12 @@
 #define PSERIES_DRCONF_MEM_ADD		0x0003
 #define PSERIES_DRCONF_MEM_REMOVE	0x0004
 
+#ifdef CONFIG_PPC_SMLPAR
+extern void pSeries_coalesce_init(void);
+#else
+static inline void pSeries_coalesce_init(void) { }
+#endif
+
 #ifdef CONFIG_PPC_PSERIES
 extern int pSeries_reconfig_notifier_register(struct notifier_block *);
 extern void pSeries_reconfig_notifier_unregister(struct notifier_block *);
diff -puN arch/powerpc/kernel/rtas.c~powerpc_coalesce arch/powerpc/kernel/rtas.c
--- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_coalesce	2011-03-14 15:45:12.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2011-03-14 15:45:12.000000000 -0500
@@ -42,6 +42,7 @@
 #include <asm/time.h>
 #include <asm/mmu.h>
 #include <asm/topology.h>
+#include <asm/pSeries_reconfig.h>
 
 struct rtas_t rtas = {
 	.lock = __ARCH_SPIN_LOCK_UNLOCKED
@@ -731,6 +732,7 @@ static int __rtas_suspend_last_cpu(struc
 
 	atomic_set(&data->error, rc);
 	start_topology_update();
+	pSeries_coalesce_init();
 
 	if (wake_when_done) {
 		atomic_set(&data->done, 1);
_
