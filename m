Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKsH6GWhzDqpG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:50:59 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 07:50:58 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D228019D8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:38:41 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LDoouE35193034
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:50:50 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LDonMX004187
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:50 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 6/9] powerpc/powernv: set power_save func after the idle
 states are initialized
Date: Thu, 21 Apr 2016 19:19:56 +0530
Message-Id: <1461246599-6098-7-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
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

Signed-off-by: Shreyas B. Prabhy <shreyas@linux.vnet.ibm.com>
---
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
index 1acb0c7..c9685b6 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -312,7 +312,7 @@ define_machine(powernv) {
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
