Return-Path: <key@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75BEBB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 08:39:44 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Wed, 21 Mar 2012 15:39:41 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4FD7B3E40036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 15:39:30 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2LLdJNf192738
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 15:39:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2LLdGfA019008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 15:39:18 -0600
Message-ID: <1332366010.3858.40.camel@key-ThinkPad-W510>
Subject: [PATCH 09/17] powerpc: crypto: AES-ECB mode routines for nx encryption
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2012 16:40:10 -0500
In-Reply-To: <1332365297.3858.5.camel@key-ThinkPad-W510>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These routines add support for AES in ECB mode on the Power7+ CPU's
in-Nest accelerator driver.

Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 arch/powerpc/crypto/nx/nx-aes-ecb.c |  133 +++++++++++++++++++++++++++++++++++
 1 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/crypto/nx/nx-aes-ecb.c

diff --git a/arch/powerpc/crypto/nx/nx-aes-ecb.c b/arch/powerpc/crypto/nx/nx-aes-ecb.c
new file mode 100644
index 0000000..7ceef65
--- /dev/null
+++ b/arch/powerpc/crypto/nx/nx-aes-ecb.c
@@ -0,0 +1,133 @@
+/**
+ * AES ECB routines supporting the Power 7+ Nest Accelerators driver
+ *
+ * Copyright (C) 2011-2012 International Business Machines Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 only.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Author: Kent Yoder <yoder1@us.ibm.com>
+ */
+
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/crypto.h>
+#include <asm/vio.h>
+
+#include "nx_csbcpb.h"
+#include "nx.h"
+
+
+static int ecb_aes_nx_set_key(struct crypto_tfm *tfm,
+			      const u8          *in_key,
+			      unsigned int       key_len)
+{
+	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(tfm);
+	struct nx_csbcpb *csbcpb = (struct nx_csbcpb *)nx_ctx->csbcpb;
+
+	nx_ctx_init(nx_ctx, HCOP_FC_AES);
+
+	switch (key_len) {
+	case AES_KEYSIZE_128:
+		csbcpb->cpb.hdr.key_size = NX_KS_AES_128;
+		nx_ctx->ap = &nx_ctx->props[NX_PROPS_AES_128];
+		break;
+	case AES_KEYSIZE_192:
+		csbcpb->cpb.hdr.key_size = NX_KS_AES_192;
+		nx_ctx->ap = &nx_ctx->props[NX_PROPS_AES_192];
+		break;
+	case AES_KEYSIZE_256:
+		csbcpb->cpb.hdr.key_size = NX_KS_AES_256;
+		nx_ctx->ap = &nx_ctx->props[NX_PROPS_AES_256];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	csbcpb->cpb.hdr.mode = NX_MODE_AES_ECB;
+	memcpy(csbcpb->cpb.aes_ecb.key, in_key, key_len);
+
+	return 0;
+}
+
+static int ecb_aes_nx_crypt(struct blkcipher_desc *desc,
+			    struct scatterlist    *dst,
+			    struct scatterlist    *src,
+			    unsigned int           nbytes,
+			    int                    enc)
+{
+	struct nx_crypto_ctx *nx_ctx = crypto_blkcipher_ctx(desc->tfm);
+	struct nx_csbcpb *csbcpb = nx_ctx->csbcpb;
+	int rc;
+
+	if (nbytes > nx_ctx->ap->databytelen)
+		return -EINVAL;
+
+	csbcpb->cpb.hdr.fdm.ende = enc;
+
+	rc = nx_build_sg_lists(nx_ctx, desc, dst, src, nbytes, NULL);
+	if (rc)
+		goto out;
+
+	if (!nx_ctx->op.inlen || !nx_ctx->op.outlen)
+		return -EINVAL;
+
+	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op);
+	if (rc)
+		goto out;
+
+	atomic_inc(&(nx_ctx->stats->aes_ops));
+	atomic64_add(csbcpb->csb.processed_byte_count,
+		     &(nx_ctx->stats->aes_bytes));
+out:
+	return rc;
+}
+
+static int ecb_aes_nx_encrypt(struct blkcipher_desc *desc,
+			      struct scatterlist    *dst,
+			      struct scatterlist    *src,
+			      unsigned int           nbytes)
+{
+	return ecb_aes_nx_crypt(desc, dst, src, nbytes, 1);
+}
+
+static int ecb_aes_nx_decrypt(struct blkcipher_desc *desc,
+			      struct scatterlist    *dst,
+			      struct scatterlist    *src,
+			      unsigned int           nbytes)
+{
+	return ecb_aes_nx_crypt(desc, dst, src, nbytes, 0);
+}
+
+struct crypto_alg nx_ecb_aes_alg = {
+	.cra_name        = "ecb(aes)",
+	.cra_driver_name = "ecb-aes-nx",
+	.cra_priority    = 300,
+	.cra_flags       = CRYPTO_ALG_TYPE_BLKCIPHER,
+	.cra_blocksize   = AES_BLOCK_SIZE,
+	.cra_ctxsize     = sizeof(struct nx_crypto_ctx),
+	.cra_type        = &crypto_blkcipher_type,
+	.cra_module      = THIS_MODULE,
+	.cra_list        = LIST_HEAD_INIT(nx_ecb_aes_alg.cra_list),
+	.cra_init        = nx_crypto_ctx_aes_ecb_init,
+	.cra_exit        = nx_crypto_ctx_exit,
+	.cra_blkcipher = {
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.setkey      = ecb_aes_nx_set_key,
+		.encrypt     = ecb_aes_nx_encrypt,
+		.decrypt     = ecb_aes_nx_decrypt,
+	}
+};
-- 
1.7.1
