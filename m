Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7A0842C0113
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 00:41:50 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/2] powerpc/mpc512x: initialize board restart earlier
Date: Tue, 14 May 2013 16:40:54 +0200
Message-Id: <1368542454-11003-3-git-send-email-gsi@denx.de>
In-Reply-To: <1368542454-11003-1-git-send-email-gsi@denx.de>
References: <1368542454-11003-1-git-send-email-gsi@denx.de>
Cc: Gerhard Sittig <gsi@denx.de>, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

move the MPC512x restart initialization from the shared init routine
to the shared init_early routine

recent problems in the proc(5) filesystem initialization led to the
situation where the platform's restart routine was invoked yet the
registers required for software reset were not yet available, which
made the board hang instead of reboot

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 09622d3..a8b5110 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -438,6 +438,7 @@ void __init mpc512x_psc_fifo_init(void)
 
 void __init mpc512x_init_early(void)
 {
+	mpc512x_restart_init();
 	if (IS_ENABLED(CONFIG_FB_FSL_DIU))
 		mpc512x_init_diu();
 }
@@ -446,7 +447,6 @@ void __init mpc512x_init(void)
 {
 	mpc5121_clk_init();
 	mpc512x_declare_of_platform_devices();
-	mpc512x_restart_init();
 	mpc512x_psc_fifo_init();
 }
 
-- 
1.7.10.4
