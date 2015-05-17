Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wi0-x241.google.com (mail-wi0-x241.google.com
 [IPv6:2a00:1450:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F27F1A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 20:54:31 +1000 (AEST)
Received: by wibbw19 with SMTP id bw19so6107301wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 03:54:28 -0700 (PDT)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, ralf@linux-mips.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aaro.koskinen@iki.fi
Subject: [PATCH 4/6] crypto: sparc/md5: use md5 IV MD5_HX instead of their raw
 value
Date: Sun, 17 May 2015 12:54:15 +0200
Message-Id: <1431860057-5232-4-git-send-email-clabbe.montjoie@gmail.com>
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
 arch/sparc/crypto/md5_glue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/crypto/md5_glue.c b/arch/sparc/crypto/md5_glue.c
index b688731..c9d2b92 100644
--- a/arch/sparc/crypto/md5_glue.c
+++ b/arch/sparc/crypto/md5_glue.c
@@ -33,10 +33,10 @@ static int md5_sparc64_init(struct shash_desc *desc)
 {
 	struct md5_state *mctx = shash_desc_ctx(desc);
 
-	mctx->hash[0] = cpu_to_le32(0x67452301);
-	mctx->hash[1] = cpu_to_le32(0xefcdab89);
-	mctx->hash[2] = cpu_to_le32(0x98badcfe);
-	mctx->hash[3] = cpu_to_le32(0x10325476);
+	mctx->hash[0] = cpu_to_le32(MD5_H0);
+	mctx->hash[1] = cpu_to_le32(MD5_H1);
+	mctx->hash[2] = cpu_to_le32(MD5_H2);
+	mctx->hash[3] = cpu_to_le32(MD5_H3);
 	mctx->byte_count = 0;
 
 	return 0;
-- 
2.3.6
