Return-Path: <igor.stoppa@gmail.com>
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426M331hpgzF3TD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 01:35:43 +1000 (AEST)
Received: by mail-lj1-x241.google.com with SMTP id p6-v6so12644455ljc.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 08:35:42 -0700 (PDT)
From: Igor Stoppa <igor.stoppa@gmail.com>
To: Arseny Solokha <asolokha@kb.kras.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove unnecessary unlikely()
Date: Fri,  7 Sep 2018 18:35:26 +0300
Message-Id: <20180907153526.19616-1-igor.stoppa@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Arseny Solokha <asolokha@kb.kras.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/mm/tlb_nohash.c      | 2 +-
 arch/powerpc/sysdev/xive/common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 15fe5f0c8665..46f5d8c972fb 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -302,7 +302,7 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 	 * This function as well as __local_flush_tlb_page() must only be called
 	 * for user contexts.
 	 */
-	if (unlikely(WARN_ON(!mm)))
+	if (WARN_ON(!mm))
 		return;
 
 	preempt_disable();
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 959a2a62f233..7dde46b38979 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -442,7 +442,7 @@ static void xive_dec_target_count(int cpu)
 	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
 	struct xive_q *q = &xc->queue[xive_irq_priority];
 
-	if (unlikely(WARN_ON(cpu < 0 || !xc))) {
+	if (WARN_ON(cpu < 0 || !xc)) {
 		pr_err("%s: cpu=%d xc=%p\n", __func__, cpu, xc);
 		return;
 	}
-- 
2.17.1
