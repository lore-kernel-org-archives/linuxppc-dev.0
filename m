Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 555C0B7EC2
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Mar 2010 23:58:13 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o21CwA9W004884
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:58:10 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o21CqfbQ1458250
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:52:41 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o21CwCIO023789
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:58:12 +1100
Subject: [PATCH v2 1/3] powerpc: reset kernel stack on cpu online from cede
	state
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 01 Mar 2010 18:28:09 +0530
Message-ID: <20100301125809.26066.71578.stgit@drishya.in.ibm.com>
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

	Cpu hotplug (offline) without dlpar operation will place cpu
	in cede state and the extended_cede_processor() function will
	return when resumed.

	Kernel stack pointer needs to be reset before
	start_secondary() is called to continue the online operation.

	Added new function start_secondary_resume() to do the above
	steps.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>
---
 arch/powerpc/kernel/head_64.S                   |   11 +++++++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |    9 ++++-----
 arch/powerpc/platforms/pseries/offline_states.h |    2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 9258074..567cd57 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -615,6 +615,17 @@ _GLOBAL(start_secondary_prolog)
 	std	r3,0(r1)		/* Zero the stack frame pointer	*/
 	bl	.start_secondary
 	b	.
+/*
+ * Reset stack pointer and call start_secondary
+ * to continue with online operation when woken up
+ * from cede in cpu offline.
+ */
+_GLOBAL(start_secondary_resume)
+	ld	r1,PACAKSAVE(r13)	/* Reload kernel stack pointer */
+	li	r3,0
+	std	r3,0(r1)		/* Zero the stack frame pointer	*/
+	bl	.start_secondary
+	b	.
 #endif
 
 /*
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6ea4698..9be7af4 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -146,12 +146,11 @@ static void pseries_mach_cpu_die(void)
 		unregister_slb_shadow(hwcpu, __pa(get_slb_shadow()));
 
 		/*
-		 * NOTE: Calling start_secondary() here for now to
-		 * start new context.
-		 * However, need to do it cleanly by resetting the
-		 * stack pointer.
+		 * Call to start_secondary_resume() will not return.
+		 * Kernel stack will be reset and start_secondary()
+		 * will be called to continue the online operation.
 		 */
-		start_secondary();
+		start_secondary_resume();
 
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
 
diff --git a/arch/powerpc/platforms/pseries/offline_states.h b/arch/powerpc/platforms/pseries/offline_states.h
index 22574e0..da07256 100644
--- a/arch/powerpc/platforms/pseries/offline_states.h
+++ b/arch/powerpc/platforms/pseries/offline_states.h
@@ -14,5 +14,5 @@ extern void set_cpu_current_state(int cpu, enum cpu_state_vals state);
 extern enum cpu_state_vals get_preferred_offline_state(int cpu);
 extern void set_preferred_offline_state(int cpu, enum cpu_state_vals state);
 extern void set_default_offline_state(int cpu);
-extern int start_secondary(void);
+extern void start_secondary_resume(void);
 #endif
