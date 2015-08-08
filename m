Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5BDC1A0485
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B55C1C90048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:13 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t8PD54460466
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:08 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t751012137
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 03/16] Add sha1 implementation
Date: Fri,  7 Aug 2015 21:54:52 -0400
Message-Id: <1438998905-4085665-4-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch adds a SHA1 implementation based on the algorithm
description in NIST FIPS PUB 180-4.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 lib/libtpm/Makefile |   2 +-
 lib/libtpm/sha1.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/libtpm/sha1.h   |  20 ++++++
 3 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 lib/libtpm/sha1.c
 create mode 100644 lib/libtpm/sha1.h

diff --git a/lib/libtpm/Makefile b/lib/libtpm/Makefile
index 53d3abb..f8ad468 100644
--- a/lib/libtpm/Makefile
+++ b/lib/libtpm/Makefile
@@ -24,7 +24,7 @@ TARGET = ../libtpm.a
 
 all: $(TARGET)
 
-SRCS = tpm_drivers.c tcgbios.c
+SRCS = tpm_drivers.c tcgbios.c sha1.c
 
 OBJS = $(SRCS:%.c=%.o)
 
diff --git a/lib/libtpm/sha1.c b/lib/libtpm/sha1.c
new file mode 100644
index 0000000..2454b8f
--- /dev/null
+++ b/lib/libtpm/sha1.c
@@ -0,0 +1,197 @@
+/*****************************************************************************
+ * Copyright (c) 2015 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+/*
+ *  See: NIST standard for SHA-1 in FIPS PUB 180-4
+ */
+
+#include "byteorder.h"
+#include "sha1.h"
+#include "string.h"
+
+typedef struct _sha1_ctx {
+	uint32_t h[5];
+} sha1_ctx;
+
+static uint32_t rol(uint32_t data, uint8_t n)
+{
+	if (!n)
+		return data;
+	return (data << n) | (data >> (32 - n));
+}
+
+static void sha1_block(uint32_t *w, sha1_ctx *ctx)
+{
+	uint32_t i;
+	uint32_t a,b,c,d,e,f;
+	uint32_t tmp;
+	uint32_t idx;
+
+	/*
+	 * FIPS 180-4 4.2.1: SHA1 Constants
+	 */
+	static const uint32_t sha_ko[4] = {
+		0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6
+	};
+
+	/*
+	 * FIPS 180-4 6.1.2: step 1
+	 *
+	 *  0 <= i <= 15:
+	 *    W(t) = M(t)
+	 * 16 <= i <= 79:
+	 *    W(t) = ROTL(W(t-3) XOR W(t-8) XOR W(t-14) XOR W(t-16), 1)
+	 */
+
+	/* w(0)..(w15) already in big endian format */
+
+	for (i = 16; i <= 79; i++) {
+		tmp = w[i-3] ^ w[i-8] ^ w[i-14] ^ w[i-16];
+		w[i] = rol(tmp, 1);
+	}
+
+	/*
+	 * step 2: a = H0, b = H1, c = H2, d = H3, e = H4.
+	 */
+	a = ctx->h[0];
+	b = ctx->h[1];
+	c = ctx->h[2];
+	d = ctx->h[3];
+	e = ctx->h[4];
+
+	/*
+	 * step 3: For i = 0 to 79:
+	 *    T = ROTL(a, 5) + f(i; b,c,d) + e + W(t) + K(t);
+	 */
+	for (i = 0; i <= 79; i++) {
+		/*
+		 * FIPS 180-4: 4.1.1 : definition of f(i; b,c,d)
+		 */
+		if (i <= 19) {
+			/*
+			 *  0 <= i <= 19:
+			 *      f(i; b,c,d) = (b AND c) OR ((NOT b) AND d)
+			 */
+			f = (b & c) | ((b ^ 0xffffffff) & d);
+			idx = 0;
+		} else if (i <= 39) {
+			/*
+			 *  20 <= i <= 39:
+			 *       f(i; b,c,d) = b XOR c XOR d
+			 */
+			f = b ^ c ^ d;
+			idx = 1;
+		} else if (i <= 59) {
+			/*
+			 * 40 <= i <= 59:
+			 *      f(i; b,c,d) = (b AND c) OR (b AND d) OR (c AND d)
+			 */
+			f = (b & c) | (b & d) | (c & d);
+			idx = 2;
+		} else {
+			/*
+			 * 60 <= i <= 79:
+			 *      f(i; b,c,d) = b XOR c XOR d
+			 */
+			f = b ^ c ^ d;
+			idx = 3;
+		}
+
+		/*
+		 * step 3:
+		 *    t = ROTL(a, 5) + f(t;b,c,d) + e + K(t) + W(t);
+		 *    e = d;  d = c;  c = ROTL(b, 30);  b = a; a = t;
+		 */
+		tmp = rol(a, 5) +
+		      f +
+		      e +
+		      sha_ko[idx] +
+		      w[i];
+		e = d;
+		d = c;
+		c = rol(b, 30);
+		b = a;
+		a = tmp;
+	}
+
+	/*
+	 * step 4:
+	 *    H0 = a + H0, H1 = b + H1, H2 = c + H2, H3 = d + H3, H4 = e + H4
+	 */
+	ctx->h[0] += a;
+	ctx->h[1] += b;
+	ctx->h[2] += c;
+	ctx->h[3] += d;
+	ctx->h[4] += e;
+}
+
+static void sha1_do(sha1_ctx *ctx, const uint8_t*data32, uint32_t length)
+{
+	uint32_t offset;
+	uint16_t num;
+	uint32_t bits = 0;
+	uint32_t w[80];
+	uint64_t tmp;
+
+	/* treat data in 64-byte chunks */
+	for (offset = 0; length - offset >= 64; offset += 64) {
+		memcpy(w, data32 + offset, 64);
+		sha1_block((uint32_t *)w, ctx);
+		bits += (64 * 8);
+	}
+
+	/* last block with less than 64 bytes */
+	num = length - offset;
+	bits += (num << 3);
+
+	memcpy(w, data32 + offset, num);
+	/*
+	 * FIPS 180-4 5.1: Padding the Message
+	 */
+	((uint8_t *)w)[num] = 0x80;
+	if (64 - (num + 1) > 0)
+		memset( &((uint8_t *)w)[num + 1], 0, 64 - (num + 1));
+
+	if (num >= 56) {
+		/* cannot append number of bits here */
+		sha1_block((uint32_t *)w, ctx);
+		memset(w, 0, 60);
+	}
+
+	/* write number of bits to end of block */
+	tmp = bits;
+	memcpy(&w[14], &tmp, 8);
+
+	sha1_block(w, ctx);
+}
+
+uint32_t sha1(const uint8_t *data, uint32_t length, uint8_t *hash)
+{
+	sha1_ctx ctx = {
+		.h = {
+			/*
+			 * FIPS 180-4: 6.1.1
+			 *   -> 5.3.1: initial hash value
+			 */
+			0x67452301,
+			0xefcdab89,
+			0x98badcfe,
+			0x10325476,
+			0xc3d2e1f0,
+		}
+	};
+
+	sha1_do(&ctx, data, length);
+	memcpy(hash, &ctx.h[0], 20);
+
+	return 0;
+}
diff --git a/lib/libtpm/sha1.h b/lib/libtpm/sha1.h
new file mode 100644
index 0000000..7fa3e03
--- /dev/null
+++ b/lib/libtpm/sha1.h
@@ -0,0 +1,20 @@
+/*****************************************************************************
+ * Copyright (c) 2015 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef __SHA1_H
+#define __SHA1_H
+
+#include "types.h"
+
+uint32_t sha1(const uint8_t *data, uint32_t length, uint8_t *hash);
+
+#endif /* __SHA1_H */
-- 
1.9.3
