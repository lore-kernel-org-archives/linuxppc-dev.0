Return-Path: <jmlatten@linux.vnet.ibm.com>
Received: from oc8377654763.ibm.com (unknown [32.97.110.51])
 by ozlabs.org (Postfix) with SMTP id 259C62C0150
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 08:25:30 +1000 (EST)
Date: Wed, 14 Aug 2013 17:17:57 -0500
From: jmlatten@linux.vnet.ibm.com
To: herbert@gondor.apana.org.au
Subject: [PATCH] crypto:nx - fix nx-aes-gcm verification
Message-ID: <520c0215.kHFgBNcJQfAPXpv3%jmlatten@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a bug in the nx-aes-gcm implementation.
Corrected the code so that the authtag is always verified after
decrypting and not just when there is associated data included.
Also, corrected the code to retrieve the input authtag from src
instead of dst. 

Reviewed-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Reviewed-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
Signed-off-by: Joy Latten <jmlatten@linux.vnet.ibm.com>

diff --git a/drivers/crypto/nx/nx-aes-gcm.c b/drivers/crypto/nx/nx-aes-gcm.c
index 6cca6c3..eb851bb 100644
--- a/drivers/crypto/nx/nx-aes-gcm.c
+++ b/drivers/crypto/nx/nx-aes-gcm.c
@@ -243,11 +243,11 @@ static int gcm_aes_nx_crypt(struct aead_request *req, int enc)
 				 req->dst, nbytes,
 				 crypto_aead_authsize(crypto_aead_reqtfm(req)),
 				 SCATTERWALK_TO_SG);
-	} else if (req->assoclen) {
+	} else {
 		u8 *itag = nx_ctx->priv.gcm.iauth_tag;
 		u8 *otag = csbcpb->cpb.aes_gcm.out_pat_or_mac;
 
-		scatterwalk_map_and_copy(itag, req->dst, nbytes,
+		scatterwalk_map_and_copy(itag, req->src, nbytes,
 				 crypto_aead_authsize(crypto_aead_reqtfm(req)),
 				 SCATTERWALK_FROM_SG);
 		rc = memcmp(itag, otag,
