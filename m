Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 87E0DDDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:02:38 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id B01BF14288
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 15:02:38 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27050-09 for <linuxppc-dev@ozlabs.org>;
	Wed, 17 Oct 2007 15:02:37 +0200 (CEST)
Message-ID: <471607DB.4060509@semihalf.com>
Date: Wed, 17 Oct 2007 15:02:19 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] [POWERPC] Enable restart support for lite5200 board
References: <47160689.4020301@semihalf.com>
In-Reply-To: <47160689.4020301@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 lite5200.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 0caa3d9..ce9e3ee 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -143,6 +143,9 @@ #endif
 	/* Some mpc5200 & mpc5200b related configuration */
 	mpc5200_setup_xlb_arbiter();
 
+	/* Map wdt for mpc52xx_restart() */
+	mpc52xx_map_wdt();
+
 #ifdef CONFIG_PM
 	mpc52xx_suspend.board_suspend_prepare = lite5200_suspend_prepare;
 	mpc52xx_suspend.board_resume_finish = lite5200_resume_finish;
@@ -193,5 +196,6 @@ define_machine(lite5200) {
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
+	.restart	= mpc52xx_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 };
