Return-Path: <dborkman@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id CE86F2C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2013 02:07:12 +1100 (EST)
From: Daniel Borkmann <dborkman@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix ics_rtas_init and start_secondary section
 mismatch
Date: Tue,  5 Feb 2013 16:07:06 +0100
Message-Id: <1360076826-25435-1-git-send-email-dborkman@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems, we're fine with just annotating the two functions.
Thus, this fixes the following build warnings on ppc64:

WARNING: arch/powerpc/sysdev/xics/built-in.o(.text+0x1664):
The function .ics_rtas_init() references
the function __init .xics_register_ics().
This is often because .ics_rtas_init lacks a __init
annotation or the annotation of .xics_register_ics is wrong.

WARNING: arch/powerpc/sysdev/built-in.o(.text+0x6044):
The function .ics_rtas_init() references
the function __init .xics_register_ics().
This is often because .ics_rtas_init lacks a __init
annotation or the annotation of .xics_register_ics is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2db30):
The function .start_secondary() references
the function __cpuinit .vdso_getcpu_init().
This is often because .start_secondary lacks a __cpuinit
annotation or the annotation of .vdso_getcpu_init is wrong.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Daniel Borkmann <dborkman@redhat.com>
---
 Note: compile-tested only!

 arch/powerpc/kernel/smp.c           |    2 +-
 arch/powerpc/sysdev/xics/ics-rtas.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 793401e..76bd9da 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -610,7 +610,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
 }
 
 /* Activate a secondary processor. */
-void start_secondary(void *unused)
+__cpuinit void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
 	struct device_node *l2_cache;
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
index c782f85..936575d 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -213,7 +213,7 @@ static int ics_rtas_host_match(struct ics *ics, struct device_node *node)
 	return !of_device_is_compatible(node, "chrp,iic");
 }
 
-int ics_rtas_init(void)
+__init int ics_rtas_init(void)
 {
 	ibm_get_xive = rtas_token("ibm,get-xive");
 	ibm_set_xive = rtas_token("ibm,set-xive");
-- 
1.7.1
