Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFgh9577pzDr5P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 08:27:21 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7IMNltp092118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 18:27:17 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24v7622v1g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 18:27:17 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 18 Aug 2016 16:27:16 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at start
Date: Fri, 19 Aug 2016 03:56:54 +0530
In-Reply-To: <cover.1471557381.git.ego@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1471557381.git.ego@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
Message-Id: <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently all the idle states registered by a cpu-idle driver are
enabled by default. This patch adds a mechanism which allows the
driver to hint if an idle-state should start in a disabled state. The
cpu-idle core will use this hint to appropriately initialize the
usage->disable knob of the CPU device idle state.

The state can be enabled at run time by echo'ing a zero to the sysfs
"disable" control file.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle.c | 7 +++++++
 include/linux/cpuidle.h   | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c73207a..b4debc7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -439,7 +439,14 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 
 static void __cpuidle_device_init(struct cpuidle_device *dev)
 {
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	int i;
+
 	memset(dev->states_usage, 0, sizeof(dev->states_usage));
+	for (i = 0; i < drv->state_count; i++) {
+		if (drv->states[i].disable_use_at_start)
+			dev->states_usage[i].disable = 1;
+	}
 	dev->last_residency = 0;
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index bb31373..f3fe855 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -44,7 +44,12 @@ struct cpuidle_state {
 	int		power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
 	bool		disabled; /* disabled on all CPUs */
-
+	/*
+	 * disable_use_at_start: If true, then this idle state will be
+	 * disabled by default. It can be enabled at runtime using the
+	 * per-cpu cpuidle sysfs control file named "disable".
+	 */
+	bool            disable_use_at_start;
 	int (*enter)	(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index);
-- 
1.9.4
