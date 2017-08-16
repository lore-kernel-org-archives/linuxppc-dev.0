Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTPR2LNCzDrVy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:36:59 +1000 (AEST)
Received: by mail-wr0-x243.google.com with SMTP id n88so2841200wrb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 05:36:59 -0700 (PDT)
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] powerpc: powernv: Fix build error on const discarding
Date: Wed, 16 Aug 2017 14:34:44 +0200
Message-Id: <20170816123444.5202-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When building a random powerpc kernel I hit this build error:
  CC      arch/powerpc/platforms/powernv/opal-imc.o
arch/powerpc/platforms/powernv/opal-imc.c: In function « disable_nest_pmu_counters »:
arch/powerpc/platforms/powernv/opal-imc.c:130:13: error : assignment discards « const » qualifier from pointer target type [-Werror=discarded-qualifiers]
   l_cpumask = cpumask_of_node(nid);
             ^
This patch simply add const to l_cpumask to fix this issue.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-imc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index b903bf5e6006..21f6531fae20 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -123,7 +123,7 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 static void disable_nest_pmu_counters(void)
 {
 	int nid, cpu;
-	struct cpumask *l_cpumask;
+	const struct cpumask *l_cpumask;
 
 	get_online_cpus();
 	for_each_online_node(nid) {
-- 
2.13.0
