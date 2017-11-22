Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhhZw3LmHzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 23:28:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/64s: Fix Power9 DD2.1 logic in DT CPU features
Date: Wed, 22 Nov 2017 23:28:52 +1100
Message-Id: <20171122122852.20078-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I got the logic wrong in the DT CPU features code when I added the
Power9 DD2.1 feature. We should be setting the bit if we detect a
DD2.1, not clearing it if we detect a DD2.0.

This code isn't actually exercised at the moment so nothing is
actually broken.

Fixes: 3ffa9d9e2a7c ("powerpc/64s: Fix Power9 DD2.0 workarounds by adding DD2.1 feature")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 602e0fde19b4..8bdc2f96c5d6 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -735,8 +735,8 @@ static __init void cpufeatures_cpu_quirks(void)
 	 */
 	if ((version & 0xffffff00) == 0x004e0100)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
-	else if ((version & 0xffffefff) == 0x004e0200)
-		cur_cpu_spec->cpu_features &= ~CPU_FTR_POWER9_DD2_1;
+	else if ((version & 0xffffefff) == 0x004e0201)
+		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
 }
 
 static void __init cpufeatures_setup_finished(void)
-- 
2.14.3
