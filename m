Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc3CZ4GQ8zDqm7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:10:50 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id k10so8622816wre.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:10:50 -0700 (PDT)
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, x86@kernel.org, horia.geanta@nxp.com,
 dan.douglass@nxp.com, thomas.lendacky@amd.com, gary.hook@amd.com,
 harsh@chelsio.com, matthias.bgg@gmail.com, leosilva@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 11/11] crypto: aesni - Use GCM IV size constant
Date: Tue, 22 Aug 2017 10:08:18 +0200
Message-Id: <20170822080818.12486-12-clabbe.montjoie@gmail.com>
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/x86/crypto/aesni-intel_glue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 5c15d6b57329..80664368bf14 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -28,6 +28,7 @@
 #include <crypto/cryptd.h>
 #include <crypto/ctr.h>
 #include <crypto/b128ops.h>
+#include <crypto/gcm.h>
 #include <crypto/xts.h>
 #include <asm/cpu_device_id.h>
 #include <asm/fpu/api.h>
@@ -1131,7 +1132,7 @@ static struct aead_alg aesni_aead_algs[] = { {
 	.setauthsize		= common_rfc4106_set_authsize,
 	.encrypt		= helper_rfc4106_encrypt,
 	.decrypt		= helper_rfc4106_decrypt,
-	.ivsize			= 8,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "__gcm-aes-aesni",
@@ -1149,7 +1150,7 @@ static struct aead_alg aesni_aead_algs[] = { {
 	.setauthsize		= rfc4106_set_authsize,
 	.encrypt		= rfc4106_encrypt,
 	.decrypt		= rfc4106_decrypt,
-	.ivsize			= 8,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "rfc4106(gcm(aes))",
@@ -1165,7 +1166,7 @@ static struct aead_alg aesni_aead_algs[] = { {
 	.setauthsize		= generic_gcmaes_set_authsize,
 	.encrypt		= generic_gcmaes_encrypt,
 	.decrypt		= generic_gcmaes_decrypt,
-	.ivsize			= 12,
+	.ivsize			= GCM_AES_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "gcm(aes)",
-- 
2.13.0
