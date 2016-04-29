Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxQSj5MB9zDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 06:35:49 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] Use dma_pool_zalloc
Date: Fri, 29 Apr 2016 22:09:07 +0200
Message-Id: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dma_pool_zalloc combines dma_pool_alloc and memset 0.  The semantic patch
that makes this transformation is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
type T;
T *d;
expression e;
statement S;
@@

        d =
-            dma_pool_alloc
+            dma_pool_zalloc
             (...);
        if (!d) S
-       memset(d, 0, sizeof(T));

@@
expression d,e;
statement S;
@@

        d =
-            dma_pool_alloc
+            dma_pool_zalloc
             (...);
        if (!d) S
-       memset(d, 0, sizeof(*d));
// </smpl>

---

 drivers/crypto/marvell/tdma.c    |    5 ++---
 drivers/dma/fsldma.c             |    3 +--
 drivers/dma/ioat/init.c          |    5 ++---
 drivers/dma/mmp_pdma.c           |    3 +--
 drivers/dma/xilinx/xilinx_vdma.c |    3 +--
 5 files changed, 7 insertions(+), 12 deletions(-)
