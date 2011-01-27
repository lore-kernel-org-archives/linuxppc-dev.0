Return-Path: <scottwood@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D49C8B7106
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2011 07:30:12 +1100 (EST)
Date: Thu, 27 Jan 2011 14:30:00 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/book3e: protect complex macro args in mmu-book3e.h
	with parens
Message-ID: <20110127203000.GB30913@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Ran into trouble with this when working on some KVM code.

 arch/powerpc/include/asm/mmu-book3e.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 8eaed81..17194fc 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -40,8 +40,8 @@
 
 /* MAS registers bit definitions */
 
-#define MAS0_TLBSEL(x)		((x << 28) & 0x30000000)
-#define MAS0_ESEL(x)		((x << 16) & 0x0FFF0000)
+#define MAS0_TLBSEL(x)		(((x) << 28) & 0x30000000)
+#define MAS0_ESEL(x)		(((x) << 16) & 0x0FFF0000)
 #define MAS0_NV(x)		((x) & 0x00000FFF)
 #define MAS0_HES		0x00004000
 #define MAS0_WQ_ALLWAYS		0x00000000
@@ -50,12 +50,12 @@
 
 #define MAS1_VALID		0x80000000
 #define MAS1_IPROT		0x40000000
-#define MAS1_TID(x)		((x << 16) & 0x3FFF0000)
+#define MAS1_TID(x)		(((x) << 16) & 0x3FFF0000)
 #define MAS1_IND		0x00002000
 #define MAS1_TS			0x00001000
 #define MAS1_TSIZE_MASK		0x00000f80
 #define MAS1_TSIZE_SHIFT	7
-#define MAS1_TSIZE(x)		((x << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
+#define MAS1_TSIZE(x)		(((x) << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
 
 #define MAS2_EPN		0xFFFFF000
 #define MAS2_X0			0x00000040
-- 
1.7.0.4
