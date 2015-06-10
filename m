Return-Path: <wenweitaowenwei@gmail.com>
Received: from mail-pd0-x244.google.com (mail-pd0-x244.google.com
 [IPv6:2607:f8b0:400e:c02::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 602E21A0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:32:47 +1000 (AEST)
Received: by pdbht2 with SMTP id ht2so7464300pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2015 23:32:44 -0700 (PDT)
From: Wenwei Tao <wenweitaowenwei@gmail.com>
To: izik.eidus@ravellosystems.com, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, wenweitaowenwei@gmail.com
Subject: [RFC PATCH 4/6] fs/binfmt_elf.c: change the condition of identifying
 hugetlb vm
Date: Wed, 10 Jun 2015 14:27:17 +0800
Message-Id: <1433917639-31699-5-git-send-email-wenweitaowenwei@gmail.com>
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
 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 995986b..f529c8e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1242,7 +1242,7 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 		return 0;
 
 	/* Hugetlb memory check */
-	if (vma->vm_flags & VM_HUGETLB) {
+	if ((vma->vm_flags & (VM_HUGETLB | VM_MERGEABLE)) == VM_HUGETLB) {
 		if ((vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_SHARED))
 			goto whole;
 		if (!(vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_PRIVATE))
-- 
1.7.9.5
