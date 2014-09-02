Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437D61A0027
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Sep 2014 02:13:34 +1000 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 2 Sep 2014 17:13:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 774FD2190061
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 17:13:06 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s82GDPTG43384840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Sep 2014 16:13:25 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s82GDOkQ027666
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Sep 2014 10:13:24 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kvm/cma: Fix panic introduces by signed shift
 operation
Date: Tue,  2 Sep 2014 18:13:01 +0200
Message-Id: <1409674381-29465-1-git-send-email-ldufour@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, pbonzini@redhat.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fc95ca7284bc54953165cba76c3228bd2cdb9591 introduces a memset in
kvmppc_alloc_hpt since the general CMA doesn't clear the memory it
allocates.

However, the size argument passed to memset is computed from a signed value
and its signed bit is extended by the cast the compiler is doing. This lead
to extremely large size value when dealing with order value >= 31, and
almost all the memory following the allocated space is cleaned. As a
consequence, the system is panicing and may even fail spawning the kdump
kernel.

This fix makes use of an unsigned value for the memset's size argument to
avoid sign extension. Among this fix, another shift operation which may
lead to signed extended value too is also fixed.

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 72c20bb16d26..79294c4c5015 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -62,10 +62,10 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 	}
 
 	kvm->arch.hpt_cma_alloc = 0;
-	page = kvm_alloc_hpt(1 << (order - PAGE_SHIFT));
+	page = kvm_alloc_hpt(1ul << (order - PAGE_SHIFT));
 	if (page) {
 		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
-		memset((void *)hpt, 0, (1 << order));
+		memset((void *)hpt, 0, (1ul << order));
 		kvm->arch.hpt_cma_alloc = 1;
 	}
 
-- 
1.9.1
