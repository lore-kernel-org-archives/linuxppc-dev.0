Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmChL0K7bzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:00:18 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id f127so12760638pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 17:00:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 03/14] powerpc/64s: idle provide a default idle for POWER9
Date: Mon, 12 Jun 2017 09:58:24 +1000
Message-Id: <20170611235835.7400-4-npiggin@gmail.com>
In-Reply-To: <20170611235835.7400-1-npiggin@gmail.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before the cpuidle driver is enabled, provide a default idle
function similarly to POWER7/8.

This should not have much effect, because the cpuidle driver
for powernv is mandatory, but if that changes we should have
a fallback.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index f188d84d9c59..e327e1585ddc 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -677,6 +677,8 @@ static int __init pnv_init_idle_states(void)
 
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
+	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
+		ppc_md.power_save = power9_idle;
 
 out:
 	return 0;
-- 
2.11.0
