Return-Path: <aaro.koskinen@iki.fi>
Received: from emh02.mail.saunalahti.fi (emh02.mail.saunalahti.fi
 [62.142.5.108])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402xhy08ySzF1KL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 07:22:38 +1100 (AEDT)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] drivers: macintosh: rack-meter: really fix bogus memsets
Date: Fri, 16 Mar 2018 22:17:28 +0200
Message-Id: <20180316201728.3377-1-aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should zero an array using sizeof instead of number of elements.

Fixes the following compiler (GCC 7.3.0) warnings:

drivers/macintosh/rack-meter.c: In function 'rackmeter_do_pause':
drivers/macintosh/rack-meter.c:157:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
drivers/macintosh/rack-meter.c:158:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]

Fixes: 4f7bef7a9f69 ("drivers: macintosh: rack-meter: fix bogus memsets")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/rack-meter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 910b5b6..eb65b6e 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -154,8 +154,8 @@ static void rackmeter_do_pause(struct rackmeter *rm, int pause)
 		DBDMA_DO_STOP(rm->dma_regs);
 		return;
 	}
-	memset(rdma->buf1, 0, ARRAY_SIZE(rdma->buf1));
-	memset(rdma->buf2, 0, ARRAY_SIZE(rdma->buf2));
+	memset(rdma->buf1, 0, sizeof(rdma->buf1));
+	memset(rdma->buf2, 0, sizeof(rdma->buf2));
 
 	rm->dma_buf_v->mark = 0;
 
-- 
2.9.2
