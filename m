Return-Path: <R1AAHA@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51125B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Apr 2011 10:16:15 +1000 (EST)
Date: Mon, 11 Apr 2011 19:15:24 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] crypto: caam - remove WAIT-FOR-COMPLETIONs from
	givencrypt descriptor
Message-ID: <20110411191524.c825a8bf.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Steve Cornelius <sec@pobox.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

remains from descriptor debugging - not required for normal operation.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/crypto/caam/caamalg.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 20e1215..8eb84d3 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -828,15 +828,13 @@ static int aead_authenc_givencrypt(struct aead_givcrypt_request *req)
 	append_cmd(desc, CMD_LOAD | DISABLE_AUTO_INFO_FIFO);
 
 	/* MOVE DECO Alignment -> C1 Context 16 bytes */
-	append_move(desc, MOVE_WAITCOMP | MOVE_SRC_INFIFO |
-		    MOVE_DEST_CLASS1CTX | ivsize);
+	append_move(desc, MOVE_SRC_INFIFO | MOVE_DEST_CLASS1CTX | ivsize);
 
 	/* re-enable info fifo entries */
 	append_cmd(desc, CMD_LOAD | ENABLE_AUTO_INFO_FIFO);
 
 	/* MOVE C1 Context -> OFIFO 16 bytes */
-	append_move(desc, MOVE_WAITCOMP | MOVE_SRC_CLASS1CTX |
-		    MOVE_DEST_OUTFIFO | ivsize);
+	append_move(desc, MOVE_SRC_CLASS1CTX | MOVE_DEST_OUTFIFO | ivsize);
 
 	append_fifo_store(desc, iv_dma, ivsize, FIFOST_TYPE_MESSAGE_DATA);
 
-- 
1.7.4.3.dirty
