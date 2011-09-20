Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D78F2B70B9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:45:20 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/20] powerpc/udbg: Fix Kconfig entry for avoiding 44x early
	debug with KVM
Date: Tue, 20 Sep 2011 13:44:48 +1000
Message-Id: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It was preventing the global early debug selection whenever KVM was enabled
instead of only preventing the 440 specific one.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig.debug |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 067cb84..cc01f1d 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -141,9 +141,6 @@ config BOOTX_TEXT
 
 config PPC_EARLY_DEBUG
 	bool "Early debugging (dangerous)"
-	# PPC_EARLY_DEBUG on 440 leaves AS=1 mappings above the TLB high water
-	# mark, which doesn't work with current 440 KVM.
-	depends on !KVM
 	help
 	  Say Y to enable some early debugging facilities that may be available
 	  for your processor/board combination. Those facilities are hacks
@@ -222,7 +219,9 @@ config PPC_EARLY_DEBUG_BEAT
 
 config PPC_EARLY_DEBUG_44x
 	bool "Early serial debugging for IBM/AMCC 44x CPUs"
-	depends on 44x
+	# PPC_EARLY_DEBUG on 440 leaves AS=1 mappings above the TLB high water
+	# mark, which doesn't work with current 440 KVM.
+	depends on 44x && !KVM
 	help
 	  Select this to enable early debugging for IBM 44x chips via the
 	  inbuilt serial port.  If you enable this, ensure you set
-- 
1.7.4.1
