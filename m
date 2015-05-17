Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wi0-x244.google.com (mail-wi0-x244.google.com
 [IPv6:2a00:1450:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A73121A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 20:54:29 +1000 (AEST)
Received: by wivr20 with SMTP id r20so6119246wiv.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 03:54:26 -0700 (PDT)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, ralf@linux-mips.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aaro.koskinen@iki.fi
Subject: [PATCH 3/6] crypto: powerpc/md5: use md5 IV MD5_HX instead of their
 raw value
Date: Sun, 17 May 2015 12:54:14 +0200
Message-Id: <1431860057-5232-3-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 LABBE Corentin <clabbe.montjoie@gmail.com>, linux-crypto@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since MD5 IV are now available in crypto/md5.h, use them.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 arch/powerpc/crypto/md5-glue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/crypto/md5-glue.c b/arch/powerpc/crypto/md5-glue.c
index 452fb4d..9228967 100644
--- a/arch/powerpc/crypto/md5-glue.c
+++ b/arch/powerpc/crypto/md5-glue.c
@@ -37,10 +37,10 @@ static int ppc_md5_init(struct shash_desc *desc)
 {
 	struct md5_state *sctx = shash_desc_ctx(desc);
 
-	sctx->hash[0] = 0x67452301;
-	sctx->hash[1] = 0xefcdab89;
-	sctx->hash[2] = 0x98badcfe;
-	sctx->hash[3] =	0x10325476;
+	sctx->hash[0] = MD5_H0;
+	sctx->hash[1] = MD5_H1;
+	sctx->hash[2] = MD5_H2;
+	sctx->hash[3] =	MD5_H3;
 	sctx->byte_count = 0;
 
 	return 0;
-- 
2.3.6
