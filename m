Return-Path: <marcelo.cerri@canonical.com>
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgk6K21qQzDsl4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 05:32:55 +1000 (AEST)
Received: by mail-qk0-x22b.google.com with SMTP id z190so115456926qkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 12:32:55 -0700 (PDT)
From: Marcelo Cerri <marcelo.cerri@canonical.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>,
 Claudio Carvalho <cclaudio@br.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@br.ibm.com>, joy.latten@canonical.com,
 Marcelo Cerri <marcelo.cerri@canonical.com>
Subject: [PATCH] crypto: sha1-powerpc: little-endian support
Date: Fri, 23 Sep 2016 16:31:56 -0300
Message-Id: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The driver does not handle endianness properly when loading the input
data.

Signed-off-by: Marcelo Cerri <marcelo.cerri@canonical.com>
---
 arch/powerpc/crypto/sha1-powerpc-asm.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto/sha1-powerpc-asm.S
index 125e165..82ddc9b 100644
--- a/arch/powerpc/crypto/sha1-powerpc-asm.S
+++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
@@ -7,6 +7,15 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 
+#ifdef __BIG_ENDIAN__
+#define LWZ(rt, d, ra)	\
+	lwz	rt,d(ra)
+#else
+#define LWZ(rt, d, ra)	\
+	li	rt,d;	\
+	lwbrx	rt,rt,ra
+#endif
+
 /*
  * We roll the registers for T, A, B, C, D, E around on each
  * iteration; T on iteration t is A on iteration t+1, and so on.
@@ -23,7 +32,7 @@
 #define W(t)	(((t)%16)+16)
 
 #define LOADW(t)				\
-	lwz	W(t),(t)*4(r4)
+	LWZ(W(t),(t)*4,r4)
 
 #define STEPD0_LOAD(t)				\
 	andc	r0,RD(t),RB(t);		\
@@ -33,7 +42,7 @@
 	add	r0,RE(t),r15;			\
 	add	RT(t),RT(t),r6;		\
 	add	r14,r0,W(t);			\
-	lwz	W((t)+4),((t)+4)*4(r4);	\
+	LWZ(W((t)+4),((t)+4)*4,r4);	\
 	rotlwi	RB(t),RB(t),30;			\
 	add	RT(t),RT(t),r14
 
-- 
2.7.4
