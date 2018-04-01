Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DWxJ2zW3zF21n
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 20:36:36 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id m22-v6so2540609pls.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Apr 2018 03:36:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] powerpc: hard disable irqs in smp_send_stop loop
Date: Sun,  1 Apr 2018 20:36:14 +1000
Message-Id: <20180401103615.15454-3-npiggin@gmail.com>
In-Reply-To: <20180401103615.15454-1-npiggin@gmail.com>
References: <20180401103615.15454-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hard lockup watchdog can fire under local_irq_disable
on platforms with irq soft masking.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index db88660bf6bd..e16ec7b3b427 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -574,9 +574,10 @@ static void stop_this_cpu(void *dummy)
 	/* Remove this CPU */
 	set_cpu_online(smp_processor_id(), false);
 
-	local_irq_disable();
+	hard_irq_disable();
+	spin_begin();
 	while (1)
-		;
+		spin_cpu_relax();
 }
 
 void smp_send_stop(void)
-- 
2.16.3
