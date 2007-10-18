Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 97AA1DDEEC
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:45:00 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 4DE2114383
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:45:00 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11661-04 for <linuxppc-dev@ozlabs.org>;
	Thu, 18 Oct 2007 20:44:59 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 426DC142D3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:44:59 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v2 4/4] [POWERPC] Enable restart support for lite5200 board
To: linuxppc-dev@ozlabs.org
Date: Thu, 18 Oct 2007 20:44:39 +0200
Message-ID: <20071018184439.3584.72338.stgit@hekate.izotz.org>
In-Reply-To: <20071018184407.3584.3513.stgit@hekate.izotz.org>
References: <20071018184407.3584.3513.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

 arch/powerpc/platforms/52xx/lite5200.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 65b7ae4..25d2bfa 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -145,6 +145,9 @@ static void __init lite5200_setup_arch(void)
 	/* Some mpc5200 & mpc5200b related configuration */
 	mpc5200_setup_xlb_arbiter();
 
+	/* Map wdt for mpc52xx_restart() */
+	mpc52xx_map_wdt();
+
 #ifdef CONFIG_PM
 	mpc52xx_suspend.board_suspend_prepare = lite5200_suspend_prepare;
 	mpc52xx_suspend.board_resume_finish = lite5200_resume_finish;
@@ -183,5 +186,6 @@ define_machine(lite5200) {
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
+	.restart	= mpc52xx_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 };
