Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 06B1814017B
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 20:35:57 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 11 Apr 2014 06:35:55 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1BE0D38C8027
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:35:52 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3BAZqOr9503166
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 10:35:52 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3BAZpQ2029178
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:35:51 -0400
Subject: [PATCH 1/3] ppc/powernv: Set the runlatch bits correctly for
 offline cpus
To: linuxppc-dev@ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 11 Apr 2014 16:01:48 +0530
Message-ID: <20140411103148.27683.20726.stgit@preeti.in.ibm.com>
In-Reply-To: <20140411103030.27683.2107.stgit@preeti.in.ibm.com>
References: <20140411103030.27683.2107.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Up until now we have been setting the runlatch bits for a busy CPU and
clearing it when a CPU enters idle state. The runlatch bit has thus
been consistent with the utilization of a CPU as long as the CPU is online.

However when a CPU is hotplugged out the runlatch bit is not cleared. It
needs to be cleared to indicate an unused CPU. Hence this patch has the
runlatch bit cleared for an offline CPU just before entering an idle state
and sets it immediately after it exits the idle state.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/powernv/smp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 908672b..bf5fcd4 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -30,6 +30,7 @@
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
 #include <asm/opal.h>
+#include <asm/runlatch.h>
 
 #include "powernv.h"
 
@@ -156,7 +157,9 @@ static void pnv_smp_cpu_kill_self(void)
 	 */
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
 	while (!generic_check_cpu_restart(cpu)) {
+		ppc64_runlatch_off();
 		power7_nap();
+		ppc64_runlatch_on();
 		if (!generic_check_cpu_restart(cpu)) {
 			DBG("CPU%d Unexpected exit while offline !\n", cpu);
 			/* We may be getting an IPI, so we re-enable
