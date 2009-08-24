Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7854AB7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 02:15:43 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF1B7DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 02:15:42 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n7OGFaa7031216
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 11:15:37 -0500
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Name xpn & x fields in HW pte format
Date: Mon, 24 Aug 2009 11:15:36 -0500
Message-Id: <1251130536-12953-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, the 36-bit code was using these bits, but they had
never been named in the pte format definition.  This patch just
gives those fields their proper names and adds a comment that
they are only present on some processors.

There is no functional code change.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu-hash32.h |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash32.h b/arch/powerpc/include/asm/mmu-hash32.h
index 382fc68..16f513e 100644
--- a/arch/powerpc/include/asm/mmu-hash32.h
+++ b/arch/powerpc/include/asm/mmu-hash32.h
@@ -55,21 +55,25 @@ struct ppc_bat {
 
 #ifndef __ASSEMBLY__
 
-/* Hardware Page Table Entry */
+/*
+ * Hardware Page Table Entry
+ * Note that the xpn and x bitfields are used only by processors that
+ * support extended addressing; otherwise, those bits are reserved.
+ */
 struct hash_pte {
 	unsigned long v:1;	/* Entry is valid */
 	unsigned long vsid:24;	/* Virtual segment identifier */
 	unsigned long h:1;	/* Hash algorithm indicator */
 	unsigned long api:6;	/* Abbreviated page index */
 	unsigned long rpn:20;	/* Real (physical) page number */
-	unsigned long    :3;	/* Unused */
+	unsigned long xpn:3;	/* Real page number bits 0-2, optional */
 	unsigned long r:1;	/* Referenced */
 	unsigned long c:1;	/* Changed */
 	unsigned long w:1;	/* Write-thru cache mode */
 	unsigned long i:1;	/* Cache inhibited */
 	unsigned long m:1;	/* Memory coherence */
 	unsigned long g:1;	/* Guarded */
-	unsigned long  :1;	/* Unused */
+	unsigned long x:1;	/* Real page number bit 3, optional */
 	unsigned long pp:2;	/* Page protection */
 };
 
-- 
1.6.0.6
