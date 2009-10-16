Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC62CB7BCE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 20:48:42 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n9GKaAkn017050
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2009 07:36:10 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9G9k0rb839806
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2009 20:46:00 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9G9mdId008442
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2009 20:48:40 +1100
Date: Fri, 16 Oct 2009 15:18:33 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Andi Kleen <andi@firstfloor.org>, Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v9 PATCH 9/9]: POWER: Enable default_idle when power_save=off.
Message-ID: <20091016094833.GK27350@linux.vnet.ibm.com>
References: <20091016093850.GB27350@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20091016093850.GB27350@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-16 15:08:50]:

This patch enables default_idle when power_save=off kernel boot
option is specified.

Earlier, this was done by setting ppc_md.power_save = NULL and hence
HMT_low() and HMT_very_low() was called. Now this is defined under
default_idle() and hence by setting boot_option_idle_override = 1,
the cpuidle registration stuff does not happen and hence default_idle
is chosen in cpuidle_idle_call.

Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h            |    2 ++
 arch/powerpc/kernel/idle.c                      |    4 +++-
 arch/powerpc/platforms/pseries/processor_idle.c |    5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

Index: linux.trees.git/arch/powerpc/include/asm/processor.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/processor.h
+++ linux.trees.git/arch/powerpc/include/asm/processor.h
@@ -332,6 +332,8 @@ static inline unsigned long get_clean_sp
 }
 #endif
 
+extern int boot_option_idle_override;
+
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_PROCESSOR_H */
Index: linux.trees.git/arch/powerpc/kernel/idle.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/idle.c
+++ linux.trees.git/arch/powerpc/kernel/idle.c
@@ -40,9 +40,11 @@
 #define cpu_should_die()	0
 #endif
 
+int boot_option_idle_override = 0;
+
 static int __init powersave_off(char *arg)
 {
-	ppc_md.power_save = NULL;
+	boot_option_idle_override = 1;
 	return 0;
 }
 __setup("powersave=off", powersave_off);
Index: linux.trees.git/arch/powerpc/platforms/pseries/processor_idle.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/processor_idle.c
+++ linux.trees.git/arch/powerpc/platforms/pseries/processor_idle.c
@@ -185,6 +185,11 @@ static int __init pseries_processor_idle
 	int cpu;
 	int result;
 
+	if (boot_option_idle_override) {
+		printk(KERN_DEBUG "Using default idle\n");
+		return 0;
+	}
+
 	result = cpuidle_register_driver(&pseries_idle_driver);
 
 	if (result < 0)
