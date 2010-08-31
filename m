Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25B3CB7139
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:21 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 07/35] KVM: PPC: Preload magic page when in kernel mode
Date: Tue, 31 Aug 2010 04:31:48 +0200
Message-Id: <1283221937-21006-8-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the guest jumps into kernel mode and has the magic page mapped, theres a
very high chance that it will also use it. So let's detect that scenario and
map the segment accordingly.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 37db61d..54ca578 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -145,6 +145,16 @@ void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 		   (old_msr & (MSR_PR|MSR_IR|MSR_DR))) {
 		kvmppc_mmu_flush_segments(vcpu);
 		kvmppc_mmu_map_segment(vcpu, kvmppc_get_pc(vcpu));
+
+		/* Preload magic page segment when in kernel mode */
+		if (!(msr & MSR_PR) && vcpu->arch.magic_page_pa) {
+			struct kvm_vcpu_arch *a = &vcpu->arch;
+
+			if (msr & MSR_DR)
+				kvmppc_mmu_map_segment(vcpu, a->magic_page_ea);
+			else
+				kvmppc_mmu_map_segment(vcpu, a->magic_page_pa);
+		}
 	}
 
 	/* Preload FPU if it's enabled */
-- 
1.6.0.2
