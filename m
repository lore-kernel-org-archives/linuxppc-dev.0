Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A1CAB7323
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:32:00 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 08/10] KVM: PPC: Stub emulate CFAR and PURR SPRs
Date: Tue,  9 Aug 2011 18:31:46 +0200
Message-Id: <1312907508-14599-9-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent Linux versions use the CFAR and PURR SPRs, but don't really care about
their contents (yet). So for now, we can simply return 0 when the guest wants
to read them.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_emulate.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index bf0ddcd..0c9dc62 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -473,6 +473,10 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 	case SPRN_HID5:
 		kvmppc_set_gpr(vcpu, rt, to_book3s(vcpu)->hid[5]);
 		break;
+	case SPRN_CFAR:
+	case SPRN_PURR:
+		kvmppc_set_gpr(vcpu, rt, 0);
+		break;
 	case SPRN_GQR0:
 	case SPRN_GQR1:
 	case SPRN_GQR2:
-- 
1.6.0.2
