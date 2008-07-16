Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D5B7DE624
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:23:12 +1000 (EST)
Date: Wed, 16 Jul 2008 18:22:30 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 6/6] crypto: talitos - sparse fix
Message-Id: <20080716182230.0a33d01b.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/crypto/talitos.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index a81265b..681c15f 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -848,7 +848,7 @@ static int sg_to_link_tbl(struct scatterlist *sg, int sg_count,
 
 	/* adjust (decrease) last one (or two) entry's len to cryptlen */
 	link_tbl_ptr--;
-	while (link_tbl_ptr->len <= (-cryptlen)) {
+	while (be16_to_cpu(link_tbl_ptr->len) <= (-cryptlen)) {
 		/* Empty this entry, and move to previous one */
 		cryptlen += be16_to_cpu(link_tbl_ptr->len);
 		link_tbl_ptr->len = 0;
-- 
1.5.6
