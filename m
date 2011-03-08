Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D86BB6F06
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286WWC7019351
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:32:32 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bcQR2343020
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcNu021083
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/18] powerpc/smp: soft-replugged CPUs must go back to
	start_secondary
Date: Tue,  8 Mar 2011 17:37:14 +1100
Message-Id: <1299566250-10516-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Various thing are torn down when a CPU is hot-unplugged. That CPU
is expected to go back to start_secondary when re-plugged to re
initialize everything, such as clock sources, maps, ...

Some implementations just return from cpu_die() callback
in the idle loop when the CPU is "re-plugged". This is not enough.

We fix it using a little asm trampoline which resets the stack
and calls back into start_secondary as if we were all fresh from
boot. The trampoline already existed on ppc64, but we add it for
ppc32

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/smp.h                  |    1 +
 arch/powerpc/kernel/head_32.S                   |    9 +++++++++
 arch/powerpc/kernel/smp.c                       |    9 +++++++--
 arch/powerpc/platforms/pseries/offline_states.h |    2 --
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 66e237b..1de0e97 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -36,6 +36,7 @@ extern void cpu_die(void);
 
 extern void smp_send_debugger_break(int cpu);
 extern void smp_message_recv(int);
+extern void start_secondary_resume(void);
 
 DECLARE_PER_CPU(unsigned int, cpu_pvr);
 
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 98c4b29..c5c24be 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -890,6 +890,15 @@ __secondary_start:
 	mtspr	SPRN_SRR1,r4
 	SYNC
 	RFI
+
+_GLOBAL(start_secondary_resume)
+	/* Reset stack */
+	rlwinm	r1,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
+	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
+	li	r3,0
+	std	r3,0(r1)		/* Zero the stack frame pointer	*/
+	bl	start_secondary
+	b	.
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9813605..1c9956c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -502,7 +502,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
 }
 
 /* Activate a secondary processor. */
-int __devinit start_secondary(void *unused)
+void __devinit start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
 	struct device_node *l2_cache;
@@ -558,7 +558,8 @@ int __devinit start_secondary(void *unused)
 	local_irq_enable();
 
 	cpu_idle();
-	return 0;
+
+	BUG();
 }
 
 int setup_profiling_timer(unsigned int multiplier)
@@ -660,5 +661,9 @@ void cpu_die(void)
 {
 	if (ppc_md.cpu_die)
 		ppc_md.cpu_die();
+
+	/* If we return, we re-enter start_secondary */
+	start_secondary_resume();
 }
+
 #endif
diff --git a/arch/powerpc/platforms/pseries/offline_states.h b/arch/powerpc/platforms/pseries/offline_states.h
index 75a6f48..08672d9 100644
--- a/arch/powerpc/platforms/pseries/offline_states.h
+++ b/arch/powerpc/platforms/pseries/offline_states.h
@@ -34,6 +34,4 @@ static inline void set_default_offline_state(int cpu)
 #endif
 
 extern enum cpu_state_vals get_preferred_offline_state(int cpu);
-extern int start_secondary(void);
-extern void start_secondary_resume(void);
 #endif
-- 
1.7.1
