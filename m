Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83BD6B6EF4
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 00:55:23 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/40x: Add support for PPC40x boards with > 512MB SDRAM
Date: Wed, 10 Feb 2010 14:54:59 +0100
Message-Id: <1265810099-31355-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for boards with more that 512MByte RAM. Currently
only 512MB of memory are enabled in the DCCR/ICCR real-mode cache
control registers. This patch now enables caching in real-mode for
2GByte.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/mm/40x_mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index 08dfa8e..65abfcf 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -84,8 +84,8 @@ void __init MMU_init_hw(void)
 	 * vectors and the kernel live in real-mode.
 	 */
 
-        mtspr(SPRN_DCCR, 0xF0000000);	/* 512 MB of data space at 0x0. */
-        mtspr(SPRN_ICCR, 0xF0000000);	/* 512 MB of instr. space at 0x0. */
+        mtspr(SPRN_DCCR, 0xFFFF0000);	/* 2GByte of data space at 0x0. */
+        mtspr(SPRN_ICCR, 0xFFFF0000);	/* 2GByte of instr. space at 0x0. */
 }
 
 #define LARGE_PAGE_SIZE_16M	(1<<24)
-- 
1.6.6.1
