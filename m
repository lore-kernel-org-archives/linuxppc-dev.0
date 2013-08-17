Return-Path: <toshi.kani@hp.com>
Received: from g5t0007.atlanta.hp.com (g5t0007.atlanta.hp.com [15.192.0.44])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 796FA2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 05:58:29 +1000 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: mingo@redhat.com, hpa@linux.intel.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, benh@kernel.crashing.org
Subject: [PATCH 3/4] hotplug, x86: Disable ARCH_CPU_PROBE_RELEASE on x86
Date: Sat, 17 Aug 2013 13:46:58 -0600
Message-Id: <1376768819-28975-4-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
References: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
Cc: fenghua.yu@intel.com, Toshi Kani <toshi.kani@hp.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, rjw@sisk.pl, isimatu.yasuaki@jp.fujitsu.com,
 srivatsa.bhat@linux.vnet.ibm.com, bp@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d7c53c9e enabled ARCH_CPU_PROBE_RELEASE on x86 in order to
serialize CPU online/offline operations.  Although it is the config
option to enable CPU hotplug test interfaces, probe & release, it is
also the option to enable cpu_hotplug_driver_lock() as well.  Therefore,
this option had to be enabled on x86 with dummy arch_cpu_probe() and
arch_cpu_release().

Since then, lock_device_hotplug() was introduced to serialize CPU
online/offline & hotplug operations.  Therefore, this config option
is no longer required for the serialization.  This patch disables
this config option on x86 and revert the changes made by commit
d7c53c9e.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 arch/x86/Kconfig          |    4 ----
 arch/x86/kernel/smpboot.c |   21 ---------------------
 2 files changed, 25 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b32ebf9..c87e49a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -255,10 +255,6 @@ config ARCH_HWEIGHT_CFLAGS
 	default "-fcall-saved-ecx -fcall-saved-edx" if X86_32
 	default "-fcall-saved-rdi -fcall-saved-rsi -fcall-saved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -fcall-saved-r11" if X86_64
 
-config ARCH_CPU_PROBE_RELEASE
-	def_bool y
-	depends on HOTPLUG_CPU
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index aecc98a..5b24a9d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,27 +82,6 @@
 /* State of each CPU */
 DEFINE_PER_CPU(int, cpu_state) = { 0 };
 
-#ifdef CONFIG_HOTPLUG_CPU
-/*
- * We need this for trampoline_base protection from concurrent accesses when
- * off- and onlining cores wildly.
- */
-static DEFINE_MUTEX(x86_cpu_hotplug_driver_mutex);
-
-void cpu_hotplug_driver_lock(void)
-{
-	mutex_lock(&x86_cpu_hotplug_driver_mutex);
-}
-
-void cpu_hotplug_driver_unlock(void)
-{
-	mutex_unlock(&x86_cpu_hotplug_driver_mutex);
-}
-
-ssize_t arch_cpu_probe(const char *buf, size_t count) { return -1; }
-ssize_t arch_cpu_release(const char *buf, size_t count) { return -1; }
-#endif
-
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 EXPORT_SYMBOL(smp_num_siblings);
