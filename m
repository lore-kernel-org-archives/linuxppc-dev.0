Return-Path: <wenweitaowenwei@gmail.com>
Received: from mail-pd0-x243.google.com (mail-pd0-x243.google.com
 [IPv6:2607:f8b0:400e:c02::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAA231A0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:32:53 +1000 (AEST)
Received: by pdbht2 with SMTP id ht2so7464531pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2015 23:32:52 -0700 (PDT)
From: Wenwei Tao <wenweitaowenwei@gmail.com>
To: izik.eidus@ravellosystems.com, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, wenweitaowenwei@gmail.com
Subject: [RFC PATCH 5/6] x86/mm: change the condition of identifying hugetlb vm
Date: Wed, 10 Jun 2015 14:27:18 +0800
Message-Id: <1433917639-31699-6-git-send-email-wenweitaowenwei@gmail.com>
In-Reply-To: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
References: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hugetlb VMAs are not mergeable, that means a VMA couldn't have VM_HUGETLB and
VM_MERGEABLE been set in the same time. So we use VM_HUGETLB to indicate new
mergeable VMAs. Because of that a VMA which has VM_HUGETLB been set is a hugetlb
VMA only if it doesn't have VM_MERGEABLE been set in the same time.

Signed-off-by: Wenwei Tao <wenweitaowenwei@gmail.com>
---
 arch/x86/mm/tlb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 3250f23..0247916 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -195,7 +195,8 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 		goto out;
 	}
 
-	if ((end != TLB_FLUSH_ALL) && !(vmflag & VM_HUGETLB))
+	if ((end != TLB_FLUSH_ALL) &&
+		!((vmflag & (VM_HUGETLB | VM_MERGEABLE)) == VM_HUGETLB))
 		base_pages_to_flush = (end - start) >> PAGE_SHIFT;
 
 	if (base_pages_to_flush > tlb_single_page_flush_ceiling) {
-- 
1.7.9.5
