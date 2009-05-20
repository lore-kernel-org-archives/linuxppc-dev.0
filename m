Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id 0A1F8DE11F
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 10:28:54 +1000 (EST)
Received: by ewy11 with SMTP id 11so177393ewy.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 17:28:52 -0700 (PDT)
Message-ID: <4A134EC4.3000805@gmail.com>
Date: Wed, 20 May 2009 02:28:52 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: grant.likely@secretlab.ca
Subject: [PATCH] powerpc/5200: beyond ARRAY_SIZE of mpc52xx_uart_{ports, nodes}
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do not go beyond ARRAY_SIZE of mpc52xx_uart_{ports,nodes}

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 7f72f8c..b3feb61 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -988,7 +988,7 @@ mpc52xx_console_setup(struct console *co, char *options)
 	pr_debug("mpc52xx_console_setup co=%p, co->index=%i, options=%s\n",
 		 co, co->index, options);
 
-	if ((co->index < 0) || (co->index > MPC52xx_PSC_MAXNUM)) {
+	if ((co->index < 0) || (co->index >= MPC52xx_PSC_MAXNUM)) {
 		pr_debug("PSC%x out of range\n", co->index);
 		return -EINVAL;
 	}
