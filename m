Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB50B1A0668
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 04:05:32 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6/8] crypto: replace memset by memzero_explicit
Date: Sun, 30 Nov 2014 17:59:32 +0100
Message-Id: <1417366774-32412-7-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1417366774-32412-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1417366774-32412-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: herbert@gondor.apana.org.au, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dborkman@redhat.com,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 Julia Lawall <julia@diku.dk>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Memset on a local variable may be removed when it is called just before the
variable goes out of scope.  Using memzero_explicit defeats this
optimization.  A simplified version of the semantic patch that makes this
change is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
type T;
@@

{
... when any
T x[...];
... when any
    when exists
- memset
+ memzero_explicit
  (x,
-0,
  ...)
... when != x
    when strict
}
// </smpl>

This change was suggested by Daniel Borkmann <dborkman@redhat.com>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
Daniel Borkmann suggested that these patches could go through Herbert Xu's
cryptodev tree.

 arch/powerpc/crypto/sha1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/sha1.c b/arch/powerpc/crypto/sha1.c
index 0f88c7b..d3feba5 100644
--- a/arch/powerpc/crypto/sha1.c
+++ b/arch/powerpc/crypto/sha1.c
@@ -66,7 +66,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 			src = data + done;
 		} while (done + 63 < len);
 
-		memset(temp, 0, sizeof(temp));
+		memzero_explicit(temp, sizeof(temp));
 		partial = 0;
 	}
 	memcpy(sctx->buffer + partial, src, len - done);
