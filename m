Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 00FD9B72A4
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:30:46 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
 Dan Malek <ppc6dev@digitaldans.com>
Subject: [PATCH 14/14] 8xx: The TLB miss handler manages ACCESSED correctly.
Date: Mon, 10 Oct 2011 13:30:20 +0200
Message-Id: <1318246220-4839-15-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new MMU/TLB code no longer sets ACCESSED unconditionally
so remove the exception.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 include/asm-ppc/pgtable.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index 6cfc5fc..b94e8a8 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -318,16 +318,6 @@ extern unsigned long vmalloc_start;
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 
-/*
- * The 8xx TLB miss handler allegedly sets _PAGE_ACCESSED in the PTE
- * for an address even if _PAGE_PRESENT is not set, as a performance
- * optimization.  This is a bug if you ever want to use swap unless
- * _PAGE_ACCESSED is 2, which it isn't, or unless you have 8xx-specific
- * definitions for __swp_entry etc. below, which would be gross.
- *  -- paulus
- */
-#define _PTE_NONE_MASK	_PAGE_ACCESSED
-
 #else /* CONFIG_6xx */
 /* Definitions for 60x, 740/750, etc. */
 #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
-- 
1.7.3.4
