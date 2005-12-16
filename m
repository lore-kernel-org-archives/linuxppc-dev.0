Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E21B688EF
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2005 09:35:32 +1100 (EST)
To: torvalds@osdl.org
Message-Id: <E1EnOAi-0006JX-TK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 16 Dec 2005 22:35:28 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: booke_wdt compile fix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


booke_wdt.c had been missed in cpu_specs[] removal sweep

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/char/watchdog/booke_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c845a90e7ff367deb10a66dbf37c3709b8d76325
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index c800cce..b664060 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -173,7 +173,7 @@ static int __init booke_wdt_init(void)
 	int ret = 0;
 
 	printk (KERN_INFO "PowerPC Book-E Watchdog Timer Loaded\n");
-	ident.firmware_version = cpu_specs[0].pvr_value;
+	ident.firmware_version = cur_cpu_spec->pvr_value;
 
 	ret = misc_register(&booke_wdt_miscdev);
 	if (ret) {
-- 
0.99.9.GIT
