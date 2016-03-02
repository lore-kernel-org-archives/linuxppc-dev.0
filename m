Return-Path: <aaro.koskinen@iki.fi>
Received: from emh02.mail.saunalahti.fi (emh02.mail.saunalahti.fi
 [62.142.5.108])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0664A1A010D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 06:59:17 +1100 (AEDT)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND 2/2] drivers: macintosh: rack-meter: fix bogus memsets
Date: Wed,  2 Mar 2016 21:59:06 +0200
Message-Id: <1456948746-15640-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1456948746-15640-1-git-send-email-aaro.koskinen@iki.fi>
References: <1456948746-15640-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix bogus memsets pointed out by sparse:

linux-v4.3/drivers/macintosh/rack-meter.c:157:15: warning: memset with byte count of 0
linux-v4.3/drivers/macintosh/rack-meter.c:158:15: warning: memset with byte count of 0

Probably "&" is mistyped "*"; use ARRAY_SIZE to make it more safe.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/rack-meter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index ba7e330..465c522 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -154,8 +154,8 @@ static void rackmeter_do_pause(struct rackmeter *rm, int pause)
 		DBDMA_DO_STOP(rm->dma_regs);
 		return;
 	}
-	memset(rdma->buf1, 0, SAMPLE_COUNT & sizeof(u32));
-	memset(rdma->buf2, 0, SAMPLE_COUNT & sizeof(u32));
+	memset(rdma->buf1, 0, ARRAY_SIZE(rdma->buf1));
+	memset(rdma->buf2, 0, ARRAY_SIZE(rdma->buf2));
 
 	rm->dma_buf_v->mark = 0;
 
-- 
2.4.0
