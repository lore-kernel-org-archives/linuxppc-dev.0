Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 804CB1A1855
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 00:32:03 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 07/17] crypto: talitos - enhanced talitos_desc struct for
 SEC1
To: Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David S Miller <davem@davemloft.net>
Message-Id: <20150417143201.7C8B41A242C@localhost.localdomain>
Date: Fri, 17 Apr 2015 16:32:01 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enhances the talitos_desc struct with fields for SEC1.
SEC1 has only one header field, and has a 'next_desc' field in
addition.
This mixed descriptor will continue to fit SEC2, and for SEC1
we will recopy hdr value into hdr1 value in talitos_submit()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index 61a1405..f078da1 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -37,9 +37,17 @@
 
 /* descriptor pointer entry */
 struct talitos_ptr {
-	__be16 len;     /* length */
-	u8 j_extent;    /* jump to sg link table and/or extent */
-	u8 eptr;        /* extended address */
+	union {
+		struct {		/* SEC2 format */
+			__be16 len;     /* length */
+			u8 j_extent;    /* jump to sg link table and/or extent*/
+			u8 eptr;        /* extended address */
+		};
+		struct {			/* SEC1 format */
+			__be16 res;
+			__be16 len1;	/* length */
+		};
+	};
 	__be32 ptr;     /* address */
 };
 
@@ -53,8 +61,12 @@ static const struct talitos_ptr zero_entry = {
 /* descriptor */
 struct talitos_desc {
 	__be32 hdr;                     /* header high bits */
-	__be32 hdr_lo;                  /* header low bits */
+	union {
+		__be32 hdr_lo;		/* header low bits */
+		__be32 hdr1;		/* header for SEC1 */
+	};
 	struct talitos_ptr ptr[7];      /* ptr/len pair array */
+	__be32 next_desc;		/* next descriptor (SEC1) */
 };
 
 /**
-- 
2.1.0
