Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pdt30KtNzDqRV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 16:35:22 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id k9-v6so4683390pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 23:35:22 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCHv2 1/3] powerpc/cpuidle: dynamically register/unregister
 cpuidle_device during hotplug
Date: Mon, 16 Apr 2018 14:35:06 +0800
Message-Id: <1523860508-19364-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1523860508-19364-1-git-send-email-kernelfans@gmail.com>
References: <1523860508-19364-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpuidle_device is touched during the cpu hotplug. In order to cope with the incoming
patch [3/3], which causes the dir /sys/../cpuX is created/destroyed during hotplug,
we also need to create the file cpuX/cpuidle dynamically.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
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
