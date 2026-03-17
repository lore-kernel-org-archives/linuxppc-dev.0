Return-Path: <linuxppc-dev+bounces-18331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24313FD7091
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 20:19:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb3Fw3H5yz2xS3;
	Wed, 18 Mar 2026 07:19:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773778756;
	cv=none; b=PuR1v3kkInhWHEaJJ6muvXkG/v9gYpL1LDXFupB+6uB3DIqjLDejAda1K4YHtrvBBaxCBReQ5T0gHlghF7kD4jDk0cJv9xRNCwcGrI3cT/TXeEmMyluFGDAfRNWAIDCgl/wnxn6mJzMPJEymkPJt67XWgUvIoCG3NJMVDmTamqTweWeS3VtewdmlYhtFUoe6N7XSsxFv8J8tlJMgC/mRammxMJ6U56qmXZT2a+kOdKcMKf/Y5eHBrzMOHzH1pjTCo227CNfbnppPYLklcPK3fEsgrEfbTwu86/b8zjsk801JjXsJvXxVmkQZJjlbIDLLMBjpNFrA5jo2ohW393USUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773778756; c=relaxed/relaxed;
	bh=YokNPDBKB47On83Stit2XVqNDOPxCXgKpwFpqg0JOMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngnJXtimrGm6q4N/49oGtTXJLtWCkK/vAYSK+kidIUyl8XdBVxdwgKnk/BNLIu4YflD4VJLU0xIMJPkhZ4vEV2qHjQxCxWiZT1oXtCH4xHdaTY6tQN1f3/0GQuNMop/cfizlN4Q2e+fAxuxYqeMEPj5a+FfcktaibHFEk2Cobf71JR2ht8UhkSCxzcpoHkbEaiVCFp1YjO/ev2wTMx39ybBBMz+BPwmcIdRAKpibI2l4SAnTYNKbIbGtfvugYz+oiL1/L1Da1xTHKb/ExWOva+9LR20sRBoydqwSRpOpOr1r8BhhEq4qaGzja3SBETgfyajpV1QsqQWWKR6IDYDgFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=prJZOGnH; dkim-atps=neutral; spf=pass (client-ip=91.218.175.172; helo=out-172.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=prJZOGnH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.172; helo=out-172.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb3Fr40gpz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 07:19:09 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773778724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YokNPDBKB47On83Stit2XVqNDOPxCXgKpwFpqg0JOMo=;
	b=prJZOGnHkGu1i4Hjq/hZEc7bucV1GxtQn76Yg+4nomNnHfNq2HFTUCGGUeATEz9cQpHogH
	5/pxYddwxRFnayGgi6Cy0GUXTY43Ul/dpmHmBlIWs6W/dIbzWtW3h5Hfp12TVhvYxCwKkv
	5NzUw26qxV6dG4Md6BD5+pFbewD6knc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: nx - annotate struct nx842_crypto_header with __counted_by
Date: Tue, 17 Mar 2026 21:18:06 +0100
Message-ID: <20260317201804.1393389-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=thorsten.blum@linux.dev; h=from:subject; bh=rr9c7b7Bg8HmED96qIytYPhFZybnAlnT+6xjQRz6Vhk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk7t/0xyVm2QfVq6/S8LTv3yptMM800fJ3WNumi3WGvk kccZRmnO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiluyMDHtY1Y/81P+y4c6O eQeXrBLIqX9UZ26jdq/R3TxPJzXEyoyR4YZH1PLfP+68O3vqtq2MSUGR4NubrMHJ7+3KT+0K5t6 7mQMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'group' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/nx/nx-842.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index f5e2c82ba876..a04e85e9f78e 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -164,7 +164,7 @@ struct nx842_crypto_header {
 		__be16 ignore;		/* decompressed end bytes to ignore */
 		u8 groups;		/* total groups in this header */
 	);
-	struct nx842_crypto_header_group group[];
+	struct nx842_crypto_header_group group[] __counted_by(groups);
 } __packed;
 static_assert(offsetof(struct nx842_crypto_header, group) == sizeof(struct nx842_crypto_header_hdr),
 	      "struct member likely outside of struct_group_tagged()");

