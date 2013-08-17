Return-Path: <toshi.kani@hp.com>
Received: from g5t0007.atlanta.hp.com (g5t0007.atlanta.hp.com [15.192.0.44])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E12E52C0114
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 05:58:29 +1000 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: mingo@redhat.com, hpa@linux.intel.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, benh@kernel.crashing.org
Subject: [PATCH 0/4] Unify CPU hotplug lock interface
Date: Sat, 17 Aug 2013 13:46:55 -0600
Message-Id: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
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

lock_device_hotplug() was recently introduced to serialize CPU & Memory
online/offline and hotplug operations, along with sysfs online interface
restructure (commit 4f3549d7).  With this new locking scheme,
cpu_hotplug_driver_lock() is redundant and is no longer necessary.

This patchset makes sure that lock_device_hotplug() covers all CPU online/
offline interfaces, and then removes cpu_hotplug_driver_lock().

The patchset is based on Linus's tree, 3.11.0-rc5.

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
 drivers/base/cpu.c                     | 26 ++++++++++++----------
 include/linux/cpu.h                    | 13 -----------
 7 files changed, 37 insertions(+), 90 deletions(-)
