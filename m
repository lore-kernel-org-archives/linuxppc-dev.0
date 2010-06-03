Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F1476B7D2E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 15:52:37 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>,
	Kumar Gala <galak@kernel.crashing.org>, Avi Kivity <avi@redhat.com>,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH] kvm/powerpc: fix a build error in e500_tlb.c
Date: Thu,  3 Jun 2010 13:52:28 +0800
Message-Id: <1275544348-3469-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use the wrong number arguments when invoking trace_kvm_stlb_inval,
and cause the following build error.
arch/powerpc/kvm/e500_tlb.c: In function 'kvmppc_e500_stlbe_invalidate':
arch/powerpc/kvm/e500_tlb.c:230: error: too many arguments to function 'trace_kvm_stlb_inval'

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kvm/e500_tlb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 21011e1..1261a21 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -226,8 +226,7 @@ static void kvmppc_e500_stlbe_invalidate(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	kvmppc_e500_shadow_release(vcpu_e500, tlbsel, esel);
 	stlbe->mas1 = 0;
-	trace_kvm_stlb_inval(index_of(tlbsel, esel), stlbe->mas1, stlbe->mas2,
-			     stlbe->mas3, stlbe->mas7);
+	trace_kvm_stlb_inval(index_of(tlbsel, esel));
 }
 
 static void kvmppc_e500_tlb1_invalidate(struct kvmppc_vcpu_e500 *vcpu_e500,
-- 
1.6.3.1
