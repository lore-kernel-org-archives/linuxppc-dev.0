Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8BCE100847
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:56 +1000 (EST)
Received: from mail254-ch1 (localhost [127.0.0.1])	by
 mail254-ch1-R.bigfish.com (Postfix) with ESMTP id 9352ED801AF	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:14 +0000 (UTC)
Received: from CH1EHSMHS017.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.252])	by mail254-ch1.bigfish.com (Postfix) with ESMTP id
 60FC3B00049	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:10
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQj1d019385	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:45 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 07/17] KVM: PPC: e500: Mask ea's high 32-bits in 32/64
 instr emulation
Date: Mon, 25 Jun 2012 15:26:25 +0300
Message-ID: <1340627195-11544-8-git-send-email-mihai.caraman@freescale.com>
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

Mask high 32 bits of effective address in emulation layer, for guests running
in 32-bit mode.
MAS2's high-order 32 bits represents the upper 32 bits of the effective address
of the page. Mask it too for tlbwe instruction emulation.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500_emulate.c |    5 ++++-
 arch/powerpc/kvm/e500_tlb.c     |    2 ++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 81288f7..94305db 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008-2011 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2008-2012 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Yu Liu, <yu.liu@freescale.com>
  *
@@ -90,6 +90,9 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
 	if (ra)
 		ea += kvmppc_get_gpr(vcpu, ra);
 
+	if (!(vcpu->arch.shared->msr & MSR_CM))
+		ea &= 0xffffffffUL;
+
 	return ea;
 }
 
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 2175a58..3ed4e7d 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -862,6 +862,8 @@ int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu)
 
 	gtlbe->mas1 = vcpu->arch.shared->mas1;
 	gtlbe->mas2 = vcpu->arch.shared->mas2;
+	if (!(vcpu->arch.shared->msr & MSR_CM))
+		gtlbe->mas2 &= 0xffffffffUL;
 	gtlbe->mas7_3 = vcpu->arch.shared->mas7_3;
 
 	trace_kvm_booke206_gtlb_write(vcpu->arch.shared->mas0, gtlbe->mas1,
-- 
1.7.4.1
