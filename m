Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD4D82C0364
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:23 +1100 (EST)
Received: from mail248-ch1 (localhost [127.0.0.1])	by
 mail248-ch1-R.bigfish.com (Postfix) with ESMTP id 081D02A01CE	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:19 +0000 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.251])	by mail248-ch1.bigfish.com (Postfix) with ESMTP id
 C061C580046	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:16
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEBm6003744	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:12 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 07/12] KVM: PPC: e500: Mask MAS2 EPN high 32-bits in 32/64
 tlbwe emulation
Date: Thu, 11 Oct 2012 19:13:24 +0300
Message-ID: <1349972009-23027-8-git-send-email-mihai.caraman@freescale.com>
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

Mask high 32 bits of MAS2's effective page number in tlbwe emulation for guests
running in 32-bit mode.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v1: patch splited.

 arch/powerpc/kvm/e500_tlb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index b5a188a..6c0997e 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -871,6 +871,8 @@ int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu)
 
 	gtlbe->mas1 = vcpu->arch.shared->mas1;
 	gtlbe->mas2 = vcpu->arch.shared->mas2;
+	if (!(vcpu->arch.shared->msr & MSR_CM))
+		gtlbe->mas2 &= 0xffffffffUL;
 	gtlbe->mas7_3 = vcpu->arch.shared->mas7_3;
 
 	trace_kvm_booke206_gtlb_write(vcpu->arch.shared->mas0, gtlbe->mas1,
-- 
1.7.4.1
