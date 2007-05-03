Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A790CDE013
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 07:47:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l43Lli6H011435
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 17:47:44 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l43LliMa521248
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 17:47:44 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l43Llh6G000545
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 17:47:43 -0400
Subject: [PATCH 2/1] comment fixup for smp_call_function
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1178153638.5338.2.camel@concordia.ozlabs.ibm.com>
References: <20070502171234.13831.8483.stgit@farscape.rchland.ibm.com>
	<1178153638.5338.2.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 16:47:09 -0500
Message-Id: <1178228829.7871.112.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	Kevin Corry <kevcorry@us.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix up the comment blob for smp_call_function and friends.  Also just a
touch of whitespace cleanup.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

---

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4878588..1b82228 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -176,15 +176,13 @@ static struct call_data_struct {
 #define SMP_CALL_TIMEOUT	8
 
 /*
- * These functions send a 'generic call function' IPI to other online
- * CPUS in the system.
+ * smp_call_function(): Run a function on other CPUs.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @nonatomic: currently unused.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
  *
- * [SUMMARY] Run a function on other CPUs.
- * <func> The function to run. This must be fast and non-blocking.
- * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
- * <wait> If true, wait (atomically) until function has completed on other CPUs.
- * [RETURNS] 0 on success, else a negative status code. Does not return until
+ * Returns 0 on success, else a negative status code. Does not return until
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
@@ -361,7 +359,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	DBG("smp_prepare_cpus\n");
 
-	/* 
+	/*
 	 * setup_cpu may need to be called on the boot cpu. We havent
 	 * spun any cpus up but lets be paranoid.
 	 */
@@ -375,7 +373,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		max_cpus = smp_ops->probe();
 	else
 		max_cpus = 1;
- 
+
 	smp_space_timers(max_cpus);
 
 	for_each_possible_cpu(cpu)
@@ -585,7 +583,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	 */
 	old_mask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
-	
+
 	if (smp_ops)
 		smp_ops->setup_cpu(boot_cpuid);
 
