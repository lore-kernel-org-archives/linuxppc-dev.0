Return-Path: <albert_herranz@yahoo.es>
Received: from smtp141.mail.ukl.yahoo.com (smtp141.mail.ukl.yahoo.com
	[77.238.184.72]) by ozlabs.org (Postfix) with SMTP id 3E08BB7BF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Nov 2009 07:44:11 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 06/11] powerpc: gamecube/wii: do not include PCI support
Date: Sat, 28 Nov 2009 21:43:52 +0100
Message-Id: <1259441037-15725-7-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Nintendo GameCube and Wii video game consoles do not have PCI hardware.
Avoid wasting their scarce memory by not including PCI support into the
kernel.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
v1 -> v2
- Drop selection of NOT_COHERENT_CACHE when GAMECUBE_COMMON is set
  and just make NOT_COHERENT_CACHE depend on GAMECUBE_COMMON.
  Suggestion by Arnd Bergmann.

 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2ba14e7..84b2566 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -679,7 +679,7 @@ config PPC_PCI_CHOICE
 config PCI
 	bool "PCI support" if PPC_PCI_CHOICE
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
-		&& !PPC_85xx && !PPC_86xx
+		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	select ARCH_SUPPORTS_MSI
-- 
1.6.3.3
