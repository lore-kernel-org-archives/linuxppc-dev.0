Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F873B8133
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Mar 2010 23:58:20 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o21Csek8021248
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:54:40 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o21CqmEN1646618
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:52:48 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o21CwJSv024171
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:58:19 +1100
Subject: [PATCH v2 2/3] powerpc: move checks in pseries_mach_cpu_die()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 01 Mar 2010 18:28:16 +0530
Message-ID: <20100301125816.26066.34262.stgit@drishya.in.ibm.com>
In-Reply-To: <20100301123519.26066.8639.stgit@drishya.in.ibm.com>
References: <20100301123519.26066.8639.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, Gautham R Shenoy <ego@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Rearrange condition checks for better code readability and
	prevention of possible race conditions when
	preferred_offline_state can potentially change during the
	execution of pseries_mach_cpu_die().  The patch will make
	pseries_mach_cpu_die() put cpu in one of the consistent states
	and not hit the run over BUG()

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   30 +++++++++++++-------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 9be7af4..39ecb40 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -140,25 +140,25 @@ static void pseries_mach_cpu_die(void)
 		if (!get_lppaca()->shared_proc)
 			get_lppaca()->donate_dedicated_cpu = 0;
 		get_lppaca()->idle = 0;
-	}
 
-	if (get_preferred_offline_state(cpu) == CPU_STATE_ONLINE) {
-		unregister_slb_shadow(hwcpu, __pa(get_slb_shadow()));
+		if (get_preferred_offline_state(cpu) == CPU_STATE_ONLINE) {
+			unregister_slb_shadow(hwcpu, __pa(get_slb_shadow()));
 
-		/*
-		 * Call to start_secondary_resume() will not return.
-		 * Kernel stack will be reset and start_secondary()
-		 * will be called to continue the online operation.
-		 */
-		start_secondary_resume();
+			/*
+			 * Call to start_secondary_resume() will not return.
+			 * Kernel stack will be reset and start_secondary()
+			 * will be called to continue the online operation.
+			 */
+			start_secondary_resume();
+		}
+	}
 
-	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
+	/* Requested state is CPU_STATE_OFFLINE at this point */
+	WARN_ON(get_preferred_offline_state(cpu) != CPU_STATE_OFFLINE);
 
-		set_cpu_current_state(cpu, CPU_STATE_OFFLINE);
-		unregister_slb_shadow(hard_smp_processor_id(),
-					__pa(get_slb_shadow()));
-		rtas_stop_self();
-	}
+	set_cpu_current_state(cpu, CPU_STATE_OFFLINE);
+	unregister_slb_shadow(hwcpu, __pa(get_slb_shadow()));
+	rtas_stop_self();
 
 	/* Should never get here... */
 	BUG();
