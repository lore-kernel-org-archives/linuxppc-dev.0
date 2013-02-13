Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Apply early paca fixups to boot_paca and the boot
 cpu's paca
Date: Wed, 13 Feb 2013 11:44:50 +1100
Message-Id: <1360716290-15985-1-git-send-email-michael@ellerman.id.au>
Cc: phileas-fogg@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 466921c we added a hack to set the paca data_offset to zero so
that per-cpu accesses would work on the boot cpu prior to per-cpu areas
being setup. This fixed a problem with lockdep touching per-cpu areas
very early in boot.

However if we combine CONFIG_LOCK_STAT=y with any of the PPC_EARLY_DEBUG
options, we can hit the same problem in udbg_early_init(). To avoid that
we need to set the data_offset of the boot_paca also. So factor out the
fixup logic and call it for both the boot_paca, and "the paca of the
boot cpu".

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6da881b..8d97eb4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -156,6 +156,15 @@ early_param("smt-enabled", early_smt_enabled);
 #define check_smt_enabled()
 #endif /* CONFIG_SMP */
 
+/** Fix up paca fields required for the boot cpu */
+static void fixup_boot_paca(void)
+{
+	/* The boot cpu is started */
+	get_paca()->cpu_start = 1;
+	/* Allow percpu accesses to work until we setup percpu data */
+	get_paca()->data_offset = 0;
+}
+
 /*
  * Early initialization entry point. This is called by head.S
  * with MMU translation disabled. We rely on the "feature" of
@@ -185,6 +194,7 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
 	initialise_paca(&boot_paca, 0);
 	setup_paca(&boot_paca);
+	fixup_boot_paca();
 
 	/* Initialize lockdep early or else spinlocks will blow */
 	lockdep_init();
@@ -205,11 +215,7 @@ void __init early_setup(unsigned long dt_ptr)
 
 	/* Now we know the logical id of our boot cpu, setup the paca. */
 	setup_paca(&paca[boot_cpuid]);
-
-	/* Fix up paca fields required for the boot cpu */
-	get_paca()->cpu_start = 1;
-	/* Allow percpu accesses to "work" until we setup percpu data */
-	get_paca()->data_offset = 0;
+	fixup_boot_paca();
 
 	/* Probe the machine type */
 	probe_machine();
-- 
1.7.10.4
