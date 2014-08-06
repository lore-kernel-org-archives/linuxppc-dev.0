Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id CA6181A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 17:05:43 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/ppc476: Disable BTAC
Date: Wed,  6 Aug 2014 17:03:09 +1000
Message-Id: <1407308589-21311-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch disables the branch target address CAM which under specific
circumstances may cause the processor to skip execution of 1-4
instructions. This fixes IBM Erratum #47.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/kernel/head_44x.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index c334f53..b5061ab 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1210,10 +1210,12 @@ clear_utlb_entry:
 
 	/* We configure icbi to invalidate 128 bytes at a time since the
 	 * current 32-bit kernel code isn't too happy with icache != dcache
-	 * block size
+	 * block size. We also disable the BTAC as this can cause errors
+	 * in some circumstances (see IBM Erratum 47).
 	 */
 	mfspr	r3,SPRN_CCR0
 	oris	r3,r3,0x0020
+	ori	r3,r3,0x0040
 	mtspr	SPRN_CCR0,r3
 	isync
 
-- 
1.8.3.2
