Return-Path: <thomas@m3y3r.de>
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyF5V0jGnzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 08:38:37 +1000 (AEST)
Subject: [PATCH 6/7] KVM: PPC: Cocci spatch "vma_pages"
From: Thomas Meyer <thomas@m3y3r.de>
To: agraf@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-ID: <1505946334393-1459895492-6-diffsplit-thomas@m3y3r.de>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
Date: Thu, 21 Sep 2017 00:29:36 +0200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use vma_pages function on vma object instead of explicit computation.
Found by coccinelle spatch "api/vma_pages.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -377,7 +377,7 @@ static inline int kvmppc_e500_shadow_map
 
 			start = vma->vm_pgoff;
 			end = start +
-			      ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT);
+			      vma_pages(vma);
 
 			pfn = start + ((hva - vma->vm_start) >> PAGE_SHIFT);
 
