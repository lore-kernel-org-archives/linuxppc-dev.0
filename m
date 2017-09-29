Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HB56K2ZzDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:30:05 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y192so117686pgd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:30:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/6] powerpc/watchdog: do not backtrace locked CPUs twice
 if allcpus backtrace is enabled
Date: Fri, 29 Sep 2017 13:29:38 +1000
Message-Id: <20170929032942.4321-3-npiggin@gmail.com>
In-Reply-To: <20170929032942.4321-1-npiggin@gmail.com>
References: <20170929032942.4321-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If sysctl_hardlockup_all_cpu_backtrace is enabled, there is no need to
IPI stuck CPUs for backtrace before trigger_allbutself_cpu_backtrace(),
which does the same thing again.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 532a1adbe89b..920e61c79f47 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -133,15 +133,18 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 	pr_emerg("Watchdog CPU:%d detected Hard LOCKUP other CPUS:%*pbl\n",
 			cpu, cpumask_pr_args(&wd_smp_cpus_pending));
 
-	/*
-	 * Try to trigger the stuck CPUs.
-	 */
-	for_each_cpu(c, &wd_smp_cpus_pending) {
-		if (c == cpu)
-			continue;
-		smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
+	if (!sysctl_hardlockup_all_cpu_backtrace) {
+		/*
+		 * Try to trigger the stuck CPUs, unless we are going to
+		 * get a backtrace on all of them anyway.
+		 */
+		for_each_cpu(c, &wd_smp_cpus_pending) {
+			if (c == cpu)
+				continue;
+			smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
+		}
+		smp_flush_nmi_ipi(1000000);
 	}
-	smp_flush_nmi_ipi(1000000);
 
 	/* Take the stuck CPUs out of the watch group */
 	set_cpumask_stuck(&wd_smp_cpus_pending, tb);
-- 
2.13.3
