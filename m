Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41SGn46w0HzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 14:25:24 +1000 (AEST)
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 David Miller <davem@davemloft.net>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] net/ethernet/freescale/fman: fix cross-build error
Message-ID: <3a063d78-73f8-b41f-9354-fe839fe80c11@infradead.org>
Date: Fri, 13 Jul 2018 21:25:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Dunlap <rdunlap@infradead.org>

  CC [M]  drivers/net/ethernet/freescale/fman/fman.o
In file included from ../drivers/net/ethernet/freescale/fman/fman.c:35:
../include/linux/fsl/guts.h: In function 'guts_set_dmacr':
../include/linux/fsl/guts.h:165:2: error: implicit declaration of function 'clrsetbits_be32' [-Werror=implicit-function-declaration]
  clrsetbits_be32(&guts->dmacr, 3 << shift, device << shift);
  ^~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
Cc: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
Found while doing ppc32_allmodconfig builds.

 include/linux/fsl/guts.h |    1 +
 1 file changed, 1 insertion(+)

--- lnx-418-rc4.orig/include/linux/fsl/guts.h
+++ lnx-418-rc4/include/linux/fsl/guts.h
@@ -16,6 +16,7 @@
 #define __FSL_GUTS_H__
 
 #include <linux/types.h>
+#include <linux/io.h>
 
 /**
  * Global Utility Registers.
