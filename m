Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46B0D679E7
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 15:04:06 +1000 (EST)
Date: Fri, 5 May 2006 00:00:28 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [UPDATED] Please pull from 'for_paulus' branch of powerpc
Message-ID: <Pine.LNX.4.44.0605042359560.10348-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/kernel/setup-common.c |   17 +++++++++++++++++
 arch/powerpc/kernel/setup.h        |    2 ++
 arch/powerpc/kernel/setup_32.c     |    5 +++--
 arch/powerpc/kernel/setup_64.c     |   18 +-----------------
 4 files changed, 23 insertions(+), 19 deletions(-)

Kumar Gala:
      powerpc: provide ppc_md.panic() for both ppc32 & ppc64

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 684ab1d..88de557 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -524,3 +524,20 @@ int check_legacy_ioport(unsigned long ba
 	return ppc_md.check_legacy_ioport(base_port);
 }
 EXPORT_SYMBOL(check_legacy_ioport);
+
+static int ppc_panic_event(struct notifier_block *this,
+                             unsigned long event, void *ptr)
+{
+	ppc_md.panic(ptr);  /* May not return */
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ppc_panic_block = {
+	.notifier_call = ppc_panic_event,
+	.priority = INT_MIN /* may not return; must be done last */
+};
+
+void __init setup_panic(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
+}
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 2ebba75..e67066c 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -2,5 +2,7 @@ #ifndef _POWERPC_KERNEL_SETUP_H
 #define _POWERPC_KERNEL_SETUP_H
 
 void check_for_initrd(void);
+void do_init_bootmem(void);
+void setup_panic(void);
 
 #endif /* _POWERPC_KERNEL_SETUP_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 69ac257..88832b3 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -235,8 +235,6 @@ arch_initcall(ppc_init);
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
-	extern void do_init_bootmem(void);
-
 	/* so udelay does something sensible, assume <= 1000 bogomips */
 	loops_per_jiffy = 500000000 / HZ;
 
@@ -285,6 +283,9 @@ #endif
 	/* reboot on panic */
 	panic_timeout = 180;
 
+	if (ppc_md.panic)
+		setup_panic();
+
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4467c49..ab6ea37 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -100,12 +100,6 @@ unsigned long SYSRQ_KEY;
 #endif /* CONFIG_MAGIC_SYSRQ */
 
 
-static int ppc64_panic_event(struct notifier_block *, unsigned long, void *);
-static struct notifier_block ppc64_panic_block = {
-	.notifier_call = ppc64_panic_event,
-	.priority = INT_MIN /* may not return; must be done last */
-};
-
 #ifdef CONFIG_SMP
 
 static int smt_enabled_cmdline;
@@ -456,13 +450,6 @@ #endif
 	DBG(" <- setup_system()\n");
 }
 
-static int ppc64_panic_event(struct notifier_block *this,
-                             unsigned long event, void *ptr)
-{
-	ppc_md.panic((char *)ptr);  /* May not return */
-	return NOTIFY_DONE;
-}
-
 #ifdef CONFIG_IRQSTACKS
 static void __init irqstack_early_init(void)
 {
@@ -517,8 +504,6 @@ static void __init emergency_stack_init(
  */
 void __init setup_arch(char **cmdline_p)
 {
-	extern void do_init_bootmem(void);
-
 	ppc64_boot_msg(0x12, "Setup Arch");
 
 	*cmdline_p = cmd_line;
@@ -535,8 +520,7 @@ void __init setup_arch(char **cmdline_p)
 	panic_timeout = 180;
 
 	if (ppc_md.panic)
-		atomic_notifier_chain_register(&panic_notifier_list,
-				&ppc64_panic_block);
+		setup_panic();
 
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) _etext;
