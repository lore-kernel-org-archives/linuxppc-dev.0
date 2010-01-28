Return-Path: <jschopp@austin.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9AFF5B7D15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 10:21:01 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SNJQ2l013387
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 16:19:26 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0SNKcda088422
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 16:20:39 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0SNKbeO031742
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 16:20:38 -0700
Subject: [PATCHv3 1/2] sched: enable ARCH_POWER
From: Joel Schopp <jschopp@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1264548486.12239.55.camel@jschopp-laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017764.5717.127.camel@jschopp-laptop>
	<1264548486.12239.55.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Jan 2010 17:20:33 -0600
Message-ID: <1264720833.9660.21.camel@jschopp-laptop>
Mime-Version: 1.0
Cc: ego@in.ibm.com, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the scheduler feature that allows use of arch_scale_smt_power.  Stub out
the broken x86 implementation.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---
Index: linux-2.6.git/kernel/sched_features.h
===================================================================
--- linux-2.6.git.orig/kernel/sched_features.h
+++ linux-2.6.git/kernel/sched_features.h
@@ -102,7 +102,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, 1)
 /*
  * Use arch dependent cpu power functions
  */
-SCHED_FEAT(ARCH_POWER, 0)
+SCHED_FEAT(ARCH_POWER, 1)
 
 SCHED_FEAT(HRTICK, 0)
 SCHED_FEAT(DOUBLE_TICK, 0)
Index: linux-2.6.git/arch/x86/kernel/cpu/sched.c
===================================================================
--- linux-2.6.git.orig/arch/x86/kernel/cpu/sched.c
+++ linux-2.6.git/arch/x86/kernel/cpu/sched.c
@@ -44,11 +44,9 @@ unsigned long arch_scale_freq_power(stru
 unsigned long arch_scale_smt_power(struct sched_domain *sd, int cpu)
 {
 	/*
-	 * aperf/mperf already includes the smt gain
+	 * aperf/mperf already includes the smt gain, but represents capacity
+	 * as 0 when idle.  So for now just return default.
 	 */
-	if (boot_cpu_has(X86_FEATURE_APERFMPERF))
-		return SCHED_LOAD_SCALE;
-
 	return default_scale_smt_power(sd, cpu);
 }
