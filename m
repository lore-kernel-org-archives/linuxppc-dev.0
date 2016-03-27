Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqq3sjYzDqFd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:59 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:57 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CAF9C3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:54 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PsRR45744330
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:54 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8Ps8i029963
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:54 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 40/65] powerpc/mm/radix: Isolate hash table function from
 pseries guest code
Date: Sun, 27 Mar 2016 13:53:48 +0530
Message-Id: <1459067053-10835-40-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c    | 14 +++++++++++---
 arch/powerpc/platforms/pseries/lparcfg.c |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index e4ceba2b1551..7f6100d91b4b 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -89,18 +89,21 @@ void vpa_init(int cpu)
 		       "%lx failed with %ld\n", cpu, hwcpu, addr, ret);
 		return;
 	}
+
+#ifdef CONFIG_PPC_STD_MMU_64
 	/*
 	 * PAPR says this feature is SLB-Buffer but firmware never
 	 * reports that.  All SPLPAR support SLB shadow buffer.
 	 */
-	addr = __pa(paca[cpu].slb_shadow_ptr);
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+	if (!radix_enabled() && firmware_has_feature(FW_FEATURE_SPLPAR)) {
+		addr = __pa(paca[cpu].slb_shadow_ptr);
 		ret = register_slb_shadow(hwcpu, addr);
 		if (ret)
 			pr_err("WARNING: SLB shadow buffer registration for "
 			       "cpu %d (hw %d) of area %lx failed with %ld\n",
 			       cpu, hwcpu, addr, ret);
 	}
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	/*
 	 * Register dispatch trace log, if one has been allocated.
@@ -123,6 +126,8 @@ void vpa_init(int cpu)
 	}
 }
 
+#ifdef CONFIG_PPC_STD_MMU_64
+
 static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 				     unsigned long vpn, unsigned long pa,
 				     unsigned long rflags, unsigned long vflags,
@@ -655,6 +660,8 @@ static void pSeries_set_page_state(struct page *page, int order,
 
 void arch_free_page(struct page *page, int order)
 {
+	if (radix_enabled())
+		return;
 	if (!cmo_free_hint_flag || !firmware_has_feature(FW_FEATURE_CMO))
 		return;
 
@@ -662,7 +669,8 @@ void arch_free_page(struct page *page, int order)
 }
 EXPORT_SYMBOL(arch_free_page);
 
-#endif
+#endif /* CONFIG_PPC_SMLPAR */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 #ifdef CONFIG_TRACEPOINTS
 #ifdef HAVE_JUMP_LABEL
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index c9fecf09b8fa..afa05a2cb702 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -484,8 +484,9 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	seq_printf(m, "shared_processor_mode=%d\n",
 		   lppaca_shared_proc(get_lppaca()));
 
+#ifdef CONFIG_PPC_STD_MMU_64
 	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
-
+#endif
 	parse_em_data(m);
 
 	return 0;
-- 
2.5.0
