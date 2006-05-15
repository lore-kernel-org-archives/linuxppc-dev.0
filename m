Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C60967A41
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 15:46:11 +1000 (EST)
Subject: [PATCH] Fix pSeries identification in prom_init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 15 May 2006 15:46:03 +1000
Message-Id: <1147671963.21291.91.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The OF trampoline code prom_init.c still needs to identify IBM pSeries
(PAPR) machines in order to run some platform specific code on them like
instanciating the TCE tables. The code doing that detection was changed
recently in 2.6.17 early stages but was done slightly incorrectly. It
should be testing for an exact match of "chrp" and it currently tests
for anything that begins with "chrp". That means it will incorrectly
match with platforms using Maple-like device-trees and have open
firmware. This fixes it by using strcmp instead of strncmp to match what
the actual platform detection code does.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Paul, if you are happy with that, please send upsteam ASAP.

Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-05-02 10:51:33.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom_init.c	2006-05-15 15:37:03.000000000 +1000
@@ -1636,7 +1636,7 @@
 			   compat, sizeof(compat)-1);
 	if (len <= 0)
 		return PLATFORM_GENERIC;
-	if (strncmp(compat, RELOC("chrp"), 4))
+	if (strcmp(compat, RELOC("chrp")))
 		return PLATFORM_GENERIC;
 
 	/* Default to pSeries. We need to know if we are running LPAR */
