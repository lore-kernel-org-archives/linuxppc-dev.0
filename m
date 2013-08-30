Return-Path: <toshi.kani@hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 342622C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 10:23:52 +1000 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl
Subject: [PATCH v2 2/4] hotplug, x86: Add hotplug lock to missing places
Date: Thu, 29 Aug 2013 18:22:07 -0600
Message-Id: <1377822129-4143-3-git-send-email-toshi.kani@hp.com>
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

lock_device_hotplug[_sysfs]() serializes CPU & Memory online/offline
and hotplug operations.  However, this lock is not held in the debug
interfaces below that initiate CPU online/offline operations.

 - _debug_hotplug_cpu(), cpu0 hotplug test interface enabled by
   CONFIG_DEBUG_HOTPLUG_CPU0.
 - cpu_probe_store() and cpu_release_store(), cpu hotplug test interface
   enabled by CONFIG_ARCH_CPU_PROBE_RELEASE.

This patch changes the above interfaces to hold lock_device_hotplug().

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/topology.c |    2 ++
 drivers/base/cpu.c         |   24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

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
index 4cf0717..dc78e45 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -89,7 +89,17 @@ static ssize_t cpu_probe_store(struct device *dev,
 			       const char *buf,
 			       size_t count)
 {
-	return arch_cpu_probe(buf, count);
+	ssize_t cnt;
+	int ret;
+
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
+	cnt = arch_cpu_probe(buf, count);
+
+	unlock_device_hotplug();
+	return cnt;
 }
 
 static ssize_t cpu_release_store(struct device *dev,
@@ -97,7 +107,17 @@ static ssize_t cpu_release_store(struct device *dev,
 				 const char *buf,
 				 size_t count)
 {
-	return arch_cpu_release(buf, count);
+	ssize_t cnt;
+	int ret;
+
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
+	cnt = arch_cpu_release(buf, count);
+
+	unlock_device_hotplug();
+	return cnt;
 }
 
 static DEVICE_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
