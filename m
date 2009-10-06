Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30B80B7C73
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 02:35:07 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id n96FYsws027034
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2009 21:04:54 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n96FYrqM2678994
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2009 21:04:53 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n96FYqlq015220
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2009 21:04:53 +0530
Date: Tue, 6 Oct 2009 21:04:40 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v7 PATCH 6/7]: POWER: add a default_idle idle loop for POWER.
Message-ID: <20091006153440.GC7343@linux.vnet.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20091006152421.GA7278@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-06 20:54:21]:

In arch/powerpc/kernel/idle.c create a default_idle() routine by moving
the failover condition of the cpu_idle() idle loop. This is needed by
cpuidle infrastructure to call default_idle when other idle routines
are not yet registered. Functionality remains the same, but the code is
slightly moved around.


Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig              |    3 +++
 arch/powerpc/include/asm/system.h |    1 +
 arch/powerpc/kernel/idle.c        |    6 ++++++
 3 files changed, 10 insertions(+)

Index: linux.trees.git/arch/powerpc/Kconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/Kconfig
+++ linux.trees.git/arch/powerpc/Kconfig
@@ -91,6 +91,9 @@ config ARCH_HAS_ILOG2_U64
 config ARCH_HAS_CPU_IDLE_WAIT
 	def_bool y
 
+config ARCH_HAS_DEFAULT_IDLE
+	def_bool y
+
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux.trees.git/arch/powerpc/include/asm/system.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/system.h
+++ linux.trees.git/arch/powerpc/include/asm/system.h
@@ -218,6 +218,7 @@ extern unsigned long klimit;
 extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
+extern void default_idle(void);
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 /*
Index: linux.trees.git/arch/powerpc/kernel/idle.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/idle.c
+++ linux.trees.git/arch/powerpc/kernel/idle.c
@@ -113,6 +113,12 @@ void cpu_idle_wait(void)
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
+void default_idle(void)
+{
+	HMT_low();
+	HMT_very_low();
+}
+
 int powersave_nap;
 
 #ifdef CONFIG_SYSCTL
