Return-Path: <xerofoify@gmail.com>
Received: from mail-io0-x232.google.com (mail-io0-x232.google.com
 [IPv6:2607:f8b0:4001:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53FA41A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 01:27:38 +1000 (AEST)
Received: by ioii16 with SMTP id i16so172785187ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 08:27:35 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: gleb@kernel.org
Cc: pbonzini@redhat.com, agraf@suse.com, benh@kernel.crashing.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm:powerpc:Fix return statements for wrapper functions in
 the file book3s_64_mmu_hv.c
Date: Mon, 10 Aug 2015 11:27:31 -0400
Message-Id: <1439220451-26094-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the wrapper functions kvm_umap_hva_hv and the function
kvm_unmap_hav_range_hv to return the return value of the function
kvm_handle_hva or kvm_handle_hva_range that they are wrapped to
call internally rather then always making the caller of these
wrapper functions think they always run successfully by returning
the value of zero directly.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index dab68b7..0905c8f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -774,14 +774,12 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 
 int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva)
 {
-	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
-	return 0;
+	return kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
 }
 
 int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long start, unsigned long end)
 {
-	kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);
-	return 0;
+	return kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);
 }
 
 void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
-- 
2.1.4
