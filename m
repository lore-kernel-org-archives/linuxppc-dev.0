Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXqr25XzYzDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 04:28:02 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id v78so5227215pgb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 09:28:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 2/5] powerpc/64s/hash: Fix fork() with 512TB process
 address space
Date: Fri, 10 Nov 2017 04:27:37 +1100
Message-Id: <20171109172740.19681-3-npiggin@gmail.com>
In-Reply-To: <20171109172740.19681-1-npiggin@gmail.com>
References: <20171109172740.19681-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hash unconditionally resets the addr_limit to default (128TB) when
the mm context is initialised. If a process has > 128TB mappings when
it forks, the child will not get the 512TB addr_limit, so accesses to
valid > 128TB mappings will fail in the child.

Fix this by only resetting the addr_limit to default if it was 0. Non
zero indicates it was duplicated from the parent (0 means exec()).

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/mmu_context_book3s64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 6d724dab27c2..846cbad45fce 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -93,11 +93,11 @@ static int hash__init_new_context(struct mm_struct *mm)
 		return index;
 
 	/*
-	 * We do switch_slb() early in fork, even before we setup the
-	 * mm->context.addr_limit. Default to max task size so that we copy the
-	 * default values to paca which will help us to handle slb miss early.
+	 * In the case of exec, use the default limit,
+	 * otherwise inherit it from the mm we are duplicating.
 	 */
-	mm->context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	if (!mm->context.addr_limit)
+		mm->context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
 
 	/*
 	 * The old code would re-promote on fork, we don't do that when using
-- 
2.15.0
