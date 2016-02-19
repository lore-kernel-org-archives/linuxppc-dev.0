Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB2431A0635
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 12:55:59 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id e127so41828684pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 17:55:59 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/Kconfig: Update config option based on page size.
Date: Fri, 19 Feb 2016 12:55:43 +1100
Message-Id: <1455846943-32147-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.

The error occurs because of the following constraint (from
include/linux/mmzone.h) being violated:

	MAX_ORDER -1 + PAGESHIFT <= SECTION_SIZE_BITS.

Expanding this out, we get:

	FORCE_MAX_ZONEBITS <= 25 - PAGESHIFT,

which requires, for a 64K page, FORCE_MAX_ZONEBITS <= 9. Thus
set max value of FORCE_MAX_ZONEORDER for 64K pages to 9.

Also, check the minimum value:
In include/linux/huge_mm.h, we have the constraint HPAGE_PMD_ORDER <
MAX_ORDER which expands out to:

	PTE_INDEX_SIZE < FORCE_MAX_ZONEORDER.

PTE_INDEX_SIZE is:
	9 (4k hash or no hash 4K pgtable) or
	8 (64K hash or no hash 64K pgtable).
Thus a min value of 9 for 64K pages is reasonable.

So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 9-9.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e4824fd04bb7..3bd3465b93ba 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -585,7 +585,7 @@ endchoice
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-	range 9 64 if PPC64 && PPC_64K_PAGES
+	range 9 9 if PPC64 && PPC_64K_PAGES
 	default "9" if PPC64 && PPC_64K_PAGES
 	range 13 64 if PPC64 && !PPC_64K_PAGES
 	default "13" if PPC64 && !PPC_64K_PAGES
-- 
2.5.0
