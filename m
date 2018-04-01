Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0093.hostedemail.com
 [216.40.44.93])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ddp46JchzF22N
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 01:00:38 +1000 (AEST)
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 14/16] powerpc: Switch to generic free_initrd_mem.
Date: Sun,  1 Apr 2018 10:59:28 -0400
Message-Id: <20180401145931.7932-14-shea@shealevy.com>
In-Reply-To: <20180401145931.7932-1-shea@shealevy.com>
References: <20180329113207.30674-1-shea@shealevy.com>
 <20180401145931.7932-1-shea@shealevy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first patch in this series added a weakly-defined generic
implementation, which is functionally identical to the
architecture-specific one removed here.

Series boot-tested on RISC-V (which now uses the generic
implementation) and x86_64 (which doesn't).

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
