Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1983A680A7
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 07:43:33 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1E7gbC-0007Bf-NF@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:26 +0100
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] (20/43) Kconfig fix (ppc32 SMP dependencies)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc SMP is supported only for 6xx/POWER3/POWER4 - i.e. ones that have
PPC_STD_MMU.  Dependency fixed.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-vga/arch/ppc/Kconfig RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig
--- RC13-rc6-git13-vga/arch/ppc/Kconfig	2005-08-21 13:16:48.000000000 -0400
+++ RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig	2005-08-21 13:17:03.000000000 -0400
@@ -915,6 +915,7 @@
 	default y if PPC_PREP
 
 config SMP
+	depends on PPC_STD_MMU
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
