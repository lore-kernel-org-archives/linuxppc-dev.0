Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNxWM1Jz2zDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:15:43 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u187so3918532pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:15:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/powernv: Fix CPU_HOTPLUG=n idle.c compile error
Date: Fri, 12 May 2017 01:15:20 +1000
Message-Id: <20170511151522.4772-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes: a7cd88da97 ("powerpc/powernv: Move CPU-Offline idle state invocation from smp.c to idle.c")
Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 445f30a2c5ef..0c21747ed7e0 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -261,6 +261,7 @@ static u64 pnv_deepest_stop_psscr_val;
 static u64 pnv_deepest_stop_psscr_mask;
 static bool deepest_stop_found;
 
+#ifdef CONFIG_HOTPLUG_CPU
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
@@ -293,6 +294,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 
 	return srr1;
 }
+#endif
 
 /*
  * Power ISA 3.0 idle initialization.
-- 
2.11.0
