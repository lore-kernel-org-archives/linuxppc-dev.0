Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from firewall1 (wsip-70-167-241-26.dc.dc.cox.net [70.167.241.26])
	by ozlabs.org (Postfix) with ESMTP id A75F4B70E7
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 01:39:00 +1000 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kvm/e500_tlb: Fix a minor copy-paste tracing bug
Date: Mon, 30 Aug 2010 11:38:39 -0400
Message-Id: <1283182719-4621-1-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
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
Alex,

This is the rebased patch to re-enable the tracepoint.

I also pushed a tree with this patch on top of kvm-ppc-next out to:
  git://opensource.exmeritus.com/hww-1u-1a/linux.git kvm-ppc-patches
  http://opensource.exmeritus.com/git/hww-1u-1a/linux.git/kvm-ppc-patches

Thanks again!

Cheers,
Kyle Moffett

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
1.7.1
