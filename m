Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69927DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:22:37 +1000 (EST)
Date: Wed, 16 Jul 2008 18:21:53 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 2/6] crypto: talitos - correct dst != src case handling
Message-Id: <20080716182153.1e6e098e.kim.phillips@freescale.com>
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

From: Lee Nipper <lee.nipper@freescale.com>

Seems that dst == src, but this fixes the logic in case it's not.

Signed-off-by: Lee Nipper <lee.nipper@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/crypto/talitos.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 01e6595..f644fba 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1022,7 +1022,7 @@ static struct ipsec_esp_edesc *ipsec_esp_edesc_alloc(struct aead_request *areq,
 		dst_nents = src_nents;
 	} else {
 		dst_nents = sg_count(areq->dst, areq->cryptlen + ctx->authsize);
-		dst_nents = (dst_nents == 1) ? 0 : src_nents;
+		dst_nents = (dst_nents == 1) ? 0 : dst_nents;
 	}
 
 	/*
-- 
1.5.6
