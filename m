Return-Path: <SRS0+ece2fd61c1dcd6e6d665+816+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A345B6873F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 02:24:39 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Thu, 17 Nov 2005 15:24:29 +0000
Message-Id: <1132241069.28963.169.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix zImage boot on old Pegasos firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If a claim fails, the Pegasos firmware pretends it never even made it
into the prom, rather than indicating that it tried and failed.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/boot/prom.c b/arch/powerpc/boot/prom.c
index 4bea2f4..e8a6304 100644
--- a/arch/powerpc/boot/prom.c
+++ b/arch/powerpc/boot/prom.c
@@ -116,6 +116,7 @@ finddevice(const char *name)
 void *
 claim(unsigned long virt, unsigned long size, unsigned long align)
 {
+	int ret;
 	struct prom_args {
 		char *service;
 		int nargs;
@@ -132,7 +133,11 @@ claim(unsigned long virt, unsigned long 
 	args.virt = virt;
 	args.size = size;
 	args.align = align;
-	(*prom)(&args);
+	ret = (*prom)(&args);
+	/* The original Pegasos II firmware claims that the call never made 
+	   it into the prom, rather than returning failure correctly */
+	if (ret)
+		return (void *)-1;
 	return args.ret;
 }
 

-- 
dwmw2
