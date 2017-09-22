Return-Path: <allen.lkml@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzBHB629rzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 21:35:18 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i23so355911pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:35:18 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 3/3] powerpc: powermac: use setup_timer() helper.
Date: Fri, 22 Sep 2017 17:05:00 +0530
Message-Id: <1506080100-5660-4-git-send-email-allen.lkml@gmail.com>
In-Reply-To: <1506080100-5660-1-git-send-email-allen.lkml@gmail.com>
References: <1506080100-5660-1-git-send-email-allen.lkml@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 70183eb..39a1d42 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -513,9 +513,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	mutex_init(&host->mutex);
 	init_completion(&host->complete);
 	spin_lock_init(&host->lock);
-	init_timer(&host->timeout_timer);
-	host->timeout_timer.function = kw_i2c_timeout;
-	host->timeout_timer.data = (unsigned long)host;
+	setup_timer(&host->timeout_timer, kw_i2c_timeout, (unsigned long)host);
 
 	psteps = of_get_property(np, "AAPL,address-step", NULL);
 	steps = psteps ? (*psteps) : 0x10;
-- 
2.7.4
