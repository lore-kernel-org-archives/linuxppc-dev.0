Return-Path: <allen.lkml@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzBH668PTzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 21:35:14 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id d8so481944pgt.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:35:14 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 2/3] powerpc: use setup_timer() helper.
Date: Fri, 22 Sep 2017 17:04:59 +0530
Message-Id: <1506080100-5660-3-git-send-email-allen.lkml@gmail.com>
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
 arch/powerpc/kernel/tau_6xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index a753b72..726c2d6 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -229,8 +229,7 @@ int __init TAU_init(void)
 
 
 	/* first, set up the window shrinking timer */
-	init_timer(&tau_timer);
-	tau_timer.function = tau_timeout_smp;
+	setup_timer(&tau_timer, tau_timeout_smp, 0UL);
 	tau_timer.expires = jiffies + shrink_timer;
 	add_timer(&tau_timer);
 
-- 
2.7.4
