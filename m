Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com
 [IPv6:2607:f8b0:400e:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMFK80VCczDrMP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 22:01:16 +1000 (AEST)
Received: by mail-pg0-x22e.google.com with SMTP id l64so6997675pge.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 05:01:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 1/4] powerpc/64s: fix mce accounting for powernv
Date: Tue,  1 Aug 2017 22:00:51 +1000
Message-Id: <20170801120054.3447-2-npiggin@gmail.com>
In-Reply-To: <20170801120054.3447-1-npiggin@gmail.com>
References: <20170801120054.3447-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bfcfd9ef09f2..5adfea2dc822 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -755,7 +755,14 @@ void machine_check_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 	int recover = 0;
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* 64s accounts the mce in machine_check_early when in HVMODE */
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		__this_cpu_inc(irq_stat.mce_exceptions);
+#else
 	__this_cpu_inc(irq_stat.mce_exceptions);
+#endif
+
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-- 
2.11.0
