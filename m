Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd5Zf0G8XzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:01:14 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 4so11988862pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 08:01:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/4] cpuidle/powernv: avoid double irq enable coming out of
 idle
Date: Fri, 17 Nov 2017 02:00:51 +1000
Message-Id: <20171116160052.18672-4-npiggin@gmail.com>
In-Reply-To: <20171116160052.18672-1-npiggin@gmail.com>
References: <20171116160052.18672-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since e1689795a7 ("cpuidle: Add common time keeping and irq enabling"),
cpuidle drivers are expected to return from ->enter with irqs disabled.

Update the cpuidle-powernv snooze loop to disable irqs before returning.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index e06605b21841..1a8234e706bc 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -76,6 +76,8 @@ static int snooze_loop(struct cpuidle_device *dev,
 	ppc64_runlatch_on();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 
+	local_irq_disable();
+
 	return index;
 }
 
-- 
2.15.0
