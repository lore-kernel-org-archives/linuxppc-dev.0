Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA20D2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 03:22:11 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH 4/4] powerpc: don't use module_init for non-modular core
 hugetlb code
Date: Mon, 13 Jan 2014 11:21:53 -0500
Message-ID: <1389630113-7919-5-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1389630113-7919-1-git-send-email-paul.gortmaker@windriver.com>
References: <1389630113-7919-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hugetlbpage.o is obj-y (always built in).  It will never
be modular, so using module_init as an alias for __initcall is
somewhat misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of arch_initcall (which
makes sense for arch code) will thus change this registration
from level 6-device to level 3-arch (i.e. slightly earlier).
However no observable impact of that small difference has
been observed during testing, or is expected.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 90bb6d9409bf..d25c202420da 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -911,7 +911,7 @@ static int __init hugetlbpage_init(void)
 	return 0;
 }
 #endif
-module_init(hugetlbpage_init);
+arch_initcall(hugetlbpage_init);
 
 void flush_dcache_icache_hugepage(struct page *page)
 {
-- 
1.8.5.2
