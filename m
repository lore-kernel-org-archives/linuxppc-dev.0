Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0141.outbound.protection.outlook.com [157.56.111.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C20081A1E95
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Nov 2014 06:07:14 +1100 (AEDT)
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH] mm/hugetlb: sanity check gigantic hugepage count
Date: Fri, 14 Nov 2014 12:32:24 -0600
Message-ID: <1415989944-26965-1-git-send-email-James.Yang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: James Yang <James.Yang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Limit the number of gigantic hugepages specified by the
hugepages= parameter to MAX_NUMBER_GPAGES.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/mm/hugetlbpage.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index d67db4b..5ef84a2 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -362,6 +362,13 @@ static int __init do_gpage_early_setup(char *param, char *val,
 		if (size != 0) {
 			if (sscanf(val, "%lu", &npages) <= 0)
 				npages = 0;
+			if (npages > MAX_NUMBER_GPAGES) {
+				pr_warn("MMU: %lu pages requested for page "
+					"size %llu KB, limiting to "
+					__stringify(MAX_NUMBER_GPAGES) "\n",
+					npages, size / 1024);
+				npages = MAX_NUMBER_GPAGES;
+			}
 			gpage_npages[shift_to_mmu_psize(__ffs(size))] = npages;
 			size = 0;
 		}
-- 
1.7.0.4
