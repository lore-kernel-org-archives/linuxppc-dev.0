Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6810B6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 16:05:25 +1100 (EST)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mm: Fix parse_arg build error
Date: Thu, 12 Jan 2012 23:05:15 -0600
Message-ID: <1326431115-425-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes this build issue:

arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
arch/powerpc/mm/hugetlbpage.c:312:2: error: implicit declaration of function 'parse_args'
make[1]: *** [arch/powerpc/mm/hugetlbpage.o] Error 1

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
This is for benh next tree

 arch/powerpc/mm/hugetlbpage.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 79c575d..a8b3cc7 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -15,6 +15,7 @@
 #include <linux/of_fdt.h>
 #include <linux/memblock.h>
 #include <linux/bootmem.h>
+#include <linux/moduleparam.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
-- 
1.7.6.1
