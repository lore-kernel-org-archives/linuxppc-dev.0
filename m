Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ADC11A171D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:30:56 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNMM-002iwl-6B
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:30:54 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 40/44] x86: intel-mid: Drop registration of dummy poweroff
 handlers
Date: Mon,  6 Oct 2014 22:28:42 -0700
Message-Id: <1412659726-29957-41-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A dummy poweroff handler does not serve any purpose. Drop it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/platform/intel-mid/intel-mid.c | 5 -----
 arch/x86/platform/intel-mid/mfld.c      | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 1bbedc4..4b70666 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -67,10 +67,6 @@ static void *(*get_intel_mid_ops[])(void) = INTEL_MID_OPS_INIT;
 enum intel_mid_cpu_type __intel_mid_cpu_chip;
 EXPORT_SYMBOL_GPL(__intel_mid_cpu_chip);
 
-static void intel_mid_power_off(void)
-{
-};
-
 static void intel_mid_reboot(void)
 {
 	intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
@@ -183,7 +179,6 @@ void __init x86_intel_mid_early_setup(void)
 
 	legacy_pic = &null_legacy_pic;
 
-	pm_power_off = intel_mid_power_off;
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
 	/* Avoid searching for BIOS MP tables */
diff --git a/arch/x86/platform/intel-mid/mfld.c b/arch/x86/platform/intel-mid/mfld.c
index 23381d2..cf6842f 100644
--- a/arch/x86/platform/intel-mid/mfld.c
+++ b/arch/x86/platform/intel-mid/mfld.c
@@ -23,10 +23,6 @@ static struct intel_mid_ops penwell_ops = {
 	.arch_setup = penwell_arch_setup,
 };
 
-static void mfld_power_off(void)
-{
-}
-
 static unsigned long __init mfld_calibrate_tsc(void)
 {
 	unsigned long fast_calibrate;
@@ -61,7 +57,6 @@ static unsigned long __init mfld_calibrate_tsc(void)
 static void __init penwell_arch_setup(void)
 {
 	x86_platform.calibrate_tsc = mfld_calibrate_tsc;
-	pm_power_off = mfld_power_off;
 }
 
 void *get_penwell_ops(void)
-- 
1.9.1
