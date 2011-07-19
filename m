Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com
	[209.85.215.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2A51B73E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:54:55 +1000 (EST)
Received: by eyh6 with SMTP id 6so2714299eyh.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:51 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 04/14] 83xx/mpc834x_itx: drop pq2pro-localbus-specific code
Date: Tue, 19 Jul 2011 12:53:41 +0400
Message-Id: <1311065631-3429-5-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As localbus on mpc8349e-mitx now provides simple-bus compatibility, we
can drop code asking for pq2pro-localbus devices on mpc834x_itx boards.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index c853f66..d9ea7b7 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -39,17 +39,7 @@
 
 #include "mpc83xx.h"
 
-static struct of_device_id __initdata mpc834x_itx_ids[] = {
-	{ .compatible = "fsl,pq2pro-localbus", },
-	{},
-};
-
-static int __init mpc834x_itx_declare_of_platform_devices(void)
-{
-	mpc83xx_declare_of_platform_devices();
-	return of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
-}
-machine_device_initcall(mpc834x_itx, mpc834x_itx_declare_of_platform_devices);
+machine_device_initcall(mpc834x_itx, mpc83xx_declare_of_platform_devices);
 
 /* ************************************************************************
  *
-- 
1.7.2.5
