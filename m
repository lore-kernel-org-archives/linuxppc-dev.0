Return-Path: <kernelfans@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40C3dX4FZRzF1Yx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 12:17:52 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id t16so4435576pfh.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 18:17:52 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 hbathini@linux.vnet.ibm.com
Subject: [PATCH 2/2] powerpc/cpuidle: dynamically register/unregister
 cpuidle_device during hotplug
Date: Fri, 30 Mar 2018 09:17:37 +0800
Message-Id: <1522372657-27490-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1522372657-27490-1-git-send-email-kernelfans@gmail.com>
References: <1522372657-27490-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now for pseries, ../cpu/cpuX is created and deleted dynamically.
Hence cpuX/cpuidle should be created and deleted dynamically.
For powernv, it is harmless to use the same method.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 ++
 drivers/cpuidle/cpuidle-pseries.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1a8234e..962c944 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -144,6 +144,7 @@ static int powernv_cpuidle_cpu_online(unsigned int cpu)
 	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
 
 	if (dev && cpuidle_get_driver()) {
+		cpuidle_register_device(dev);
 		cpuidle_pause_and_lock();
 		cpuidle_enable_device(dev);
 		cpuidle_resume_and_unlock();
@@ -159,6 +160,7 @@ static int powernv_cpuidle_cpu_dead(unsigned int cpu)
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
