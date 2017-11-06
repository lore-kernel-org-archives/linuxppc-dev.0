Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVp6j13PYzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:03:40 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g6so7815548pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:03:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 3/5] powerpc/64s/hash: Fix fork() with 512TB process address
 space
Date: Mon,  6 Nov 2017 21:03:13 +1100
Message-Id: <20171106100315.29720-4-npiggin@gmail.com>
In-Reply-To: <20171106100315.29720-1-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
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
index 05e15386d4cb..b94fb62e60fd 100644
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
