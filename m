Return-Path: <joakim.tjernlund@transmode.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5CC99B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 05:24:03 +1000 (EST)
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1128DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 05:24:02 +1000 (EST)
Received: from tmnt04.transmode.se (tmnt04.transmode.se [192.168.46.15])
	by gw1.transmode.se (Postfix) with ESMTP id 74077650009
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 21:15:56 +0200 (CEST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: avorontsov@ru.mvista.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] [spi_mpc83xx] Always enable legacy support.
Date: Wed,  1 Jul 2009 21:16:12 +0200
Message-Id: <1246475772-10645-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are out of tree boards that need this legacy support too.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
I hope this is OK. I just discovered that spi didn't work for
me in 2.6.30 and I have no time to work on coverting my boards.
I don't have a clue either on how to do that, any pointers
how to add a few spidev devices via OF?

 drivers/spi/spi_mpc83xx.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index f4573a9..d167577 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -882,7 +882,6 @@ static struct of_platform_driver of_mpc83xx_spi_driver = {
 	.remove		= __devexit_p(of_mpc83xx_spi_remove),
 };
 
-#ifdef CONFIG_MPC832x_RDB
 /*
  * 				XXX XXX XXX
  * This is "legacy" platform driver, was used by the MPC8323E-RDB boards
@@ -941,10 +940,6 @@ static void __exit legacy_driver_unregister(void)
 		return;
 	platform_driver_unregister(&mpc83xx_spi_driver);
 }
-#else
-static void __init legacy_driver_register(void) {}
-static void __exit legacy_driver_unregister(void) {}
-#endif /* CONFIG_MPC832x_RDB */
 
 static int __init mpc83xx_spi_init(void)
 {
-- 
1.6.2.3
