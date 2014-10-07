Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C027C1A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:29:30 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNKy-002aad-Jx
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:29:28 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/44] m68k: Replace mach_power_off with pm_power_off
Date: Mon,  6 Oct 2014 22:28:06 -0700
Message-Id: <1412659726-29957-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Greg Ungerer <gerg@uclinux.org>,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joshua Thompson <funaho@jurai.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace mach_power_off with pm_power_off to simplify the subsequent
move of pm_power_off to generic code.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/m68k/emu/natfeat.c         | 3 ++-
 arch/m68k/include/asm/machdep.h | 1 -
 arch/m68k/kernel/process.c      | 5 +++--
 arch/m68k/kernel/setup_mm.c     | 1 -
 arch/m68k/kernel/setup_no.c     | 1 -
 arch/m68k/mac/config.c          | 3 ++-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/emu/natfeat.c b/arch/m68k/emu/natfeat.c
index 71b78ec..91e2ae7 100644
--- a/arch/m68k/emu/natfeat.c
+++ b/arch/m68k/emu/natfeat.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/io.h>
 #include <asm/machdep.h>
 #include <asm/natfeat.h>
@@ -90,5 +91,5 @@ void __init nf_init(void)
 	pr_info("NatFeats found (%s, %lu.%lu)\n", buf, version >> 16,
 		version & 0xffff);
 
-	mach_power_off = nf_poweroff;
+	pm_power_off = nf_poweroff;
 }
diff --git a/arch/m68k/include/asm/machdep.h b/arch/m68k/include/asm/machdep.h
index 953ca21..f9fac51 100644
--- a/arch/m68k/include/asm/machdep.h
+++ b/arch/m68k/include/asm/machdep.h
@@ -24,7 +24,6 @@ extern int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 extern int (*mach_set_clock_mmss)(unsigned long);
 extern void (*mach_reset)( void );
 extern void (*mach_halt)( void );
-extern void (*mach_power_off)( void );
 extern unsigned long (*mach_hd_init) (unsigned long, unsigned long);
 extern void (*mach_hd_setup)(char *, int *);
 extern long mach_max_dma_address;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index c55ff71..afe3d6e 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -22,6 +22,7 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
@@ -77,8 +78,8 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	if (mach_power_off)
-		mach_power_off();
+	if (pm_power_off)
+		pm_power_off();
 	for (;;);
 }
 
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 5b8ec4d..002fea6 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -96,7 +96,6 @@ EXPORT_SYMBOL(mach_get_rtc_pll);
 EXPORT_SYMBOL(mach_set_rtc_pll);
 void (*mach_reset)( void );
 void (*mach_halt)( void );
-void (*mach_power_off)( void );
 long mach_max_dma_address = 0x00ffffff; /* default set to the lower 16MB */
 #ifdef CONFIG_HEARTBEAT
 void (*mach_heartbeat) (int);
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index 88c27d9..1520156 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -55,7 +55,6 @@ int (*mach_hwclk) (int, struct rtc_time*);
 /* machine dependent reboot functions */
 void (*mach_reset)(void);
 void (*mach_halt)(void);
-void (*mach_power_off)(void);
 
 #ifdef CONFIG_M68000
 #if defined(CONFIG_M68328)
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index a471eab..677913ff 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -16,6 +16,7 @@
 #include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 /* keyb */
 #include <linux/random.h>
 #include <linux/delay.h>
@@ -159,7 +160,7 @@ void __init config_mac(void)
 	mach_set_clock_mmss = mac_set_clock_mmss;
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
-	mach_power_off = mac_poweroff;
+	pm_power_off = mac_poweroff;
 	mach_max_dma_address = 0xffffffff;
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
 	mach_beep = mac_mksound;
-- 
1.9.1
