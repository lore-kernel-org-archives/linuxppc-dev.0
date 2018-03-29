Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0022.hostedemail.com
 [216.40.44.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BjL56GmXzDr4t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 22:33:16 +1100 (AEDT)
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 14/16] powerpc: Switch to generic free_initrd_mem.
Date: Thu, 29 Mar 2018 07:32:05 -0400
Message-Id: <20180329113207.30674-14-shea@shealevy.com>
In-Reply-To: <20180329113207.30674-1-shea@shealevy.com>
References: <20180328203659.18692-1-shea@shealevy.com>
 <20180329113207.30674-1-shea@shealevy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic implementation is functionally identical.

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/powerpc/mm/mem.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index fe8c61149fb8..e85b2a3cd264 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -404,13 +404,6 @@ void free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 /*
  * This is called when a page has been modified by the kernel.
  * It just marks the page as not i-cache clean.  We do the i-cache
-- 
2.16.2
