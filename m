Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98A2EDE173
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 09:48:09 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m2QMm4uQ019534
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 17:48:05 -0500
Date: Wed, 26 Mar 2008 17:44:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Use lowmem_end_addr to limit lmb allocations on
	ppc32
Message-ID: <Pine.LNX.4.64.0803261743540.29631@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we have a proper variable that is the address of the top
of low memory we can use it to limit the lmb allocations.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-powerpc/lmb.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/lmb.h b/include/asm-powerpc/lmb.h
index 028184b..6f5fdf0 100644
--- a/include/asm-powerpc/lmb.h
+++ b/include/asm-powerpc/lmb.h
@@ -6,8 +6,8 @@
 #define LMB_DBG(fmt...) udbg_printf(fmt)

 #ifdef CONFIG_PPC32
-extern unsigned long __max_low_memory;
-#define LMB_REAL_LIMIT	__max_low_memory
+extern phys_addr_t lowmem_end_addr;
+#define LMB_REAL_LIMIT	lowmem_end_addr
 #else
 #define LMB_REAL_LIMIT	0
 #endif
-- 
1.5.4.1
