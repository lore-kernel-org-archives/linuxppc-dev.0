Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5913F680EB
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 07:43:35 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1E7gbH-0007Bo-Oa@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:31 +0100
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] (21/43) Kconfig fix (IRQ_ALL_CPUS vs. MV64360)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MV64360 does not support IRQ_ALL_CPUS - see arch/ppc/kernel/mv64360_pic.c.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig RC13-rc6-git13-mv64360-irq/arch/ppc/Kconfig
--- RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig	2005-08-21 13:17:03.000000000 -0400
+++ RC13-rc6-git13-mv64360-irq/arch/ppc/Kconfig	2005-08-21 13:17:04.000000000 -0400
@@ -935,7 +935,7 @@
 
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
-	depends on SMP
+	depends on SMP && !MV64360
 	help
 	  This option gives the kernel permission to distribute IRQs across
 	  multiple CPUs.  Saying N here will route all IRQs to the first
