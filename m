Return-Path: <key@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7FF8B1008A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 01:33:11 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Thu, 12 Apr 2012 11:33:03 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9106838C822B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 11:28:13 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3CFSAlE314510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 11:28:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3CFRRMm008381
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 12:27:28 -0300
Message-ID: <1334244274.18090.19.camel@key-ThinkPad-W510>
Subject: [PATCH v3 07/17] powerpc: crypto: AES-CBC mode routines for nx
 encryption
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Apr 2012 10:24:34 -0500
In-Reply-To: <1334242825.18090.4.camel@key-ThinkPad-W510>
References: <1334242825.18090.4.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These routines add support for AES in CBC mode on the Power7+ CPU's
in-Nest accelerator driver.

Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 drivers/crypto/nx/nx-aes-cbc.c |  140 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 drivers/crypto/nx/nx-aes-cbc.c

diff --git a/drivers/crypto/nx/nx-aes-cbc.c b/drivers/crypto/nx/nx-aes-cbc.c
new file mode 100644
index 0000000..dc3ea12
--- /dev/null
+++ b/drivers/crypto/nx/nx-aes-cbc.c
@@ -0,0 +1,140 @@
+/**
+ * AES CBC routines supporting the Power 7+ Nest Accelerators driver
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
+static int cbc_aes_nx_set_key(struct crypto_tfm *tfm,
+			      const u8          *in_key,
+			      unsigned int       key_len)
+{
+	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(tfm);
+	struct nx_csbcpb *csbcpb = nx_ctx->csbcpb;
+
+	nx_ctx_init(nx_ctx, HCOP_FC_AES);
+
+	switch (key_len) {
+	case AES_KEYSIZE_128:
+		NX_CPB_SET_KEY_SIZE(csbcpb, NX_KS_AES_128);
+		nx_ctx->ap = &nx_ctx->props[NX_PROPS_AES_128];
+		break;
+	case AES_KEYSIZE_192:
+		NX_CPB_SET_KEY_SIZE(csbcpb, NX_KS_AES_192);
+		nx_ctx->ap = &nx_ctx->props[NX_PROPS_AES_192];
+		break;
+	case AES_KEYSIZE_256:
+		NX_CPB_SET_KEY_SIZE(csbcpb, NX_KS_AES_256);
+		nx_ctx->ap = &nx_ctx->props[NX_PROPS_AES_256];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	csbcpb->cpb.hdr.mode = NX_MODE_AES_CBC;
+	memcpy(csbcpb->cpb.aes_cbc.key, in_key, key_len);
+
+	return 0;
+}
+
+static int cbc_aes_nx_crypt(struct blkcipher_desc *desc,
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
+	if (enc)
+		NX_CPB_FDM(csbcpb) |= NX_FDM_ENDE_ENCRYPT;
+	else
+		NX_CPB_FDM(csbcpb) &= ~NX_FDM_ENDE_ENCRYPT;
+
+	rc = nx_build_sg_lists(nx_ctx, desc, dst, src, nbytes,
+			       csbcpb->cpb.aes_cbc.iv);
+	if (rc)
+		goto out;
+
+	if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
+		rc = -EINVAL;
+		goto out;
+	}
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
+static int cbc_aes_nx_encrypt(struct blkcipher_desc *desc,
+			      struct scatterlist    *dst,
+			      struct scatterlist    *src,
+			      unsigned int           nbytes)
+{
+	return cbc_aes_nx_crypt(desc, dst, src, nbytes, 1);
+}
+
+static int cbc_aes_nx_decrypt(struct blkcipher_desc *desc,
+			      struct scatterlist    *dst,
+			      struct scatterlist    *src,
+			      unsigned int           nbytes)
+{
+	return cbc_aes_nx_crypt(desc, dst, src, nbytes, 0);
+}
+
+struct crypto_alg nx_cbc_aes_alg = {
+	.cra_name        = "cbc(aes)",
+	.cra_driver_name = "cbc-aes-nx",
+	.cra_priority    = 300,
+	.cra_flags       = CRYPTO_ALG_TYPE_BLKCIPHER,
+	.cra_blocksize   = AES_BLOCK_SIZE,
+	.cra_ctxsize     = sizeof(struct nx_crypto_ctx),
+	.cra_type        = &crypto_blkcipher_type,
+	.cra_module      = THIS_MODULE,
+	.cra_list        = LIST_HEAD_INIT(nx_cbc_aes_alg.cra_list),
+	.cra_init        = nx_crypto_ctx_aes_cbc_init,
+	.cra_exit        = nx_crypto_ctx_exit,
+	.cra_blkcipher = {
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize      = AES_BLOCK_SIZE,
+		.setkey      = cbc_aes_nx_set_key,
+		.encrypt     = cbc_aes_nx_encrypt,
+		.decrypt     = cbc_aes_nx_decrypt,
+	}
+};
-- 
1.7.1
