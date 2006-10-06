Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9929767E94
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2006 04:05:55 +1000 (EST)
Date: Fri, 6 Oct 2006 11:05:49 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add Kconfig dependency !VT for VIOCONS
Message-ID: <20061006180549.GB3684@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Judith Lebzelter <judith@osdl.org>

Add Kconfig dependency !VT for VIOCONS

I would like to avoid this compile error in 'allmodconfig':
drivers/char/viocons.c:52:2: error: #error You must turn off CONFIG_VT to use CONFIG_VIOCONS

Signed-off-by: Judith Lebzelter <judith@osdl.org>
---

Index: linux/arch/powerpc/platforms/iseries/Kconfig
===================================================================
--- linux.orig/arch/powerpc/platforms/iseries/Kconfig	2006-10-05 09:35:09.000000000 -0700
+++ linux/arch/powerpc/platforms/iseries/Kconfig	2006-10-06 10:30:19.333425703 -0700
@@ -4,6 +4,7 @@
 
 config VIOCONS
 	tristate "iSeries Virtual Console Support (Obsolete)"
+	depends on !VT
 	help
 	  This is the old virtual console driver for legacy iSeries.
 	  You should use the iSeries Hypervisor Virtual Console
