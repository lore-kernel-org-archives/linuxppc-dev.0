Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 5945EB717C
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 33/35] KVM: PPC: e500_tlb: Fix a minor copy-paste tracing bug
Date: Tue, 31 Aug 2010 04:32:14 +0200
Message-Id: <1283221937-21006-34-git-send-email-agraf@suse.de>
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

From: Kyle Moffett <Kyle.D.Moffett@boeing.com>

The kvmppc_e500_stlbe_invalidate() function was trying to pass too many
parameters to trace_kvm_stlb_inval().  This appears to be a bad
copy-paste from a call to trace_kvm_stlb_write().

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/e500_tlb.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 66845a5..a413883 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -226,11 +226,7 @@ static void kvmppc_e500_stlbe_invalidate(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	kvmppc_e500_shadow_release(vcpu_e500, tlbsel, esel);
 	stlbe->mas1 = 0;
-	/* XXX doesn't compile */
-#if 0
-	trace_kvm_stlb_inval(index_of(tlbsel, esel), stlbe->mas1, stlbe->mas2,
-			     stlbe->mas3, stlbe->mas7);
-#endif
+	trace_kvm_stlb_inval(index_of(tlbsel, esel));
 }
 
 static void kvmppc_e500_tlb1_invalidate(struct kvmppc_vcpu_e500 *vcpu_e500,
-- 
1.6.0.2
