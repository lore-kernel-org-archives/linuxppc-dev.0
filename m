Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9DC62C0330
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:23 +1100 (EST)
Received: from mail201-ch1 (localhost [127.0.0.1])	by
 mail201-ch1-R.bigfish.com (Postfix) with ESMTP id B461E180085	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:18 +0000 (UTC)
Received: from CH1EHSMHS006.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.230])	by mail201-ch1.bigfish.com (Postfix) with ESMTP id
 1008A3A00C1	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:17
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEBg8028133	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:12 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 06/12] KVM: PPC: Mask ea's high 32-bits in 32/64 instr
 emulation
Date: Thu, 11 Oct 2012 19:13:23 +0300
Message-ID: <1349972009-23027-7-git-send-email-mihai.caraman@freescale.com>
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

Mask high 32 bits of effective address in emulation layer for guests running
in 32-bit mode.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v1: added BOOK3S implementation.

 arch/powerpc/include/asm/kvm_ppc.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index a08e756..4a3fdbd 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -296,11 +296,21 @@ static inline void kvmppc_lazy_ee_enable(void)
 static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
 {
 	ulong ea;
+	ulong msr_64bit = 0;
 
 	ea = kvmppc_get_gpr(vcpu, rb);
 	if (ra)
 		ea += kvmppc_get_gpr(vcpu, ra);
 
+#if defined(CONFIG_PPC_BOOK3E_64)
+	msr_64bit = MSR_CM;
+#elif defined(CONFIG_PPC_BOOK3S_64)
+	msr_64bit = MSR_SF;
+#endif
+
+	if (!(vcpu->arch.shared->msr & msr_64bit))
+	    ea = (uint32_t)ea;
+
 	return ea;
 }
 
-- 
1.7.4.1
