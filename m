Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25AEADE1B7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 02:11:35 +1000 (EST)
Date: Mon, 16 Jun 2008 11:10:50 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 3/4] crypto/talitos: fix premature done handling
Message-Id: <20080616111050.596c245b.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, herbert@gondor.apana.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the h/w doesn't support out-of-order processing within a channel,
abort channel flush processing in the no-done-bits-and-no-error case
so as to not allow premature passthrough to the callback (and thus
dropped packets).

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/crypto/talitos.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index ce4787e..64ddad2 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -307,8 +307,13 @@ static void flush_channel(struct device *dev, int ch, int error, int reset_ch)
 
 		/* descriptors with their done bits set don't get the error */
 		rmb();
-		status = ((request->desc->hdr & DESC_HDR_DONE)
-			  == DESC_HDR_DONE) ? 0 : error;
+		if ((request->desc->hdr & DESC_HDR_DONE) == DESC_HDR_DONE)
+			status = 0;
+		else
+			if (!error)
+				break;
+			else
+				status = error;
 
 		dma_unmap_single(dev, request->dma_desc,
 			sizeof(struct talitos_desc), DMA_BIDIRECTIONAL);
-- 
1.5.6.rc2.26.g8c37
