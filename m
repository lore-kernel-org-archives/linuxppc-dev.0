Return-Path: <Bharat.Bhushan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CAE4F1400B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 17:06:07 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] booke/powerpc: define wimge shift mask to fix compilation
 error
Date: Tue, 13 May 2014 12:18:22 +0530
Message-ID: <1399963702-29057-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes below compilation error on SOCs where CONFIG_PHYS_64BIT
is not defined:

 arch/powerpc/kvm/e500_mmu_host.c: In function 'kvmppc_e500_shadow_map':
| arch/powerpc/kvm/e500_mmu_host.c:631:20: error: 'PTE_WIMGE_SHIFT' undeclared (first use in this function)
|    wimg = (*ptep >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
|                     ^
| arch/powerpc/kvm/e500_mmu_host.c:631:20: note: each undeclared identifier is reported only once for each function it appears in
| make[1]: *** [arch/powerpc/kvm/e500_mmu_host.o] Error 1

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
---
 arch/powerpc/include/asm/pte-fsl-booke.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-fsl-booke.h b/arch/powerpc/include/asm/pte-fsl-booke.h
index 2c12be5..e84dd7e 100644
--- a/arch/powerpc/include/asm/pte-fsl-booke.h
+++ b/arch/powerpc/include/asm/pte-fsl-booke.h
@@ -37,5 +37,7 @@
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
 
+#define PTE_WIMGE_SHIFT (6)
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_PTE_FSL_BOOKE_H */
-- 
1.7.0.4
