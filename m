Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL6HH6h7xzDqfp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:39:23 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 06:39:21 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v5 07/11] powerpc/powernv: set power_save func after the idle
 states are initialized
Date: Thu,  2 Jun 2016 07:38:57 -0500
Message-Id: <1464871141-11568-8-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_init_idle_states discovers supported idle states from the
device tree and does the required initialization. Set power_save
function pointer only after this initialization is done

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
- No changes since v1

 arch/powerpc/platforms/powernv/idle.c  | 3 +++
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index fcc8b68..fbb09fb 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -285,6 +285,9 @@ static int __init pnv_init_idle_states(void)
 	}
 
 	pnv_alloc_idle_core_states();
+
+	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
+		ppc_md.power_save = power7_idle;
 out_free:
 	kfree(flags);
 out:
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ee6430b..8492bbb 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -315,7 +315,7 @@ define_machine(powernv) {
 	.get_proc_freq          = pnv_get_proc_freq,
 	.progress		= pnv_progress,
 	.machine_shutdown	= pnv_shutdown,
-	.power_save             = power7_idle,
+	.power_save             = NULL,
 	.calibrate_decr		= generic_calibrate_decr,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
-- 
2.1.4
