Return-Path: <toshi.kani@hp.com>
Received: from g6t0187.atlanta.hp.com (g6t0187.atlanta.hp.com [15.193.32.64])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC97D2C0202
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 05:55:08 +1000 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: mingo@redhat.com, hpa@linux.intel.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, benh@kernel.crashing.org
Subject: [PATCH 2/4] hotplug, x86: Add hotplug lock to missing places
Date: Sat, 17 Aug 2013 13:46:57 -0600
Message-Id: <1376768819-28975-3-git-send-email-toshi.kani@hp.com>
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

lock_device_hotplug() serializes CPU & Memory online/offline and hotplug
operations.  However, this lock is not held in the debug interfaces below
that initiate CPU online/offline operations.

 - _debug_hotplug_cpu(), cpu0 hotplug test interface enabled by
   CONFIG_DEBUG_HOTPLUG_CPU0.
 - cpu_probe_store() and cpu_release_store(), cpu hotplug test interface
   enabled by CONFIG_ARCH_CPU_PROBE_RELEASE.

This patch changes the above interfaces to hold lock_device_hotplug().

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 arch/x86/kernel/topology.c |    2 ++
 drivers/base/cpu.c         |   16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 5823bbd..a3f35eb 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -65,6 +65,7 @@ int __ref _debug_hotplug_cpu(int cpu, int action)
 	if (!cpu_is_hotpluggable(cpu))
 		return -EINVAL;
 
+	lock_device_hotplug();
 	cpu_hotplug_driver_lock();
 
 	switch (action) {
@@ -91,6 +92,7 @@ int __ref _debug_hotplug_cpu(int cpu, int action)
 	}
 
 	cpu_hotplug_driver_unlock();
+	unlock_device_hotplug();
 
 	return ret;
 }
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c358bc..4cc6928 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -88,7 +88,13 @@ static ssize_t cpu_probe_store(struct device *dev,
 			       const char *buf,
 			       size_t count)
 {
-	return arch_cpu_probe(buf, count);
+	ssize_t ret;
+
+	lock_device_hotplug();
+	ret = arch_cpu_probe(buf, count);
+	unlock_device_hotplug();
+
+	return ret;
 }
 
 static ssize_t cpu_release_store(struct device *dev,
@@ -96,7 +102,13 @@ static ssize_t cpu_release_store(struct device *dev,
 				 const char *buf,
 				 size_t count)
 {
-	return arch_cpu_release(buf, count);
+	ssize_t ret;
+
+	lock_device_hotplug();
+	ret = arch_cpu_release(buf, count);
+	unlock_device_hotplug();
+
+	return ret;
 }
 
 static DEVICE_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
