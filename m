Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w002P6PnBzDqK8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 22:56:29 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 81so15434442pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 05:56:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/5] powerpc/64s: avoid branch for ppc_msgsnd
Date: Fri,  7 Apr 2017 22:56:01 +1000
Message-Id: <20170407125602.31146-5-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/dbell.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 4db4cfdd829c..8ad66ccb7180 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -38,10 +38,8 @@ enum ppc_dbell {
 
 static inline void _ppc_msgsnd(u32 msg)
 {
-	if (cpu_has_feature(CPU_FTR_HVMODE))
-		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
-	else
-		__asm__ __volatile__ (PPC_MSGSNDP(%0) : : "r" (msg));
+	__asm__ __volatile__ (ASM_FTR_IFSET(PPC_MSGSND(%1), PPC_MSGSNDP(%1), %0)
+				: : "i" (CPU_FTR_HVMODE), "r" (msg));
 }
 
 /* sync before sending message */
-- 
2.11.0
