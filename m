Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD1722C0319
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:21 +1100 (EST)
Received: from mail134-co1 (localhost [127.0.0.1])	by
 mail134-co1-R.bigfish.com (Postfix) with ESMTP id A52D5A60073	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:16 +0000 (UTC)
Received: from CO1EHSMHS009.bigfish.com (unknown [10.243.78.244])	by
 mail134-co1.bigfish.com (Postfix) with ESMTP id A8D00D4004F	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:14 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEBEj003739	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:11 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 08/12] KVM: PPC: booke: Extend MAS2 EPN mask for 64-bit
Date: Thu, 11 Oct 2012 19:13:25 +0300
Message-ID: <1349972009-23027-9-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
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

Extend MAS2 EPN mask to retain most significant bits on 64-bit hosts.
Use this mask in tlb effective address accessor.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/mmu-book3e.h |    2 +-
 arch/powerpc/kvm/e500.h               |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index eeabcdb..99d43e0 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -59,7 +59,7 @@
 #define MAS1_TSIZE_SHIFT	7
 #define MAS1_TSIZE(x)		(((x) << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
 
-#define MAS2_EPN		0xFFFFF000
+#define MAS2_EPN		(~0xFFFUL)
 #define MAS2_X0			0x00000040
 #define MAS2_X1			0x00000020
 #define MAS2_W			0x00000010
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 32e98a7..c70d37e 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -154,7 +154,7 @@ get_tlb_size(const struct kvm_book3e_206_tlb_entry *tlbe)
 
 static inline gva_t get_tlb_eaddr(const struct kvm_book3e_206_tlb_entry *tlbe)
 {
-	return tlbe->mas2 & 0xfffff000;
+	return tlbe->mas2 & MAS2_EPN;
 }
 
 static inline u64 get_tlb_bytes(const struct kvm_book3e_206_tlb_entry *tlbe)
-- 
1.7.4.1
