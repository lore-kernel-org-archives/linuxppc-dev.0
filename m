Return-Path: <SRS0=RTqQ=TA=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 203D8DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 20:43:35 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: Fix arch/ppc compilation - Add missing typedef pgtable_t
Date: Mon, 11 Feb 2008 10:41:18 +0100
Message-Id: <1202722878-31963-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 2f569afd9ced9ebec9a6eb3dbf6f83429be0a7b4 ("CONFIG_HIGHPTE vs.
sub-page page tables.") breaks compilation of arch/ppc since it
introduces the pgtable_t type which was not added to arch/ppc.

This patch now adds the missing typedef.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 include/asm-ppc/page.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index ad4c5a1..37e4756 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -125,6 +125,8 @@ extern __inline__ int get_order(unsigned long size)
 	return 32 - lz;
 }
 
+typedef struct page *pgtable_t;
+
 #endif /* __ASSEMBLY__ */
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
-- 
1.5.4.1
