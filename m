Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED1911007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 06:47:08 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND] mpc52xx: gpt: include fs.h
Date: Mon, 13 Dec 2010 20:47:30 +0100
Message-Id: <1292269650-6593-1-git-send-email-w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix build errors like these from a randconfig:

src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:549: error: dereferencing pointer to incomplete type: 1 errors in 1 logs
src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:636: error: implicit declaration of function 'nonseekable_open': 1 errors in 1 logs
src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:657: error: variable 'mpc52xx_wdt_fops' has initializer but incomplete type: 1 errors in 1 logs
src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:658: error: excess elements in struct initializer: 1 errors in 1 logs
src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:658: error: unknown field 'owner' specified in initializer: 1 errors in 1 logs
...

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

As this is a build-fix, would be nice to have for 2.6.37.
A similar one was already comitted: f6e0722fc3a35ff818c86ffbc414f7592a8119cf

 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index fea833e..e0d703c 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -63,6 +63,7 @@
 #include <linux/of_gpio.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
 #include <linux/watchdog.h>
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
-- 
1.7.2.3
