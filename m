Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp01.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F22A72C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 06:01:54 +1000 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Fri, 23 Aug 2013 17:01:51 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 30B4C1DC0068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 16:01:48 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7NK075O45744228
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 17:00:07 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7NK1lxt001422
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 17:01:47 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au
Subject: [PATCH 10/10] crypto: nx - fix SHA-2 for chunks bigger than block size
Date: Fri, 23 Aug 2013 17:01:14 -0300
Message-Id: <1377288074-18998-11-git-send-email-mhcerri@linux.vnet.ibm.com>
In-Reply-To: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
References: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each call to the co-processor, with exception of the last call, needs to
send data that is multiple of block size. As consequence, any remaining
data is kept in the internal NX context.

This patch fixes a bug in the driver that causes it to save incorrect
data into the context when data is bigger than the block size.

Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
---
 drivers/crypto/nx/nx-sha256.c | 2 +-
 drivers/crypto/nx/nx-sha512.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/nx/nx-sha256.c b/drivers/crypto/nx/nx-sha256.c
index 6547a71..da0b24a 100644
--- a/drivers/crypto/nx/nx-sha256.c
+++ b/drivers/crypto/nx/nx-sha256.c
@@ -129,7 +129,7 @@ static int nx_sha256_update(struct shash_desc *desc, const u8 *data,
 		NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
 
 		total -= to_process;
-		data += to_process;
+		data += to_process - sctx->count;
 		sctx->count = 0;
 		in_sg = nx_ctx->in_sg;
 	} while (leftover >= SHA256_BLOCK_SIZE);
diff --git a/drivers/crypto/nx/nx-sha512.c b/drivers/crypto/nx/nx-sha512.c
index 236e6af..4ae5b0f 100644
--- a/drivers/crypto/nx/nx-sha512.c
+++ b/drivers/crypto/nx/nx-sha512.c
@@ -131,7 +131,7 @@ static int nx_sha512_update(struct shash_desc *desc, const u8 *data,
 		NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
 
 		total -= to_process;
-		data += to_process;
+		data += to_process - sctx->count[0];
 		sctx->count[0] = 0;
 		in_sg = nx_ctx->in_sg;
 	} while (leftover >= SHA512_BLOCK_SIZE);
-- 
1.7.12
