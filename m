Return-Path: <trinabh@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 260E6B6F8E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 02:30:43 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p57GUeBZ027439
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2011 22:00:40 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p57GUeZu4218982
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2011 22:00:40 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p57GUeM8025717
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2011 02:30:40 +1000
From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 7/7] cpuidle: (POWER) Handle power_save=off
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@ozlabs.org
Date: Tue, 07 Jun 2011 22:00:38 +0530
Message-ID: <20110607163033.6848.70719.stgit@tringupt.in.ibm.com>
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

This patch makes pseries_idle_driver to be not registered when
power_save=off kernel boot option is specified. For this
boot_option_idle_override is used similar to how it is used for x86.

Signed-off-by: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/processor.h            |    3 +++
 arch/powerpc/kernel/idle.c                      |    4 ++++
 arch/powerpc/platforms/pseries/processor_idle.c |    4 ++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index d50c2b6..0ce167e 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -377,6 +377,9 @@ static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
 }
 #endif
 
+extern unsigned long  boot_option_idle_override;
+enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
+
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_PROCESSOR_H */
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 932392b..61515f4 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -39,9 +39,13 @@
 #define cpu_should_die()	0
 #endif
 
+unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
+EXPORT_SYMBOL(boot_option_idle_override);
+
 static int __init powersave_off(char *arg)
 {
 	ppc_md.power_save = NULL;
+	boot_option_idle_override = IDLE_POWERSAVE_OFF;
 	return 0;
 }
 __setup("powersave=off", powersave_off);
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index ff44b49..c4c3383 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -288,6 +288,10 @@ static int pseries_idle_probe(void)
 		return -EPERM;
 	}
 
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE) {
+		return -ENODEV;
+	}
+
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		printk(KERN_DEBUG "Using default idle\n");
 		return -ENODEV;
