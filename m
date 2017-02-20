Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRRxT4995zDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 13:13:17 +1100 (AEDT)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vRRxT0PF4z9s86
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 13:13:17 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id a123so8092192pgc.3
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 18:13:16 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 2/2] powerpc/mm: Enable page table accounting
Date: Mon, 20 Feb 2017 13:12:57 +1100
Message-Id: <20170220021257.26959-2-bsingharora@gmail.com>
In-Reply-To: <20170220021257.26959-1-bsingharora@gmail.com>
References: <20170220021257.26959-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enabled __GFP_ACCOUNT in pgtable_get_gfp_flags(). This
allows accounting of page table allocation via kmem to
the correct cgroup. Basic testing was done to see if
the accounting reflects in

1. perf record tracing
2. memory.kmem.slabinfo

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index d0a9ca6..9207213 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -52,7 +52,9 @@ extern void __tlb_remove_table(void *_table);
 
 static inline gfp_t pgtable_get_gfp_flags(struct mm_struct *mm, gfp_t gfp)
 {
-	return gfp;
+	if (mm == &init_mm)
+		return gfp;
+	return gfp | __GFP_ACCOUNT;
 }
 
 static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
-- 
2.9.3
