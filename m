Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from firewall1 (wsip-70-167-241-26.dc.dc.cox.net [70.167.241.26])
	by ozlabs.org (Postfix) with ESMTP id 254B8B7109
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Aug 2010 05:15:51 +1000 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kvm/e500_tlb: Fix a minor copy-paste tracing bug
Date: Fri, 27 Aug 2010 15:06:45 -0400
Message-Id: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: linuxppc-dev@ozlabs.org, Kyle Moffett <kyle@moffetthome.net>,
	Liu Yu <yu.liu@freescale.com>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kvmppc_e500_stlbe_invalidate() function was trying to pass too many
parameters to trace_kvm_stlb_inval().  This appears to be a bad
copy-paste from a call to trace_kvm_stlb_write().

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
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
1.7.1
