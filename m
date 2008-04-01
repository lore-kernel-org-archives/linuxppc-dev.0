Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF5CDDDFBD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 12:12:43 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 07/11] [POWERPC] Use lowmem_end_addr to limit lmb allocations
	on ppc32
Date: Mon, 31 Mar 2008 21:08:31 -0500
Message-Id: <1207015715-31496-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1207015715-31496-7-git-send-email-galak@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-3-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-4-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-5-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-6-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-7-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
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
