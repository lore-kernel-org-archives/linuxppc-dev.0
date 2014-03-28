Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF4BB14008D
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:44 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 28 Mar 2014 12:36:43 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 81B162CE8050
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2S2GBWB6685106
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:16:11 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2S2ae41015008
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:40 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] powerpc: Make boot_cpuid common between 32 and 64-bit
Date: Fri, 28 Mar 2014 13:36:27 +1100
Message-Id: <1395974192-820-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
References: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the definition to setup-common.c and set the init value
to -1 on both 32 and 64-bit (it was 0 on 64-bit).

Additionally add a check to prom.c to garantee that the init
value has been udpated after the DT scan.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c         | 4 ++++
 arch/powerpc/kernel/setup-common.c | 3 +++
 arch/powerpc/kernel/setup_32.c     | 2 --
 arch/powerpc/kernel/setup_64.c     | 1 -
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0fc55b5..f1002b1 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -744,6 +744,10 @@ void __init early_init_devtree(void *params)
 	 * (altivec support, boot CPU ID, ...)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
+	if (boot_cpuid < 0) {
+		printk("Failed to indentify boot CPU !\n");
+		BUG();
+	}
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
 	/* We'll later wait for secondaries to check in; there are
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bc76cc6..79b7612 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -76,6 +76,9 @@ EXPORT_SYMBOL(ppc_md);
 struct machdep_calls *machine_id;
 EXPORT_SYMBOL(machine_id);
 
+int boot_cpuid = -1;
+EXPORT_SYMBOL_GPL(boot_cpuid);
+
 unsigned long klimit = (unsigned long) _end;
 
 char cmd_line[COMMAND_LINE_SIZE];
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 04cc4fc..ea4fda6 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -44,8 +44,6 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
-int boot_cpuid = -1;
-EXPORT_SYMBOL_GPL(boot_cpuid);
 int boot_cpuid_phys;
 EXPORT_SYMBOL_GPL(boot_cpuid_phys);
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4933909..d8aabbd 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -74,7 +74,6 @@
 #define DBG(fmt...)
 #endif
 
-int boot_cpuid = 0;
 int spinning_secondaries;
 u64 ppc64_pft_size;
 
-- 
1.8.3.2
