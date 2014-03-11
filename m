Return-Path: <ego@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B50A72C0097
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:36 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 21:31:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5B52B3578052
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2BBBVN711272282
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:11:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2BBVVh0019874
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:31 +1100
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 1/2] powerpc: powernv: Framework to show the correct clock
 in /proc/cpuinfo
Date: Tue, 11 Mar 2014 17:01:18 +0530
Message-Id: <1394537479-17231-2-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1394537479-17231-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1394537479-17231-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently, the code in setup-common.c for powerpc assumes that all
clock rates are same in a smp system. This value is cached in the
variable named ppc_proc_freq and is the value that is reported in
/proc/cpuinfo.

However on the PowerNV platform, the clock rate is same only across
the threads of the same core. Hence the value that is reported in
/proc/cpuinfo is incorrect on PowerNV platforms. We need a better way
to query and report the correct value of the processor clock in
/proc/cpuinfo.

The patch achieves this by creating a machdep_call named
get_proc_freq() which is expected to returns the frequency in Hz. The
code in show_cpuinfo() can invoke this method to display the correct
clock rate on platforms that have implemented this method. On the
other powerpc platforms it can use the value cached in ppc_proc_freq.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h |  2 ++
 arch/powerpc/kernel/setup-common.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index ad3025d..eb1c6d4 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -113,6 +113,8 @@ struct machdep_calls {
 	/* Optional, may be NULL. */
 	void		(*show_cpuinfo)(struct seq_file *m);
 	void		(*show_percpuinfo)(struct seq_file *m, int i);
+	/* Returns the current operating frequency of "cpu" in Hz */
+	unsigned long  	(*get_proc_freq)(unsigned int cpu);
 
 	void		(*init_IRQ)(void);
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bc76cc6..bdd3045 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -209,6 +209,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
 	unsigned int pvr;
+	unsigned long proc_freq;
 	unsigned short maj;
 	unsigned short min;
 
@@ -260,12 +261,19 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 #endif /* CONFIG_TAU */
 
 	/*
-	 * Assume here that all clock rates are the same in a
-	 * smp system.  -- Cort
+	 * Platforms that have variable clock rates, should implement
+	 * the method ppc_md.get_proc_freq() that reports the clock
+	 * rate of a given cpu. The rest can use ppc_proc_freq to
+	 * report the clock rate that is same across all cpus.
 	 */
-	if (ppc_proc_freq)
+	if (ppc_md.get_proc_freq)
+		proc_freq = ppc_md.get_proc_freq(cpu_id);
+	else
+		proc_freq = ppc_proc_freq;
+
+	if (proc_freq)
 		seq_printf(m, "clock\t\t: %lu.%06luMHz\n",
-			   ppc_proc_freq / 1000000, ppc_proc_freq % 1000000);
+			   proc_freq / 1000000, proc_freq % 1000000);
 
 	if (ppc_md.show_percpuinfo != NULL)
 		ppc_md.show_percpuinfo(m, cpu_id);
-- 
1.8.3.1
