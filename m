Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E6B2B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:49 +1000 (EST)
Received: from mail216-co1 (localhost [127.0.0.1])	by
 mail216-co1-R.bigfish.com (Postfix) with ESMTP id 9BEE58C0062	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:07 +0000 (UTC)
Received: from CO1EHSMHS012.bigfish.com (unknown [10.243.78.249])	by
 mail216-co1.bigfish.com (Postfix) with ESMTP id 7A81B800044	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:04 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQdHR019306	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:40 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 05/17] KVM: PPC: booke: Extend MAS2 EPN mask for 64-bit
Date: Mon, 25 Jun 2012 15:26:23 +0300
Message-ID: <1340627195-11544-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extend MAS2 EPN mask for 64-bit hosts, to retain most significant bits.
Change get tlb eaddr to use this mask.

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
index aa8b814..3e31098 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -155,7 +155,7 @@ get_tlb_size(const struct kvm_book3e_206_tlb_entry *tlbe)
 
 static inline gva_t get_tlb_eaddr(const struct kvm_book3e_206_tlb_entry *tlbe)
 {
-	return tlbe->mas2 & 0xfffff000;
+	return tlbe->mas2 & MAS2_EPN;
 }
 
 static inline u64 get_tlb_bytes(const struct kvm_book3e_206_tlb_entry *tlbe)
-- 
1.7.4.1
