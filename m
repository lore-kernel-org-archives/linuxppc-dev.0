Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB7ZM1XMYzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 18:11:22 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id z80so14949097pff.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 00:11:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [PATCH] powerpc/pseries/cpuidle: add polling idle for shared
 processor guests
Date: Tue, 10 Oct 2017 17:11:09 +1000
Message-Id: <20171010071109.31207-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For shared processor guests (e.g., KVM), add an idle polling mode rather
than immediately returning to the hypervisor when the guest CPU goes
idle.

Test setup is a 2 socket POWER9 with 4 guests running, each with vCPUs
equal to 1/2 of real of CPUs. Saturated each guest with tbench. Using
polling idle gives about 1.4x throughput.

Kernel compile speed was not changed significantly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index e9b3853d93ea..16be7ad30fe1 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -171,11 +171,17 @@ static struct cpuidle_state dedicated_states[] = {
  * States for shared partition case.
  */
 static struct cpuidle_state shared_states[] = {
+	{ /* Snooze */
+		.name = "snooze",
+		.desc = "snooze",
+		.exit_latency = 0,
+		.target_residency = 0,
+		.enter = &snooze_loop },
 	{ /* Shared Cede */
 		.name = "Shared Cede",
 		.desc = "Shared Cede",
-		.exit_latency = 0,
-		.target_residency = 0,
+		.exit_latency = 10,
+		.target_residency = 100,
 		.enter = &shared_cede_loop },
 };
 
-- 
2.13.3
