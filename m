Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E60C7B833F
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Mar 2010 23:58:26 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o21CtLrD018590
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:55:21 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o21CwQGi1749120
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:58:26 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o21CwQrs000725
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 23:58:26 +1100
Subject: [PATCH v2 3/3] powerpc: reduce printk from pseries_mach_cpu_die()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 01 Mar 2010 18:28:23 +0530
Message-ID: <20100301125823.26066.12047.stgit@drishya.in.ibm.com>
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

	Remove debug printks in pseries_mach_cpu_die().  These are
	noisy at runtime.  Traceevents can be added to instrument this
	section of code.

	The following KERN_INFO printks are removed:

	cpu 62 (hwid 62) returned from cede.
	Decrementer value = b2802fff Timebase value = 2fa8f95035f4a
	cpu 62 (hwid 62) got prodded to go online
	cpu 58 (hwid 58) ceding for offline with hint 2

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 39ecb40..b842378 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -122,21 +122,10 @@ static void pseries_mach_cpu_die(void)
 		if (!get_lppaca()->shared_proc)
 			get_lppaca()->donate_dedicated_cpu = 1;
 
-		printk(KERN_INFO
-			"cpu %u (hwid %u) ceding for offline with hint %d\n",
-			cpu, hwcpu, cede_latency_hint);
 		while (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
 			extended_cede_processor(cede_latency_hint);
-			printk(KERN_INFO "cpu %u (hwid %u) returned from cede.\n",
-				cpu, hwcpu);
-			printk(KERN_INFO
-			"Decrementer value = %x Timebase value = %llx\n",
-			get_dec(), get_tb());
 		}
 
-		printk(KERN_INFO "cpu %u (hwid %u) got prodded to go online\n",
-			cpu, hwcpu);
-
 		if (!get_lppaca()->shared_proc)
 			get_lppaca()->donate_dedicated_cpu = 0;
 		get_lppaca()->idle = 0;
