Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtzc23x73zDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 20:19:46 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2U9J2rQ016410
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 05:19:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29gfn9r1px-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 05:19:32 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 03:19:31 -0600
Date: Thu, 30 Mar 2017 14:49:15 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/4] powernv:smp: Add busy-wait loop as fall back for
 CPU-Hotplug
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1490194710.git.ego@linux.vnet.ibm.com>
 <261607d15ec471d88a8d31ee50614c64a4018b90.1490194710.git.ego@linux.vnet.ibm.com>
 <87fuhzdjwv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fuhzdjwv.fsf@concordia.ellerman.id.au>
Message-Id: <20170330091915.GA12109@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 27, 2017 at 10:43:44PM +1100, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> > index 419edff..f335e0f 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -283,8 +283,16 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
> >  	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
> >  		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
> >  		srr1 = power7_sleep();
> > -	} else {
> > +	} else if (idle_states & OPAL_PM_NAP_ENABLED) {
> >  		srr1 = power7_nap(1);
> > +	} else {
> > +		/* This is the fallback method. We emulate snooze */
> > +		while (!generic_check_cpu_restart(cpu)) {
> 
> Breaks the SMP=n build :/

Hmmm.. Looks like I have missed adding a CONFIG_HOTPLUG_CPU somewhere.
> 
> arch/powerpc/platforms/powernv/idle.c:299:11: error: implicit declaration of function 'generic_check_cpu_restart' [-Werror=implicit-function-declaration]
>

Could you add the following patch as the PATCH 1 in the series instead
of what was present in this series ? It adds a CONFIG_HOTPLUG_CPU
around pnv_cpu_offline(). I have compiled it with both all
combinations of CONFIG_HOTPLUG_CPU and CONFIG_SMP and it builds fine.


----------------------------x-----x-----x-------------------------------
powernv: Move CPU-Offline idle state invocation from smp.c to idle.c

Move the piece of code in powernv/smp.c::pnv_smp_cpu_kill_self() which
transitions the CPU to the deepest available platform idle state to a
new function named pnv_cpu_offline() in powernv/idle.c. The rationale
behind this code movement is that the data required to determine the
deepest available platform state resides in powernv/idle.c.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
Restricts pnv_cpu_offline() to CONFIG_HOTPLUG_CPU

 arch/powerpc/include/asm/cpuidle.h       |  1 +
 arch/powerpc/platforms/powernv/idle.c    | 27 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/powernv.h |  2 --
 arch/powerpc/platforms/powernv/smp.c     | 18 ++----------------
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 1557315..4649ca0 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -46,6 +46,7 @@
 
 extern u64 pnv_first_deep_stop_state;
 
+unsigned long pnv_cpu_offline(unsigned int cpu);
 int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
 static inline void report_invalid_psscr_val(u64 psscr_val, int err)
 {
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 4ee837e..fafafa3 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -265,6 +265,33 @@ static void power9_idle(void)
 u64 pnv_deepest_stop_psscr_val;
 u64 pnv_deepest_stop_psscr_mask;
 
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * pnv_cpu_offline: A function that puts the CPU into the deepest
+ * available platform idle state on a CPU-Offline.
+ */
+unsigned long pnv_cpu_offline(unsigned int cpu)
+{
+	unsigned long srr1;
+
+	u32 idle_states = pnv_get_supported_cpuidle_states();
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
+					pnv_deepest_stop_psscr_mask);
+	} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
+		srr1 = power7_winkle();
+	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
+		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
+		srr1 = power7_sleep();
+	} else {
+		srr1 = power7_nap(1);
+	}
+
+	return srr1;
+}
+#endif
+
 /*
  * Power ISA 3.0 idle initialization.
  *
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 6130522..6dbc0a1 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -18,8 +18,6 @@ static inline void pnv_pci_shutdown(void) { }
 #endif
 
 extern u32 pnv_get_supported_cpuidle_states(void);
-extern u64 pnv_deepest_stop_psscr_val;
-extern u64 pnv_deepest_stop_psscr_mask;
 
 extern void pnv_lpc_init(void);
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 8b67e1e..914b456 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -35,6 +35,7 @@
 #include <asm/dbell.h>
 #include <asm/kvm_ppc.h>
 #include <asm/ppc-opcode.h>
+#include <asm/cpuidle.h>
 
 #include "powernv.h"
 
@@ -140,7 +141,6 @@ static void pnv_smp_cpu_kill_self(void)
 {
 	unsigned int cpu;
 	unsigned long srr1, wmask;
-	u32 idle_states;
 
 	/* Standard hot unplug procedure */
 	local_irq_disable();
@@ -155,8 +155,6 @@ static void pnv_smp_cpu_kill_self(void)
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		wmask = SRR1_WAKEMASK_P8;
 
-	idle_states = pnv_get_supported_cpuidle_states();
-
 	/* We don't want to take decrementer interrupts while we are offline,
 	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
 	 * enabled as to let IPIs in.
@@ -184,19 +182,7 @@ static void pnv_smp_cpu_kill_self(void)
 		kvmppc_set_host_ipi(cpu, 0);
 
 		ppc64_runlatch_off();
-
-		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-			srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
-						pnv_deepest_stop_psscr_mask);
-		} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
-			srr1 = power7_winkle();
-		} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
-			   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
-			srr1 = power7_sleep();
-		} else {
-			srr1 = power7_nap(1);
-		}
-
+		srr1 = pnv_cpu_offline(cpu);
 		ppc64_runlatch_on();
 
 		/*
-- 
1.9.4
