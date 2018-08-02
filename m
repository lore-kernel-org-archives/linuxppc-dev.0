Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hBFb0pHwzF22V
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 23:42:59 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id s17-v6so1051082plp.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 06:42:59 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] powerpc/cpuidle: dynamically register/unregister
 cpuidle_device during hotplug
Date: Thu,  2 Aug 2018 21:42:38 +0800
Message-Id: <1533217359-11420-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpuidle_device is touched during the cpu hotplug. At present, ppc64 just
online/offline cpu during hotplug/unplug. But if using the
register_cpu/unregister_cpu() API to implement the hotplug, the dir
/sys/../cpuX is created/destroyed during hotplug, hence we also need to
create the file cpuX/cpuidle dynamically.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 ++
 drivers/cpuidle/cpuidle-pseries.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index d29e4f0..94d0def 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -166,6 +166,7 @@ static int powernv_cpuidle_cpu_online(unsigned int cpu)
 	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
 
 	if (dev && cpuidle_get_driver()) {
+		cpuidle_register_device(dev);
 		cpuidle_pause_and_lock();
 		cpuidle_enable_device(dev);
 		cpuidle_resume_and_unlock();
@@ -181,6 +182,7 @@ static int powernv_cpuidle_cpu_dead(unsigned int cpu)
 		cpuidle_pause_and_lock();
 		cpuidle_disable_device(dev);
 		cpuidle_resume_and_unlock();
+		cpuidle_unregister_device(dev);
 	}
 	return 0;
 }
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 9e56bc4..a53be8a 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -193,6 +193,7 @@ static int pseries_cpuidle_cpu_online(unsigned int cpu)
 	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
 
 	if (dev && cpuidle_get_driver()) {
+		cpuidle_register_device(dev);
 		cpuidle_pause_and_lock();
 		cpuidle_enable_device(dev);
 		cpuidle_resume_and_unlock();
@@ -208,6 +209,7 @@ static int pseries_cpuidle_cpu_dead(unsigned int cpu)
 		cpuidle_pause_and_lock();
 		cpuidle_disable_device(dev);
 		cpuidle_resume_and_unlock();
+		cpuidle_unregister_device(dev);
 	}
 	return 0;
 }
-- 
2.7.4
