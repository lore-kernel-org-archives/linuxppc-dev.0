Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E985B2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 19:09:52 +1100 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3YwL3K0V1Wz4KK7j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 09:09:48 +0100 (CET)
Received: from localhost (p4FC46B37.dip.t-dialin.net [79.196.107.55])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3YwL3J48G9zbbh7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 09:09:48 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/512x: initialize clocks before bus probing
Date: Tue, 29 Jan 2013 09:09:47 +0100
Message-Id: <1359446987-6014-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Early driver probing can fail due to not available clocks
(clk_get() fails) since the clk API init didn't take place yet.
Move clocks init before bus probing.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 37fc7a3..34bad13 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -428,8 +428,8 @@ void __init mpc512x_psc_fifo_init(void)
 
 void __init mpc512x_init(void)
 {
-	mpc512x_declare_of_platform_devices();
 	mpc5121_clk_init();
+	mpc512x_declare_of_platform_devices();
 	mpc512x_restart_init();
 	mpc512x_psc_fifo_init();
 }
-- 
1.7.11.7
