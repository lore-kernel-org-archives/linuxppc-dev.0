Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPbt3XhnzF20w
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:51:06 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id s24-v6so2334441plq.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:51:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH 2/2] powerpc: Fix DABR write in the case of DAWR disabled
Date: Sun,  1 Apr 2018 15:50:36 +1000
Message-Id: <20180401055036.18078-3-npiggin@gmail.com>
In-Reply-To: <20180401055036.18078-1-npiggin@gmail.com>
References: <20180401055036.18078-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

flush_thread will call set_breakpoint via set_debug_reg_defaults,
and cause POWER8 and above CPUs without the DAWR feature to try
to write to DAWR.

Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/process.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 24a591b4dbe9..bfcf5437083c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -718,7 +718,8 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
 {
 	thread->hw_brk.address = 0;
 	thread->hw_brk.type = 0;
-	set_breakpoint(&thread->hw_brk);
+	if (ppc_breakpoint_available())
+		set_breakpoint(&thread->hw_brk);
 }
 #endif /* !CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
@@ -814,10 +815,14 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 {
 	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
 
-	if (cpu_has_feature(CPU_FTR_DAWR))
-		set_dawr(brk);
-	else
+	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		if (cpu_has_feature(CPU_FTR_DAWR))
+			set_dawr(brk);
+		else
+			WARN_ON_ONCE(1);
+	} else {
 		set_dabr(brk);
+	}
 }
 
 void set_breakpoint(struct arch_hw_breakpoint *brk)
-- 
2.16.3
