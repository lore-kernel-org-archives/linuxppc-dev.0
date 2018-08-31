Return-Path: <kernelfans@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421rcy2CbxzF38W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 17:30:57 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id p12-v6so5128845pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 00:30:57 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH 1/2] powerpc/prom: move mmu_early_init_devtree() before
 early_init_dt_scan_cpus()
Date: Fri, 31 Aug 2018 15:30:22 +0800
Message-Id: <1535700623-23750-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1535700623-23750-1-git-send-email-kernelfans@gmail.com>
References: <1535700623-23750-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In early_init_dt_scan_cpus() -> allocate_paca(), using ppc64_bolted_size()
to get the limitation. Although MMU_SEGSIZE_256M is enough for boot cpu's
paca, but in fact the bolted segment size may be MMU_SEGSIZE_1T. Hence
moving mmu_early_init_devtree() a little earlier, and let any callers of
ppc64_bolted_size() get the right value.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/prom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index c4d7078..cae4a78 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -760,6 +760,7 @@ void __init early_init_devtree(void *params)
 	DBG("Scanning CPUs ...\n");
 
 	dt_cpu_ftrs_scan();
+	mmu_early_init_devtree();
 
 	/* Retrieve CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
@@ -777,8 +778,6 @@ void __init early_init_devtree(void *params)
 	spinning_secondaries = boot_cpu_count - 1;
 #endif
 
-	mmu_early_init_devtree();
-
 #ifdef CONFIG_PPC_POWERNV
 	/* Scan and build the list of machine check recoverable ranges */
 	of_scan_flat_dt(early_init_dt_scan_recoverable_ranges, NULL);
-- 
2.7.4
