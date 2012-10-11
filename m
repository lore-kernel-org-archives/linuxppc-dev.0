Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D60A82C03EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:29 +1100 (EST)
Received: from mail29-va3 (localhost [127.0.0.1])	by mail29-va3-R.bigfish.com
 (Postfix) with ESMTP id F3DC32400AF	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 11 Oct 2012 16:14:24 +0000 (UTC)
Received: from VA3EHSMHS008.bigfish.com (unknown [10.7.14.251])	by
 mail29-va3.bigfish.com (Postfix) with ESMTP id 03275340054	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:24 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEC6s028142	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:13 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 11/12] KVM: PPC: booke: Add EPCR support in sregs
Date: Thu, 11 Oct 2012 19:13:28 +0300
Message-ID: <1349972009-23027-12-git-send-email-mihai.caraman@freescale.com>
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

Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs for 64-bit
hosts.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index e6159f5..d396374 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1215,6 +1215,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
 	u64 tb = get_tb();
 
 	sregs->u.e.features |= KVM_SREGS_E_BASE;
+#ifdef CONFIG_64BIT
+	sregs->u.e.features |= KVM_SREGS_E_64;
+#endif
 
 	sregs->u.e.csrr0 = vcpu->arch.csrr0;
 	sregs->u.e.csrr1 = vcpu->arch.csrr1;
@@ -1226,6 +1229,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
 	sregs->u.e.dec = kvmppc_get_dec(vcpu, tb);
 	sregs->u.e.tb = tb;
 	sregs->u.e.vrsave = vcpu->arch.vrsave;
+#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
+	sregs->u.e.epcr = vcpu->arch.epcr;
+#endif
 }
 
 static int set_sregs_base(struct kvm_vcpu *vcpu,
@@ -1241,6 +1247,7 @@ static int set_sregs_base(struct kvm_vcpu *vcpu,
 	set_guest_dear(vcpu, sregs->u.e.dear);
 	vcpu->arch.vrsave = sregs->u.e.vrsave;
 	kvmppc_set_tcr(vcpu, sregs->u.e.tcr);
+	kvmppc_set_epcr(vcpu, sregs->u.e.epcr);
 
 	if (sregs->u.e.update_special & KVM_SREGS_E_UPDATE_DEC) {
 		vcpu->arch.dec = sregs->u.e.dec;
-- 
1.7.4.1
