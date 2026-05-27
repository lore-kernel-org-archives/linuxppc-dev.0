Return-Path: <linuxppc-dev+bounces-21590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366CFCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 14:13:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQWmg4wSkz3bpL;
	Thu, 28 May 2026 00:13:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779891187;
	cv=none; b=YaxtNDqw9vvK5N9GfQYk0rcBOb21ATHvTvISvEW2OENH15+7X/R6xVuYwTGGlW+lBffHoJM/U33WJkQYIVsOfQs/j0sYr2IBeVfnihiyVuyMob1lfM7NGNsT/82ARVCE5kKIjUO9cNyJbyqvy4izSvmxQ/GFnDMNLSe+IWyqF5EiMJAIaRnpsefX8sAK05zwAAIEOGuD424g9CsSbGGcQt4Jy6YdJufenltiUfXvVkmCqDsIoblJCfW7218LCy5OFpmQqzVt0x67uAhJj3MocULz/5BJ6XUKtnJsULIfELtZ4ZpwcivexoW8X7OjmCxdFV1RvdX6TOv++tzEo7hkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779891187; c=relaxed/relaxed;
	bh=hthxLoJgR89tBl7jthjU5X9svK67rTNi6Rp5QXjLXpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ku6AxgwxpwdwbP+CrP+sjCyVu0bOmkDa93j2Twr0gZx00Yz7NJx04oN8tRR2SL92nBxgJtJDGoNEi7RVuXHeQELDsO5+0H+e1bmEjhbdpZxnT0dhdeJefPKKAKd8pyuT1gktltXlnCNaZkM/CXPZ10D8H3/JTqMivv3sRsKVFhsSqUc6kqcU4/np4FMvpybKWNj/RUuXqULguQHn64RJBAhie9LH/TZ8T3dCS2MuH7Q1/ZHWdaoHukfeuDJ/6AVFQu7q084x+y9LQc3RPnbiCrRyr6tpiYnIimj5pD2lq+OEm9dUUFDLlrgfzqISoWmJQoVmh7SyfrRDL3hnHgybUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SuRyDeFQ; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SuRyDeFQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQWmb2Z0Qz30Wn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 00:13:00 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779891159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hthxLoJgR89tBl7jthjU5X9svK67rTNi6Rp5QXjLXpM=;
	b=SuRyDeFQt6o3ov5uSgOJXQQe2HZfBw+4dwC6x7KoMPLaA6Hn21QA44+L8/hjp79utKZiIv
	tNv9b+8HjNfEhN+WNourRRnNmiJBiWYiZ4OvXVK6kTjt0W6tBqDEfT1iOoWhxZg8cISgCJ
	iOwceYUeUEw8P3l58aIVBiLXYMf8Wks=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: powerpc/aes - use min in ppc_{ecb,cbc,ctr,xts}_crypt
Date: Wed, 27 May 2026 16:11:47 +0200
Message-ID: <20260527141146.1230672-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=thorsten.blum@linux.dev; h=from:subject; bh=+n5NkJ5N4jZbkelJ0z6A3VaVtqvZIIQ+UU2iQaKm7qA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlivxf5LN+uZShzc7ut4JOWl+eWWal9+rBnV+ei61Zyx e9bF5vadJSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEPLcwMqwIXBh9i/n/6qao ZB3nP0pb1x+/vyDno4SDdzvLPhmB8FuMDItvn6hid9Kuk178/lPuujUTD+UEhqg5H5XaUWp6wtr sIC8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace min_t() with the simpler min() macro since the values are
unsigned and compatible.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/crypto/aes-spe-glue.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/crypto/aes-spe-glue.c b/arch/powerpc/crypto/aes-spe-glue.c
index 7d2827e65240..e038488087e6 100644
--- a/arch/powerpc/crypto/aes-spe-glue.c
+++ b/arch/powerpc/crypto/aes-spe-glue.c
@@ -9,6 +9,7 @@
  */
 
 #include <crypto/aes.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -140,7 +141,7 @@ static int ppc_ecb_crypt(struct skcipher_request *req, bool enc)
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) != 0) {
-		nbytes = min_t(unsigned int, nbytes, MAX_BYTES);
+		nbytes = min(nbytes, MAX_BYTES);
 		nbytes = round_down(nbytes, AES_BLOCK_SIZE);
 
 		spe_begin();
@@ -179,7 +180,7 @@ static int ppc_cbc_crypt(struct skcipher_request *req, bool enc)
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) != 0) {
-		nbytes = min_t(unsigned int, nbytes, MAX_BYTES);
+		nbytes = min(nbytes, MAX_BYTES);
 		nbytes = round_down(nbytes, AES_BLOCK_SIZE);
 
 		spe_begin();
@@ -220,7 +221,7 @@ static int ppc_ctr_crypt(struct skcipher_request *req)
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) != 0) {
-		nbytes = min_t(unsigned int, nbytes, MAX_BYTES);
+		nbytes = min(nbytes, MAX_BYTES);
 		if (nbytes < walk.total)
 			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
 
@@ -248,7 +249,7 @@ static int ppc_xts_crypt(struct skcipher_request *req, bool enc)
 	twk = ctx->key_twk;
 
 	while ((nbytes = walk.nbytes) != 0) {
-		nbytes = min_t(unsigned int, nbytes, MAX_BYTES);
+		nbytes = min(nbytes, MAX_BYTES);
 		nbytes = round_down(nbytes, AES_BLOCK_SIZE);
 
 		spe_begin();

