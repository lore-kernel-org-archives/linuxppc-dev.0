Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78541688D9
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2005 09:35:28 +1100 (EST)
To: torvalds@osdl.org
Message-Id: <E1EnOAd-0006JR-TM@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 16 Dec 2005 22:35:23 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: ppc4xx_dma DMA_MODE_{READ,WRITE} fix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

DMA_MODE_{READ,WRITE} are declared in asm-powerpc/dma.h and their
declarations there match the definitions.  Old declarations in
ppc4xx_dma.h are not right anymore (wrong type, to start with).
Killed them, added include of asm/dma.h where needed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 arch/ppc/syslib/ppc4xx_dma.c |    1 +
 include/asm-ppc/ppc4xx_dma.h |    3 ---
 2 files changed, 1 insertions(+), 3 deletions(-)

fc830a6f62230c04590f711798ea8de44e567439
diff --git a/arch/ppc/syslib/ppc4xx_dma.c b/arch/ppc/syslib/ppc4xx_dma.c
index f15e642..05ccd59 100644
--- a/arch/ppc/syslib/ppc4xx_dma.c
+++ b/arch/ppc/syslib/ppc4xx_dma.c
@@ -30,6 +30,7 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
+#include <asm/dma.h>
 #include <asm/ppc4xx_dma.h>
 
 ppc_dma_ch_t dma_channels[MAX_PPC4xx_DMA_CHANNELS];
diff --git a/include/asm-ppc/ppc4xx_dma.h b/include/asm-ppc/ppc4xx_dma.h
index a415001..46a086f 100644
--- a/include/asm-ppc/ppc4xx_dma.h
+++ b/include/asm-ppc/ppc4xx_dma.h
@@ -33,9 +33,6 @@
 
 #define MAX_PPC4xx_DMA_CHANNELS		4
 
-/* in arch/ppc/kernel/setup.c -- Cort */
-extern unsigned long DMA_MODE_WRITE, DMA_MODE_READ;
-
 /*
  * Function return status codes
  * These values are used to indicate whether or not the function
-- 
0.99.9.GIT
