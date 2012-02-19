Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jimi Xenidis <jimix@pobox.com>, grant.likely@secretlab.ca
MIME-Version: 1.0
Subject: [PATCH] powerpc/of: add OF_DYNAMIC for chroma
Date: Mon, 20 Feb 2012 09:48:01 +1100
Message-ID: <5145.1329691681@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

linux next-20120217 compiling ppc64e_defconfig fails with:

arch/powerpc/platforms/wsp/h8.c: In function 'wsp_h8_getaddr':
arch/powerpc/platforms/wsp/h8.c:116: error: implicit declaration of function 'of_detach_node'

The below fixes this by selecting the new OF_DYNAMIC when PPC_CHROMA.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
index 57d22a2..79d2225 100644
--- a/arch/powerpc/platforms/wsp/Kconfig
+++ b/arch/powerpc/platforms/wsp/Kconfig
@@ -25,6 +25,7 @@ config PPC_CHROMA
 	bool "PowerEN PCIe Chroma Card"
 	select EPAPR_BOOT
 	select PPC_WSP
+	select OF_DYNAMIC
 	default y
 
 endmenu
