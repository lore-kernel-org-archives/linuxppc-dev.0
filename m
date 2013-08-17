Return-Path: <toshi.kani@hp.com>
Received: from g6t0187.atlanta.hp.com (g6t0187.atlanta.hp.com [15.193.32.64])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 776F72C0187
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 05:55:08 +1000 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: mingo@redhat.com, hpa@linux.intel.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, benh@kernel.crashing.org
Subject: [PATCH 1/4] hotplug, x86: Fix online state in cpu0 debug interface
Date: Sat, 17 Aug 2013 13:46:56 -0600
Message-Id: <1376768819-28975-2-git-send-email-toshi.kani@hp.com>
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

_debug_hotplug_cpu() is a debug interface that puts cpu0 offline during
boot-up when CONFIG_DEBUG_HOTPLUG_CPU0 is set.  After cpu0 is put offline
in this interface, however, /sys/devices/system/cpu/cpu0/online still
shows 1 (online).

This patch fixes _debug_hotplug_cpu() to update dev->offline when CPU
online/offline operation succeeded.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
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
