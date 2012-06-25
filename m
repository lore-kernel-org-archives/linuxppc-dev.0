Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2B63B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:50 +1000 (EST)
Received: from mail144-ch1 (localhost [127.0.0.1])	by
 mail144-ch1-R.bigfish.com (Postfix) with ESMTP id 41CB4E0213	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:08 +0000 (UTC)
Received: from CH1EHSMHS003.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail144-ch1.bigfish.com (Postfix) with ESMTP id
 39135400045	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:06
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQfms003916	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:42 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 16/17] KVM: PPC: e500: Silence bogus GCC warning in tlb
 code
Date: Mon, 25 Jun 2012 15:26:34 +0300
Message-ID: <1340627195-11544-17-git-send-email-mihai.caraman@freescale.com>
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

64-bit GCC 4.5.1 warns about an uninitialized variable which was guarded
by a flag. Initialize the variable to make it happy.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500_tlb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 3ed4e7d..6286fbd 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -412,7 +412,8 @@ static inline void kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	struct tlbe_ref *ref)
 {
 	struct kvm_memory_slot *slot;
-	unsigned long pfn, hva;
+	unsigned long pfn = 0; /* shut up 64-bit GCC */
+	unsigned long hva;
 	int pfnmap = 0;
 	int tsize = BOOK3E_PAGESZ_4K;
 
-- 
1.7.4.1
