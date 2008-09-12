Return-Path: <bgill@blarg.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97863DDEF8
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 06:53:50 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8CKrjBB007990
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 13:53:45 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m8CKriMO021850
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 15:53:45 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] POWERPC: Make dma_addr_t a u64 if CONFIG_PHYS_64BIT is set
Date: Fri, 12 Sep 2008 15:53:43 -0500
Message-Id: <1221252823-6291-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/include/asm/types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index d3374bc..a9a9262 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -55,7 +55,7 @@ typedef u64 phys_addr_t;
 typedef u32 phys_addr_t;
 #endif
 
-#ifdef __powerpc64__
+#if defined(__powerpc64__) || defined(CONFIG_PHYS_64BIT)
 typedef u64 dma_addr_t;
 #else
 typedef u32 dma_addr_t;
-- 
1.5.5.1
