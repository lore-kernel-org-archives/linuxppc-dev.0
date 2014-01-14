Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 390912C0360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:55:42 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 16:25:38 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 93BA7125805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:27:10 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EAtUER41418874
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:25:31 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EAtZRu019782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:25:35 +0530
Subject: [PATCH v1 1/6] pseries/cpuidle: Remove redundant call to
 ppc64_runlatch_off() in cpu idle routines
To: linux-pm@vger.kernel.org, benh@kernel.crashing.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 16:25:54 +0530
Message-ID: <20140114105547.3064.55112.stgit@deepthi.in.ibm.com>
In-Reply-To: <20140114105525.3064.52013.stgit@deepthi.in.ibm.com>
References: <20140114105525.3064.52013.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Commit fbd7740fdfdf9475f(powerpc: Simplify pSeries idle loop) switched pseries
cpu idle handling from complete idle loops to ppc_md.powersave functions.
Earlier to this switch, ppc64_runlatch_off() had to be called in each of the
idle routines. But after the switch, this call is handled in arch_cpu_idle(),
just before the call to ppc_md.powersave, where platform specific idle
routines are called.

As a consequence, the call to ppc64_runlatch_off() got duplicated in the
arch_cpu_idle() routine as well as in the some of the idle routines in
pseries and commit fbd7740fdfdf9475f missed to get rid of these redundant
calls. These calls were carried over subsequent enhancements to the pseries
cpuidle routines.

Although multiple calls to ppc64_runlatch_off() is harmless, there is still some
overhead due to it. Besides that, these calls could also make way for a
misunderstanding that it is *necessary* to call ppc64_runlatch_off() multiple
times, when that is not the case. Hence this patch takes care of eliminating
this redundancy.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/processor_idle.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index a166e38..09e4f56 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -17,7 +17,6 @@
 #include <asm/reg.h>
 #include <asm/machdep.h>
 #include <asm/firmware.h>
-#include <asm/runlatch.h>
 #include <asm/plpar_wrappers.h>
 
 struct cpuidle_driver pseries_idle_driver = {
@@ -63,7 +62,6 @@ static int snooze_loop(struct cpuidle_device *dev,
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	while ((!need_resched()) && cpu_online(cpu)) {
-		ppc64_runlatch_off();
 		HMT_low();
 		HMT_very_low();
 	}
@@ -103,7 +101,6 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	idle_loop_prolog(&in_purr);
 	get_lppaca()->donate_dedicated_cpu = 1;
 
-	ppc64_runlatch_off();
 	HMT_medium();
 	check_and_cede_processor();
 
