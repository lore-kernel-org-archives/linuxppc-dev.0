Return-Path: <trinabh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1D8BB6FB9
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 02:29:43 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p57GNoJK031717
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2011 02:23:50 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p57GSqfe1302644
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2011 02:28:52 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p57GTgJ2022608
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2011 02:29:42 +1000
From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 2/7] cpuidle: replace xen access to x86 pm_idle and
	default_idle
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@ozlabs.org
Date: Tue, 07 Jun 2011 21:59:38 +0530
Message-ID: <20110607162933.6848.14665.stgit@tringupt.in.ibm.com>
In-Reply-To: <20110607162847.6848.44707.stgit@tringupt.in.ibm.com>
References: <20110607162847.6848.44707.stgit@tringupt.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Len Brown <len.brown@intel.com>

When a Xen Dom0 kernel boots on a hypervisor, it gets access
to the raw-hardware ACPI tables.  While it parses the idle tables
for the hypervisor's beneift, it uses HLT for its own idle.

Rather than have xen scribble on pm_idle and access default_idle,
have it simply disable_cpuidle() so acpi_idle will not load and
architecture default HLT will be used.

cc: xen-devel@lists.xensource.com
Signed-off-by: Len Brown <len.brown@intel.com>
---

 arch/x86/xen/setup.c      |    3 ++-
 drivers/cpuidle/cpuidle.c |    4 ++++
 include/linux/cpuidle.h   |    2 ++
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index be1a464..ab1a916 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/memblock.h>
+#include <linux/cpuidle.h>
 
 #include <asm/elf.h>
 #include <asm/vdso.h>
@@ -424,7 +425,7 @@ void __init xen_arch_setup(void)
 #ifdef CONFIG_X86_32
 	boot_cpu_data.hlt_works_ok = 1;
 #endif
-	pm_idle = default_idle;
+	disable_cpuidle();
 	boot_option_idle_override = IDLE_HALT;
 
 	fiddle_vdso();
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a171b9e..8d7303b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -34,6 +34,10 @@ int cpuidle_disabled(void)
 {
 	return off;
 }
+void disable_cpuidle(void)
+{
+	off = 1;
+}
 
 #if defined(CONFIG_ARCH_HAS_CPU_IDLE_WAIT)
 static void cpuidle_kick_cpus(void)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1e85538..2786787 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -127,6 +127,7 @@ struct cpuidle_driver {
 };
 
 #ifdef CONFIG_CPU_IDLE
+extern void disable_cpuidle(void);
 
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 struct cpuidle_driver *cpuidle_get_driver(void);
@@ -140,6 +141,7 @@ extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 
 #else
+static inline void disable_cpuidle(void) { }
 
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
 {return -ENODEV; }
