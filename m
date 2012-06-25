Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F13751008AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:27:14 +1000 (EST)
Received: from mail90-db3 (localhost [127.0.0.1])	by mail90-db3-R.bigfish.com
 (Postfix) with ESMTP id EA6FD3003C8	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 25 Jun 2012 12:25:31 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.234])	by
 mail90-db3.bigfish.com (Postfix) with ESMTP id CEAA72E0074	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:05 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQdn6003893	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:40 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 08/17] KVM: PPC: e500mc: Fix tlbilx emulation for 64-bit
 guests
Date: Mon, 25 Jun 2012 15:26:26 +0300
Message-ID: <1340627195-11544-9-git-send-email-mihai.caraman@freescale.com>
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

tlbilxva emulation was using an u32 variable for guest effective address.
Replace it with gva_t type to handle 64-bit guests.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500mc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index db97ee3..1f89d26 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -57,7 +57,8 @@ void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
 			   struct kvm_book3e_206_tlb_entry *gtlbe)
 {
 	unsigned int tid, ts;
-	u32 val, eaddr, lpid;
+	gva_t eaddr;
+	u32 val, lpid;
 	unsigned long flags;
 
 	ts = get_tlb_ts(gtlbe);
-- 
1.7.4.1
