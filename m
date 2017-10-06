Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7qbx0lGPzDqlP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 00:04:45 +1100 (AEDT)
Message-Id: <40cffda4ea4e6ca69cd9df95f4d049dfe7d514d1.1507284818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1507284818.git.christophe.leroy@c-s.fr>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 05/18] crypto: talitos - fix use of sg_link_tbl_len
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri,  6 Oct 2017 15:04:41 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sg_link_tbl_len shall be used instead of cryptlen, otherwise
SECs which perform HW CICV verification will fail.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index b7184f305867..cf5c9701b898 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1232,8 +1232,8 @@ static int ipsec_esp(struct talitos_edesc *edesc, struct aead_request *areq,
 			sg_link_tbl_len += authsize;
 	}
 
-	ret = talitos_sg_map(dev, areq->src, cryptlen, edesc, &desc->ptr[4],
-			     sg_count, areq->assoclen, tbl_off);
+	ret = talitos_sg_map(dev, areq->src, sg_link_tbl_len, edesc,
+			     &desc->ptr[4], sg_count, areq->assoclen, tbl_off);
 
 	if (ret > 1) {
 		tbl_off += ret;
-- 
2.13.3
