Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 417vV66DBwzF0dW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 23:00:46 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: wii: Remove outdated comment about memory fixups
Date: Sun, 17 Jun 2018 14:49:06 +0200
Message-Id: <20180617124909.26828-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The workaround has been removed. What stays is just code to find the
memory hole so the BATs can be configured properly in the function below.

Fixes: 57deb8fea01f ("powerpc/wii: Don't rely on the reserved memory hack")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index fc00d82691e1..a133b70bfe6f 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -68,16 +68,6 @@ void __init wii_memory_fixups(void)
 {
 	struct memblock_region *p = memblock.memory.regions;
 
-	/*
-	 * This is part of a workaround to allow the use of two
-	 * discontinuous RAM ranges on the Wii, even if this is
-	 * currently unsupported on 32-bit PowerPC Linux.
-	 *
-	 * We coalesce the two memory ranges of the Wii into a
-	 * single range, then create a reservation for the "hole"
-	 * between both ranges.
-	 */
-
 	BUG_ON(memblock.memory.cnt != 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
 
-- 
2.17.1
