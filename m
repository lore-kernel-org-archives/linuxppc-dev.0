Return-Path: <wenweitaowenwei@gmail.com>
Received: from mail-pd0-x241.google.com (mail-pd0-x241.google.com
 [IPv6:2607:f8b0:400e:c02::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0ABC41A0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:32:39 +1000 (AEST)
Received: by pdbht2 with SMTP id ht2so7464060pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2015 23:32:37 -0700 (PDT)
From: Wenwei Tao <wenweitaowenwei@gmail.com>
To: izik.eidus@ravellosystems.com, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, wenweitaowenwei@gmail.com
Subject: [RFC PATCH 3/6] perf: change the condition of identifying hugetlb vm
Date: Wed, 10 Jun 2015 14:27:16 +0800
Message-Id: <1433917639-31699-4-git-send-email-wenweitaowenwei@gmail.com>
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
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f04daab..6313bdd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5624,7 +5624,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 			flags |= MAP_EXECUTABLE;
 		if (vma->vm_flags & VM_LOCKED)
 			flags |= MAP_LOCKED;
-		if (vma->vm_flags & VM_HUGETLB)
+		if ((vma->vm_flags & (VM_HUGETLB | VM_MERGEABLE)) == VM_HUGETLB)
 			flags |= MAP_HUGETLB;
 
 		goto got_name;
-- 
1.7.9.5
