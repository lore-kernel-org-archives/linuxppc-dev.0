Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D9D91A0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 01:50:41 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/4] KVM: PPC: Book3e: Add TLBSEL/TSIZE defines for MAS0/1
Date: Mon, 2 Jun 2014 18:50:14 +0300
Message-ID: <1401724216-26486-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1401724216-26486-1-git-send-email-mihai.caraman@freescale.com>
References: <1401724216-26486-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add mising defines MAS0_GET_TLBSEL() and MAS1_GET_TSIZE() for Book3E.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - no change

v2:
 - no change

 arch/powerpc/include/asm/mmu-book3e.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 901dac6..60a949a 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -40,7 +40,11 @@
 
 /* MAS registers bit definitions */
 
-#define MAS0_TLBSEL(x)		(((x) << 28) & 0x30000000)
+#define MAS0_TLBSEL_MASK	0x30000000
+#define MAS0_TLBSEL_SHIFT	28
+#define MAS0_TLBSEL(x)		(((x) << MAS0_TLBSEL_SHIFT) & MAS0_TLBSEL_MASK)
+#define MAS0_GET_TLBSEL(mas0)	(((mas0) & MAS0_TLBSEL_MASK) >> \
+			MAS0_TLBSEL_SHIFT)
 #define MAS0_ESEL_MASK		0x0FFF0000
 #define MAS0_ESEL_SHIFT		16
 #define MAS0_ESEL(x)		(((x) << MAS0_ESEL_SHIFT) & MAS0_ESEL_MASK)
@@ -58,6 +62,7 @@
 #define MAS1_TSIZE_MASK		0x00000f80
 #define MAS1_TSIZE_SHIFT	7
 #define MAS1_TSIZE(x)		(((x) << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
+#define MAS1_GET_TSIZE(mas1)	(((mas1) & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT)
 
 #define MAS2_EPN		(~0xFFFUL)
 #define MAS2_X0			0x00000040
-- 
1.7.11.7
