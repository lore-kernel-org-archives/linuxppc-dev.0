Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DA03B6F8E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:31:55 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 04/10] KVM: PPC: Interpret SDR1 as HVA in PAPR mode
Date: Tue,  9 Aug 2011 18:31:42 +0200
Message-Id: <1312907508-14599-5-git-send-email-agraf@suse.de>
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

When running a PAPR guest, the guest is not allowed to set SDR1 - instead
the HTAB information is held in internal hypervisor structures. But all of
our current code relies on SDR1 and walking the HTAB like on real hardware.

So in order to not be too intrusive, we simply set SDR1 to the HTAB we hold
in host memory. That way we can keep the HTAB in user space, but use it from
kernel space to map the guest.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_64_mmu.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index c6d3e19..b871721 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -128,7 +128,13 @@ static hva_t kvmppc_mmu_book3s_64_get_pteg(
 	dprintk("MMU: page=0x%x sdr1=0x%llx pteg=0x%llx vsid=0x%llx\n",
 		page, vcpu_book3s->sdr1, pteg, slbe->vsid);
 
-	r = gfn_to_hva(vcpu_book3s->vcpu.kvm, pteg >> PAGE_SHIFT);
+	/* When running a PAPR guest, SDR1 contains a HVA address instead
+           of a GPA */
+	if (vcpu_book3s->vcpu.arch.papr_enabled)
+		r = pteg;
+	else
+		r = gfn_to_hva(vcpu_book3s->vcpu.kvm, pteg >> PAGE_SHIFT);
+
 	if (kvm_is_error_hva(r))
 		return r;
 	return r | (pteg & ~PAGE_MASK);
-- 
1.6.0.2
