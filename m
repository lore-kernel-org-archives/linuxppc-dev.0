Return-Path: <kernelfans@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0D4D1A032A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 16:05:36 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id eu11so9817799pac.18
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jul 2014 23:05:34 -0700 (PDT)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH] powerpc: kvm: make the setup of hpte under the protection of
 KVMPPC_RMAP_LOCK_BIT
Date: Mon, 28 Jul 2014 14:09:04 +0800
Message-Id: <1406527744-25316-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In current code, the setup of hpte is under the risk of race with
mmu_notifier_invalidate, i.e we may setup a hpte with a invalid pfn.
Resolve this issue by sync the two actions by KVMPPC_RMAP_LOCK_BIT.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 8056107..e6dcff4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -754,19 +754,24 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	if (hptep[0] & HPTE_V_VALID) {
 		/* HPTE was previously valid, so we need to invalidate it */
-		unlock_rmap(rmap);
 		hptep[0] |= HPTE_V_ABSENT;
 		kvmppc_invalidate_hpte(kvm, hptep, index);
 		/* don't lose previous R and C bits */
 		r |= hptep[1] & (HPTE_R_R | HPTE_R_C);
+
+		hptep[1] = r;
+		eieio();
+		hptep[0] = hpte[0];
+		asm volatile("ptesync" : : : "memory");
+		unlock_rmap(rmap);
 	} else {
+		hptep[1] = r;
+		eieio();
+		hptep[0] = hpte[0];
+		asm volatile("ptesync" : : : "memory");
 		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
 	}
 
-	hptep[1] = r;
-	eieio();
-	hptep[0] = hpte[0];
-	asm volatile("ptesync" : : : "memory");
 	preempt_enable();
 	if (page && hpte_is_writable(r))
 		SetPageDirty(page);
-- 
1.8.1.4
