Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAEA6B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:49 +1000 (EST)
Received: from mail164-ch1 (localhost [127.0.0.1])	by
 mail164-ch1-R.bigfish.com (Postfix) with ESMTP id AC0A834037B	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:06 +0000 (UTC)
Received: from CH1EHSMHS007.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.243])	by mail164-ch1.bigfish.com (Postfix) with ESMTP id
 9F611A0240
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:04 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQdqo019303	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:40 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support in sregs
Date: Mon, 25 Jun 2012 15:26:21 +0300
Message-ID: <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
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

Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs
for 64-bit hosts.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f9fa260..d15c4b5 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1052,6 +1052,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
 	u64 tb = get_tb();
 
 	sregs->u.e.features |= KVM_SREGS_E_BASE;
+#ifdef CONFIG_64BIT
+	sregs->u.e.features |= KVM_SREGS_E_64;
+#endif
 
 	sregs->u.e.csrr0 = vcpu->arch.csrr0;
 	sregs->u.e.csrr1 = vcpu->arch.csrr1;
@@ -1063,6 +1066,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
 	sregs->u.e.dec = kvmppc_get_dec(vcpu, tb);
 	sregs->u.e.tb = tb;
 	sregs->u.e.vrsave = vcpu->arch.vrsave;
+#ifdef CONFIG_64BIT
+	sregs->u.e.epcr = vcpu->arch.epcr;
+#endif
 }
 
 static int set_sregs_base(struct kvm_vcpu *vcpu,
@@ -1071,6 +1077,11 @@ static int set_sregs_base(struct kvm_vcpu *vcpu,
 	if (!(sregs->u.e.features & KVM_SREGS_E_BASE))
 		return 0;
 
+#ifdef CONFIG_64BIT
+	if (!(sregs->u.e.features & KVM_SREGS_E_64))
+		return 0;
+#endif
+
 	vcpu->arch.csrr0 = sregs->u.e.csrr0;
 	vcpu->arch.csrr1 = sregs->u.e.csrr1;
 	vcpu->arch.mcsr = sregs->u.e.mcsr;
@@ -1078,6 +1089,9 @@ static int set_sregs_base(struct kvm_vcpu *vcpu,
 	set_guest_dear(vcpu, sregs->u.e.dear);
 	vcpu->arch.vrsave = sregs->u.e.vrsave;
 	kvmppc_set_tcr(vcpu, sregs->u.e.tcr);
+#ifdef CONFIG_64BIT
+	kvmppc_set_epcr(vcpu, sregs->u.e.epcr);
+#endif
 
 	if (sregs->u.e.update_special & KVM_SREGS_E_UPDATE_DEC) {
 		vcpu->arch.dec = sregs->u.e.dec;
-- 
1.7.4.1
