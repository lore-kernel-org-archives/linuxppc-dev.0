Return-Path: <toshi.kani@hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 159682C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 10:23:51 +1000 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl
Subject: [PATCH v2 1/4] hotplug, x86: Fix online state in cpu0 debug interface
Date: Thu, 29 Aug 2013 18:22:06 -0600
Message-Id: <1377822129-4143-2-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
References: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
Cc: fenghua.yu@intel.com, bp@suse.de, Toshi Kani <toshi.kani@hp.com>,
 gregkh@linuxfoundation.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, isimatu.yasuaki@jp.fujitsu.com, mingo@redhat.com,
 srivatsa.bhat@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com, tglx@linutronix.de,
 hpa@linux.intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_debug_hotplug_cpu() is a debug interface that puts cpu0 offline during
boot-up when CONFIG_DEBUG_HOTPLUG_CPU0 is set.  After cpu0 is put offline
in this interface, however, /sys/devices/system/cpu/cpu0/online still
shows 1 (online).

This patch fixes _debug_hotplug_cpu() to update dev->offline when CPU
online/offline operation succeeded.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/topology.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 6e60b5f..5823bbd 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -72,16 +72,19 @@ int __ref _debug_hotplug_cpu(int cpu, int action)
 		ret = cpu_down(cpu);
 		if (!ret) {
 			pr_info("CPU %u is now offline\n", cpu);
+			dev->offline = true;
 			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 		} else
 			pr_debug("Can't offline CPU%d.\n", cpu);
 		break;
 	case 1:
 		ret = cpu_up(cpu);
-		if (!ret)
+		if (!ret) {
+			dev->offline = false;
 			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-		else
+		} else {
 			pr_debug("Can't online CPU%d.\n", cpu);
+		}
 		break;
 	default:
 		ret = -EINVAL;
