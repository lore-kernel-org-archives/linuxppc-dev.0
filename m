Return-Path: <toshi.kani@hp.com>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B44A32C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 10:24:02 +1000 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl
Subject: [PATCH v2 0/4] Unify CPU hotplug lock interface
Date: Thu, 29 Aug 2013 18:22:05 -0600
Message-Id: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
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

lock_device_hotplug() was recently introduced to serialize CPU & Memory
online/offline and hotplug operations, along with sysfs online interface
restructure (commit 4f3549d7).  With this new locking scheme,
cpu_hotplug_driver_lock() is redundant and is no longer necessary.

This patchset makes sure that lock_device_hotplug() covers all CPU online/
offline interfaces, and then removes cpu_hotplug_driver_lock().

v2:
 - Rebased to the pm tree, bleeding-edge.
 - Changed patch 2/4 to use lock_device_hotplug_sysfs().

---
Toshi Kani (4):
  hotplug, x86: Fix online state in cpu0 debug interface
  hotplug, x86: Add hotplug lock to missing places
  hotplug, x86: Disable ARCH_CPU_PROBE_RELEASE on x86
  hotplug, powerpc, x86: Remove cpu_hotplug_driver_lock()

---
 arch/powerpc/kernel/smp.c              | 12 ----------
 arch/powerpc/platforms/pseries/dlpar.c | 40 +++++++++++++---------------------
 arch/x86/Kconfig                       |  4 ----
 arch/x86/kernel/smpboot.c              | 21 ------------------
 arch/x86/kernel/topology.c             | 11 ++++++----
 drivers/base/cpu.c                     | 34 +++++++++++++++++++----------
 include/linux/cpu.h                    | 13 -----------
 7 files changed, 45 insertions(+), 90 deletions(-)
