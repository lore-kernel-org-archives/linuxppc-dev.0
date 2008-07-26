Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27940DDEDC
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 03:57:34 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6QHvUGo002478
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 12:57:31 -0500
Date: Sat, 26 Jul 2008 12:57:30 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix 8xx build failure
Message-ID: <Pine.LNX.4.64.0807261256430.21570@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 'powerpc ioremap_prot' broke 8xx builds:

include2/asm/pgtable-ppc32.h:555: error: '_PAGE_WRITETHRU' undeclared (first use in this function)
include2/asm/pgtable-ppc32.h:555: error: (Each undeclared identifier is reported only once
include2/asm/pgtable-ppc32.h:555: error: for each function it appears in.)

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

in my powerpc-next tree.

- k

 include/asm-powerpc/pgtable-ppc32.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index bdbab72..6fe39e3 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -401,6 +401,9 @@ extern int icache_44x_need_flush;
 #ifndef _PAGE_COHERENT
 #define _PAGE_COHERENT	0
 #endif
+#ifndef _PAGE_WRITETHRU
+#define _PAGE_WRITETHRU	0
+#endif
 #ifndef _PMD_PRESENT_MASK
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
 #endif
-- 
1.5.5.1
