Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E97DB7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 23:16:52 +1100 (EST)
From: Mel Gorman <mel@csn.ul.ie>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: Add Kconfig dependency for PCI_MSI as needed by
	XICS
Date: Tue, 17 Nov 2009 12:07:36 +0000
Message-Id: <1258459659-11770-2-git-send-email-mel@csn.ul.ie>
In-Reply-To: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's possible to set CONFIG_XICS without CONFIG_PCI_MSI. When that
happens, the kernel fails to build with

arch/powerpc/platforms/built-in.o: In function `.xics_startup':
xics.c:(.text+0x12f60): undefined reference to `.unmask_msi_irq'
make: *** [.tmp_vmlinux1] Error 1

This patch adds the dependency in KConfig.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---
 arch/powerpc/platforms/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 04a8061..21a1fa1 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -52,7 +52,7 @@ config PPC_UDBG_BEAT
 	default n
 
 config XICS
-	depends on PPC_PSERIES
+	depends on PPC_PSERIES && PCI_MSI
 	bool
 	default y
 
-- 
1.6.5
