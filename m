Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 47648B6F01
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 03:38:18 +1000 (EST)
Date: Thu, 15 Jul 2010 21:38:16 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix GENERIC_ISA_DMA dependency
Message-ID: <20100715173816.GA17810@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerPC we should always use generic ISA DMA API implementation
as there is simply no other implementation exist.

Without this patch, the following build error pops up:

  sound/built-in.o: In function 'snd_dma_pointer':
  (.text+0x74ae): undefined reference to 'dma_spin_lock'
  ...
  make: *** [.tmp_vmlinux1] Error 1

This is PPC_85xx, SMP and some sound drivers set to =y.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 328774b..48c8cff 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -668,7 +668,7 @@ config NEED_SG_DMA_LENGTH
 
 config GENERIC_ISA_DMA
 	bool
-	depends on PPC64 || POWER4 || 6xx && !CPM2
+	depends on ISA_DMA_API
 	default y
 
 config PPC_INDIRECT_PCI
-- 
1.7.0.5
