Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20F4C1A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 20:54:33 +1000 (AEST)
Received: by wicnf17 with SMTP id nf17so39467643wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 03:54:29 -0700 (PDT)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, ralf@linux-mips.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aaro.koskinen@iki.fi
Subject: [PATCH 5/6] crypto: n2: use md5 IV MD5_HX instead of their raw value
Date: Sun, 17 May 2015 12:54:16 +0200
Message-Id: <1431860057-5232-5-git-send-email-clabbe.montjoie@gmail.com>
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
 drivers/crypto/n2_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 10a9aef..2e8dab9 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1281,10 +1281,10 @@ static const char md5_zero[MD5_DIGEST_SIZE] = {
 	0xe9, 0x80, 0x09, 0x98, 0xec, 0xf8, 0x42, 0x7e,
 };
 static const u32 md5_init[MD5_HASH_WORDS] = {
-	cpu_to_le32(0x67452301),
-	cpu_to_le32(0xefcdab89),
-	cpu_to_le32(0x98badcfe),
-	cpu_to_le32(0x10325476),
+	cpu_to_le32(MD5_H0),
+	cpu_to_le32(MD5_H1),
+	cpu_to_le32(MD5_H2),
+	cpu_to_le32(MD5_H3),
 };
 static const char sha1_zero[SHA1_DIGEST_SIZE] = {
 	0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32,
-- 
2.3.6
