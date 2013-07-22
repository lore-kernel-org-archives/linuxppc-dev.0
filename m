Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8B20B2C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 15:59:42 +1000 (EST)
Message-ID: <51ECCA10.7010709@asianux.com>
Date: Mon, 22 Jul 2013 13:58:40 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: "paulus@samba.org" <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 srivatsa.bhat@linux.vnet.ibm.com, Kumar Gala <galak@kernel.crashing.org>,
 chenhui.zhao@freescale.com, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] powerpc: kernel: remove useless code which related with
 'max_cpus'
Content-Type: text/plain; charset=windows-1252
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since not need 'max_cpus' after the related commit, the related code
are useless too, need be removed.

The related commit:

  c1aa687 powerpc: Clean up obsolete code relating to decrementer and timebase

The related warning:

  arch/powerpc/kernel/smp.c:323:43: warning: parameter ‘max_cpus’ set but not used [-Wunused-but-set-parameter]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/kernel/smp.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 38b0ba6..8c2bae4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -345,14 +345,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
-
-	if (smp_ops)
-		if (smp_ops->probe)
-			max_cpus = smp_ops->probe();
-		else
-			max_cpus = NR_CPUS;
-	else
-		max_cpus = 1;
 }
 
 void smp_prepare_boot_cpu(void)
-- 
1.7.7.6
