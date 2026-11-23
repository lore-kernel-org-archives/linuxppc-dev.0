Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19885606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTRrdDMy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY8Y15wzKz2xyj;
	Tue, 24 Nov 2026 02:11:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795446693;
	cv=none; b=ECgTsEUPQ6lyXZSn/4ogywMNc2jwSvwnaaqzD8Z2Ir3hgj/fK8oZ6B83Ks/EL2s45VFgcGDL2gcKEEWa1r3pcy3y7k0cQanUB/7RsPg56vos0IH3f4sEa5EdKNQbv04DsJON6PohbODC4OGp41TfRbY6n/6iYcymqFN18gO3xn7w2Ovr9vsZcAbS3u89im0Pb8TVQCtXKLgrSgNLGz7hUOSPJPfbNLusX0r720wI4VsEu+nyn3U9M4BVs21oeLpprYQ2SNUzPHTCoHWinNU3s0kZ768MrKH7I2my4jHQ7X2A2LBZusPOGsF/9W9yEPZJYzJrESsa9ahQVSi3ch2QBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795446693; c=relaxed/relaxed;
	bh=IO+/0E+TAMyUiGRvFqTT6Iz3EJ2AtWO/PWampQ+h9N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmMmiwsizkT5WF11SG6uANBntjyJMUO4bOYe1a59yXd1fftNCwhtPldVxWQ6Z7X2eBYgY2a0Jqthg5z9PzwOR52OlytrS5nRCPge3PGiyikD5kIEvpoaLGcRUpjRg/XX2OHjeodNyxkLmRSVF7ARDR03MqRqb58PbfGkF43f3x+L2nQyLngk00VEmaiEVbLatS6zkmGeritOpDUN8vRWCG54WgPU+BdvClMR6XzBp+DhtHx8Wj0fT88ACpUoHxEykftL6D9I/cNGGWY0E17PweojBco9JYzfG3FqqCWcoV6xdM37Kyxtj8gTnz2/xSqF1d2ydOqhst9qiogk3gCIcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTRrdDMy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTRrdDMy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY8Y05pYsz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 02:11:32 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F96F4594F;
	Mon, 23 Nov 2026 15:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180931F000F2;
	Mon, 23 Nov 2026 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446689;
	bh=IO+/0E+TAMyUiGRvFqTT6Iz3EJ2AtWO/PWampQ+h9N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTRrdDMyjgv8vyeUaookRwA9cP3oZfnmW7KXMK/QRvONxYZMNcVasWG2N+2tLlBtu
	 +WO7jjCCxd+jcH0UN7dH5l4hZuMtZ6BuN/3Tr5s/1OWYlLPnqoE7udw387J9aguVIS
	 EORM9Qi7bTaaKBKv0ZpuGiJyU7LTprWXVQaNbgcA3v65G+TIebVydq9qkyZGnk9Cb9
	 mW9SA5+RT2xitVJvO1U6K8UhSo9uO1DubcOf2xjdO3WUcKtXv/9M8J7LJ3swv3REJD
	 +xKtuJmNNW4gsQ9jlto9q/FhjvF+mSsxU4ddUPzgJUwWrgFRKUAbzgO0R57y2QFTjb
	 VnMn5XCNhvcbg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Thorsten Blum <blum@kernel.org>,
	Bulent Abali <abali@us.ibm.com>,
	Robert Jennings <rcj@linux.vnet.ibm.com>,
	Seth Jennings <sjenning@linux.vnet.ibm.com>,
	Dan Streetman <ddstreet@ieee.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] crypto: nx - Fix bounce buffer copy overflow in decompress()
Date: Mon, 23 Nov 2026 15:09:54 +0000
Message-ID: <20261123151055.2533735-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123151055.2533735-1-lee@kernel.org>
References: <20261123151055.2533735-1-lee@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When decompress() falls back to software 842 decompression and the
remaining destination capacity p->oremain is smaller than required_len,
it redirects decompression into the bounce buffer ctx->dbounce with
dlen set to BOUNCE_BUFFER_SIZE.

After sw842_decompress() completes and ignore bytes are subtracted,
decompress() copies dlen bytes from ctx->dbounce into p->out via
memcpy() before update_param() validates that dlen does not exceed
p->oremain.  A crafted compressed stream whose decompressed output
exceeds p->oremain therefore overflows the caller's destination buffer
by up to BOUNCE_BUFFER_SIZE bytes.

Validate that dlen does not exceed p->oremain and return -ENOSPC before
copying out of ctx->dbounce.

Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
Closes: https://sashiko.dev/#/bug/linux-7309787b-8efe-4919-bb31-c4d9eceb9c0f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/crypto/nx/nx-842.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index b4404a138962..4f96c2b2397b 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -427,8 +427,11 @@ static int decompress(struct nx842_crypto_ctx *ctx,
 	if (ignore)
 		pr_debug("ignoring last %x bytes\n", ignore);
 
-	if (dst == ctx->dbounce)
+	if (dst == ctx->dbounce) {
+		if (dlen > p->oremain)
+			return -ENOSPC;
 		memcpy(p->out, dst, dlen);
+	}
 
 	pr_debug("decompress slen %x padding %x dlen %x ignore %x\n",
 		 slen, padding, dlen, ignore);
-- 
2.56.1.750.gf70dc682cf-goog


