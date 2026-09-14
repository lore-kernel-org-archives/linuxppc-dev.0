Return-Path: <linuxppc-dev+bounces-27215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21012C88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 08:15:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjycv2D66z2yFK;
	Mon, 14 Sep 2026 18:15:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789373711;
	cv=none; b=CBFpM0qhMYjbvOQqNMllpa1EPj5qWAjYGTODtZAlaGbUy3khUfmTgRIfUb45p6DqzbVcCcNyJPtYyWCvb9ZroMv/rFT8KMc8vF69vRsZaUobKhSvSro3PjcuhgsrE14hSG3DqhEU7OqFnvmLHL3Al8ArBjavHD2HOasrN3yPKC0QkAwPKZvoARPLX209sZbZQeeNCu+ui8QwMyBCdVXFDyMyC4p0UGF1s6C5vA/0EPOa7972oQvCQ+87bN7lO3dJNnFu0WavaIMONStn2mFTAFTejMvOG3jaAMkBnpHsjX0+y51ViAnQjd4q1Tlso/J4Nl/vyOoouPg4NqA1xEZ9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789373711; c=relaxed/relaxed;
	bh=hhy3y+RdyOlzV0mNEG3QJcfAPDjRe336pjQbMT65wf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJyL3K1yS1YRRj60iB4rDXjfUsuJd5gLyIC9G2ftvxnWhvC2cvfv+Wq/HV7zkiWiD+t1IeiRyZfGqj9Hu9RGcQ7DhlTFq7M5xO3UBOnYOt00qw89zK2GZTVT5QFLcIXjGPyvCcwxCLM4SPEKbuy7oxxLnEgySGzk80eAGDjNumUKx4EfxBBzWjMqAamX/FgrseZq8yctxYHOo04EViyDpsTxRlUT2qYmsWU4h28dTHU4jvXPpkkdKsmQA96qBbsn5IyI/RoDFaRhy0/aYMf8PFa0C3WLh0m9RUQJGXfU9rHMvwCtTpgiQXQQ0Ju43HiWjppgcKh8JlPaf8w3K4JrNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XziPNHhQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XziPNHhQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjyct3k8Kz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 18:15:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E1F6240B6B;
	Mon, 14 Sep 2026 08:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FAD1F000FF;
	Mon, 14 Sep 2026 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789373707;
	bh=hhy3y+RdyOlzV0mNEG3QJcfAPDjRe336pjQbMT65wf0=;
	h=From:To:Cc:Subject:Date;
	b=XziPNHhQKEQxv51Elz22SfWhe9WD4fWAT223dHBDdHZ30Lfc+0j753gFCA6dAtMs6
	 Ujuqcju29M+JIIQiMo8rY1UP883hT7Ngf4FlzxWu5pBAjSArydGIvJgDAUJpjl7BZf
	 8p43+jf50J1H5o1xOa2NMen0p8XH8j3jbVt2vRM3kYNtjjM32f58MN3ORTugLIX+5X
	 /1X7u/tk/9TG7v1b1g2XWAfaOZ6WihE6apRdmvHRqTPuulZ1kb9+xjtNQ+j341lhR6
	 Iy/FTWJ84WRxgDCy0zG4KfrYDL7ThNfnAVyhOeTn0lyZYx4tHf71xvVLHlrD8uNR6c
	 fQ0j0DnsSQ4Qw==
From: Thorsten Blum <blum@kernel.org>
To: =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: powerpc/vmx - clean up includes, metadata, and p8_init()
Date: Mon, 14 Sep 2026 10:15:01 +0200
Message-ID: <20260914081500.65737-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=blum@kernel.org; h=from:subject; bh=q/3kCHUCRPlYa+KGkiI9OcT5TV4ELNVW3HhU2DS+tYg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnL17J8mXfzzAO+uCyZXW90+li2FW7ad5xzae5dtR0hb ptOOIkt6yhlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJnL7J8D+4iP+G9wXmtJUd X6ZLztN1fTDtYYfPMb20YzLX5oX5aDkw/DP46fpr+Yv/bxuyTyqwq5kHzWhZeyb3bePc7uehd+0 SVjIBAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

In p8_init(), remove the goto statement and return ret directly.

Remove any redundant includes, add a missing space in MODULE_AUTHOR(),
and join the MODULE_DESCRIPTION() strings for better grepability.

Also remove MODULE_VERSION(). It has never been updated and the kernel
release better reflects the module version.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/crypto/vmx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/crypto/vmx.c b/arch/powerpc/crypto/vmx.c
index 08da5311dfdf..8abc4db8ee4e 100644
--- a/arch/powerpc/crypto/vmx.c
+++ b/arch/powerpc/crypto/vmx.c
@@ -8,12 +8,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/err.h>
 #include <linux/cpufeature.h>
-#include <linux/crypto.h>
-#include <asm/cputable.h>
 #include <crypto/internal/skcipher.h>
 
 #include "aesp8-ppc.h"
@@ -24,7 +19,7 @@ static int __init p8_init(void)
 
 	ret = crypto_register_skcipher(&p8_aes_cbc_alg);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = crypto_register_skcipher(&p8_aes_ctr_alg);
 	if (ret)
@@ -40,7 +35,6 @@ static int __init p8_init(void)
 	crypto_unregister_skcipher(&p8_aes_ctr_alg);
 err_unregister_aes_cbc:
 	crypto_unregister_skcipher(&p8_aes_cbc_alg);
-err:
 	return ret;
 }
 
@@ -54,8 +48,6 @@ static void __exit p8_exit(void)
 module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, p8_init);
 module_exit(p8_exit);
 
-MODULE_AUTHOR("Marcelo Cerri<mhcerri@br.ibm.com>");
-MODULE_DESCRIPTION("IBM VMX cryptographic acceleration instructions "
-		   "support on Power 8");
+MODULE_AUTHOR("Marcelo Cerri <mhcerri@br.ibm.com>");
+MODULE_DESCRIPTION("IBM VMX cryptographic acceleration instructions support on Power 8");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0.0");

