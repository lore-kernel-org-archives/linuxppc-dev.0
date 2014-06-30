Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A1711A001C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 22:55:11 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH] KVM: PPC: e500: Fix default tlb for victim hint
Date: Mon, 30 Jun 2014 15:54:58 +0300
Message-ID: <1404132898-27261-1-git-send-email-mihai.caraman@freescale.com>
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

Tlb search operation used for victim hint relies on the default tlb set by the
host. When hardware tablewalk support is enabled in the host, the default tlb is
TLB1 which leads KVM to evict the bolted entry. Set and restore the default tlb
when searching for victim hint.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/mmu-book3e.h | 5 ++++-
 arch/powerpc/kvm/e500_mmu_host.c      | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 901dac6..5dad378 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -40,7 +40,9 @@
 
 /* MAS registers bit definitions */
 
-#define MAS0_TLBSEL(x)		(((x) << 28) & 0x30000000)
+#define MAS0_TLBSEL_MASK        0x30000000
+#define MAS0_TLBSEL_SHIFT       28
+#define MAS0_TLBSEL(x)          (((x) << MAS0_TLBSEL_SHIFT) & MAS0_TLBSEL_MASK)
 #define MAS0_ESEL_MASK		0x0FFF0000
 #define MAS0_ESEL_SHIFT		16
 #define MAS0_ESEL(x)		(((x) << MAS0_ESEL_SHIFT) & MAS0_ESEL_MASK)
@@ -86,6 +88,7 @@
 #define MAS3_SPSIZE		0x0000003e
 #define MAS3_SPSIZE_SHIFT	1
 
+#define MAS4_TLBSEL_MASK	MAS0_TLBSEL_MASK
 #define MAS4_TLBSELD(x) 	MAS0_TLBSEL(x)
 #define MAS4_INDD		0x00008000	/* Default IND */
 #define MAS4_TSIZED(x)		MAS1_TSIZE(x)
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index dd2cc03..79677d7 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -107,11 +107,15 @@ static u32 get_host_mas0(unsigned long eaddr)
 {
 	unsigned long flags;
 	u32 mas0;
+	u32 mas4;
 
 	local_irq_save(flags);
 	mtspr(SPRN_MAS6, 0);
+	mas4 = mfspr(SPRN_MAS4);
+	mtspr(SPRN_MAS4, mas4 & ~MAS4_TLBSEL_MASK);
 	asm volatile("tlbsx 0, %0" : : "b" (eaddr & ~CONFIG_PAGE_OFFSET));
 	mas0 = mfspr(SPRN_MAS0);
+	mtspr(SPRN_MAS4, mas4);
 	local_irq_restore(flags);
 
 	return mas0;
-- 
1.7.11.7
