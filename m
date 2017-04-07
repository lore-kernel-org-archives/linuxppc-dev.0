Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w002C6SFGzDqJx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 22:56:19 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 81so15433438pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 05:56:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc/pseries: do not use msgsndp doorbells on POWER9
 guests
Date: Fri,  7 Apr 2017 22:55:58 +1000
Message-Id: <20170407125602.31146-2-npiggin@gmail.com>
In-Reply-To: <20170407125602.31146-1-npiggin@gmail.com>
References: <20170407125602.31146-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 hypervisors will not necessarily run guest threads together on
the same core at the same time, so msgsndp should not be used.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/pseries/smp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index f6f83aeccaaa..1fa08155206b 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -200,7 +200,12 @@ static __init void pSeries_smp_probe(void)
 {
 	xics_smp_probe();
 
-	if (cpu_has_feature(CPU_FTR_DBELL)) {
+	/*
+	 * POWER9 can not use msgsndp doorbells for IPI because thread
+	 * siblings do not necessarily run on physical cores at the same
+	 * time. This could be enabled for pHyp.
+	 */
+	if (cpu_has_feature(CPU_FTR_DBELL) && !cpu_has_feature(CPU_FTR_ARCH_300)) {
 		xics_cause_ipi = smp_ops->cause_ipi;
 		smp_ops->cause_ipi = pSeries_cause_ipi_mux;
 	}
-- 
2.11.0
