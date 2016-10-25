Return-Path: <dsafonov@virtuozzo.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20133.outbound.protection.outlook.com [40.107.2.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3HkF1hfWzDvkf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 02:53:25 +1100 (AEDT)
From: Dmitry Safonov <dsafonov@virtuozzo.com>
To: <linux-kernel@vger.kernel.org>
CC: <0x7f454c46@gmail.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Andy Lutomirski <luto@amacapital.net>,
 Oleg Nesterov <oleg@redhat.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-mm@kvack.org>
Subject: [PATCH 4/7] powerpc/vdso: introduce init_vdso{32,64}_pagelist
Date: Tue, 25 Oct 2016 18:51:03 +0300
Message-ID: <20161025155106.29946-5-dsafonov@virtuozzo.com>
In-Reply-To: <20161025155106.29946-1-dsafonov@virtuozzo.com>
References: <20161025155106.29946-1-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Common code with allocation/initialization of vDSO's pagelist.

Impact: cleanup

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org 
Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 arch/powerpc/kernel/vdso.c        | 27 ++-------------------------
 arch/powerpc/kernel/vdso_common.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 8010a0d82049..25d03d773c49 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -382,8 +382,6 @@ early_initcall(vdso_getcpu_init);
 
 static int __init vdso_init(void)
 {
-	int i;
-
 #ifdef CONFIG_PPC64
 	/*
 	 * Fill up the "systemcfg" stuff for backward compatibility
@@ -454,32 +452,11 @@ static int __init vdso_init(void)
 	}
 
 #ifdef CONFIG_VDSO32
-	/* Make sure pages are in the correct state */
-	vdso32_pagelist = kzalloc(sizeof(struct page *) * (vdso32_pages + 2),
-				  GFP_KERNEL);
-	BUG_ON(vdso32_pagelist == NULL);
-	for (i = 0; i < vdso32_pages; i++) {
-		struct page *pg = virt_to_page(vdso32_kbase + i*PAGE_SIZE);
-		ClearPageReserved(pg);
-		get_page(pg);
-		vdso32_pagelist[i] = pg;
-	}
-	vdso32_pagelist[i++] = virt_to_page(vdso_data);
-	vdso32_pagelist[i] = NULL;
+	init_vdso32_pagelist();
 #endif
 
 #ifdef CONFIG_PPC64
-	vdso64_pagelist = kzalloc(sizeof(struct page *) * (vdso64_pages + 2),
-				  GFP_KERNEL);
-	BUG_ON(vdso64_pagelist == NULL);
-	for (i = 0; i < vdso64_pages; i++) {
-		struct page *pg = virt_to_page(vdso64_kbase + i*PAGE_SIZE);
-		ClearPageReserved(pg);
-		get_page(pg);
-		vdso64_pagelist[i] = pg;
-	}
-	vdso64_pagelist[i++] = virt_to_page(vdso_data);
-	vdso64_pagelist[i] = NULL;
+	init_vdso64_pagelist();
 #endif /* CONFIG_PPC64 */
 
 	get_page(virt_to_page(vdso_data));
diff --git a/arch/powerpc/kernel/vdso_common.c b/arch/powerpc/kernel/vdso_common.c
index ac25d66134fb..c97c30606b3f 100644
--- a/arch/powerpc/kernel/vdso_common.c
+++ b/arch/powerpc/kernel/vdso_common.c
@@ -14,6 +14,7 @@
 #define VDSO_LBASE	CONCAT3(VDSO, BITS, _LBASE)
 #define vdso_kbase	CONCAT3(vdso, BITS, _kbase)
 #define vdso_pages	CONCAT3(vdso, BITS, _pages)
+#define vdso_pagelist	CONCAT3(vdso, BITS, _pagelist)
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vDSO" __stringify(BITS) ": " fmt
@@ -202,6 +203,25 @@ static __init int vdso_setup(struct lib_elfinfo *v)
 	return 0;
 }
 
+#define init_vdso_pagelist CONCAT3(init_vdso, BITS, _pagelist)
+static __init void init_vdso_pagelist(void)
+{
+	int i;
+
+	/* Make sure pages are in the correct state */
+	vdso_pagelist = kzalloc(sizeof(struct page *) * (vdso_pages + 2),
+				  GFP_KERNEL);
+	BUG_ON(vdso_pagelist == NULL);
+	for (i = 0; i < vdso_pages; i++) {
+		struct page *pg = virt_to_page(vdso_kbase + i*PAGE_SIZE);
+
+		ClearPageReserved(pg);
+		get_page(pg);
+		vdso_pagelist[i] = pg;
+	}
+	vdso_pagelist[i++] = virt_to_page(vdso_data);
+	vdso_pagelist[i] = NULL;
+}
 
 #undef find_section
 #undef find_symbol
@@ -211,10 +231,12 @@ static __init int vdso_setup(struct lib_elfinfo *v)
 #undef vdso_fixup_datapage
 #undef vdso_fixup_features
 #undef vdso_setup
+#undef init_vdso_pagelist
 
 #undef VDSO_LBASE
 #undef vdso_kbase
 #undef vdso_pages
+#undef vdso_pagelist
 #undef lib_elfinfo
 #undef BITS
 #undef _CONCAT3
-- 
2.10.0
