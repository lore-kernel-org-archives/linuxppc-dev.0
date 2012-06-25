Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9B7E100806
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:59 +1000 (EST)
Received: from mail22-db3 (localhost [127.0.0.1])	by mail22-db3-R.bigfish.com
 (Postfix) with ESMTP id B39D24403AC	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 25 Jun 2012 12:25:18 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.227])	by
 mail22-db3.bigfish.com (Postfix) with ESMTP id A6D93100057	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:04 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQdeu019296	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:39 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 01/17] KVM: PPC64: booke: Set interrupt computation mode
 for 64-bit host
Date: Mon, 25 Jun 2012 15:26:19 +0300
Message-ID: <1340627195-11544-2-git-send-email-mihai.caraman@freescale.com>
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

64-bit host needs to remain in 64-bit mode when an exception take place.
Set interrupt computaion mode in EPCR register.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500mc.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index fe6c1de..db97ee3 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2010,2012 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Varun Sethi, <varun.sethi@freescale.com>
  *
@@ -183,6 +183,9 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.shadow_epcr = SPRN_EPCR_DSIGS | SPRN_EPCR_DGTMI | \
 				 SPRN_EPCR_DUVD;
+#ifdef CONFIG_64BIT
+	vcpu->arch.shadow_epcr |= SPRN_EPCR_ICM;
+#endif
 	vcpu->arch.shadow_msrp = MSRP_UCLEP | MSRP_DEP | MSRP_PMMP;
 	vcpu->arch.eplc = EPC_EGS | (vcpu->kvm->arch.lpid << EPC_ELPID_SHIFT);
 	vcpu->arch.epsc = vcpu->arch.eplc;
-- 
1.7.4.1
