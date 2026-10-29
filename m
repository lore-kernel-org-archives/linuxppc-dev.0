Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B26606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVg4RrHK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFfRf73w5z30P3;
	Thu, 29 Oct 2026 20:43:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793266990;
	cv=none; b=ZsNowQQeLPmzeesTLmtYflho/yv1LtYW+tDwA4ODGzh2iybcTl63bik4uxFZqnNHmtXRyBXusPZXSZqCHOIBZB9zICwZwCM+cpiru+cWhNuBCT8vTffDdNCE9dCkmGaY40wCKUVETGl6NhkZsS4CewnEB/aZmyPPefbmDu5HH4PKrm44WwF0RdnUs+1FOWlFzvVZs3RVaNuR0WsMQLpbyKqb13XMcy4MtTfflt+Uuc+yxOriYtfzMM3etaPA9bAS32RLibftYeebKxk/MTEp0WqNmQBTska9MKLiS/YuIvcngW//P7gyKSSggcehUUzzVYud2AMnzlVtWR4w3fCaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793266990; c=relaxed/relaxed;
	bh=Pk4zFqn/UyIKjiaJnLG62AKImUGVwfG051wF5wLegNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XlYY45CN31G/FVrVdbj7eGktCa8T93LhKx1ruFjzwAT2ZMsD0d/nlviDtkCgwgkD58/Mv/MM5OOz9QOOWE6mXnpSdDd/H9MIHPpsJsUoYK+VW+mWLh8CEjQ7NciFsCQPeK5vtRECt/Cq2FfPCGjP5l8q5e/JtuxMqwIrtJl00lPQpE0Hz0yL/wGlOKynHAttiW89iiUz0DZbAgJbOZxPBUpvCadumeNAwOTUDEHA14bC1K1GUkMEVN3WFVUp7LsVqQ6lTwDDGYXuzmRZjAQzOIkmLuDZivYmoxGrwpPGHd+gFWuVO8Tf7aoXwKxL9UreKjVIvKqksvK8Ahdhw4m+Eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVg4RrHK; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVg4RrHK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFfRd1wjVz3048
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 20:43:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5BBC36022B;
	Thu, 29 Oct 2026 09:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BEC1F031E8;
	Thu, 29 Oct 2026 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266986;
	bh=Pk4zFqn/UyIKjiaJnLG62AKImUGVwfG051wF5wLegNQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DVg4RrHKT2rRWKbf+UR9G77yboK9JaKBUd/jNjwyWIUyVkvQKzKFtsIBhwe4RngmT
	 vEzYZkA/nOGl0g3OhPgYN2KyZe/wYePHf+6xUHs+U1jhOclRbRwAnjtrnJBdIob836
	 /z+Zi8kB03FYQxPGodH9lREV+7fOIf9mZikMLgwvBCdAa7fdBnEvw+k1XQr9uss/H5
	 A7SmIHRbYWNL9e/34WOfBu9kY2VDUeYjwjlEMMNS4QssO2C3994jKgkzdByMS2uH3w
	 Bihfr2if3Bs/tjoPdgoCVWEAeWipDX3mQTxrh+LkUBNPmTxRiNS8t9AFUmu7535TYk
	 FKfH3eDcwCmTw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id D8AC2198003A;
	Thu, 29 Oct 2026 05:43:03 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 29 Oct 2026 05:43:03 -0400
X-ME-Sender: <xms:JRXjagBdqoCb4A901YT8uFvhfHLK_EONpxtW4IYqhzfi8XZPhpWljw>
    <xme:JRXjatVspm8iH3VjonJGNb0e7kkJau1a4GwNGwlm13iSwxJPAjfMRxbKpRTq2XhjL
    1JyIsobqhhIb0_LmAG0OqQlmr8w6RjWRUcHrWbcNMRz4ggqtC25ZP4>
X-ME-Proxy-Cause: dmFkZTFdH5K86TO5l4Iy21yiAduYztn1KeEr8K0PR258Yp1mqFENX2a3vNGUa++hBrWAPu
    0WRLvg7v+HxQt60shJW1k+pFmU6UYFagGV5H14ce6bZzXkVsQfzfod1jQ+76s7B9vwRdEZ
    tNaHc5DgCi5LgLlUTABOab5QaRVVq85lbjLs6L0MNtj+S17jTWE5SAk3pG9dxs1bN8s6uC
    ehXJzkZt0d30Hj5Ib/55VJLDAHUyXPMWONrQwd2mVcLXrfS1bL5V5uP9A5hAlPaTcEGSde
    0qRe+HNBY9uLkRpzlauPohIA8tWps62V6KbZcBhLAsGp9ondLVmDAQs9hRYlMbKuuRRRMP
    bkDmNmwBeZrjzWExEVqx/xEdrpV/U+u2AKVvwHixKCKgDz25Zb4Npkb+GwJxspDVnkkgIC
    M4OYNDyeuB1OJvi9LXbHvSviqyr++5t6ICdGqA1QS0Ju5wXZhjD0jH3U0Yf8UVp4dFV6el
    ygeIu8ttuJgRPi0vlKEl+Dvv7j0eXjNzndjE9tcevdhGheyWykDJik2gfs1D9SJn88Ll88
    yByRNMzV3ARPx3Mc4n/iY2Vq8eAqoZ2G/OM4WUKaivWhpNZDVUhORSLD6ufRGswZHo1DAI
    K0Qy1znaQohPzaKd1BUuCvqhgNwLe0dbu7wEFXM14eEe1BqU0o1SAsW9p9kw
X-ME-Proxy: <xmx:JxXjatRlZFTwWB8U_hRQjhN_XctTgFUsYAO1RkOL3A2IpjJWhGq9bg>
    <xmx:JxXjatRyGT856UZEMx_0ZZixixJv-9iTuXliM4Njr67MCRgzzE6FJg>
    <xmx:JxXjag1nWgcCBjgS1Q3t5bstgPy6qt1cgrICnDWabMiQKg7s3MtZ9w>
    <xmx:JxXjanzaua3350MuK4690CF4CdcTAz58oUhBNFfAViZ2-oXYnLjlrg>
    <xmx:JxXjasxRq14-5UOlyO0LzvXvSsUKZx0Gs8ckJwLO9u_Fxe865EL2_WNF>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3D290F8008E; Thu, 29 Oct 2026 05:43:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
Date: Thu, 29 Oct 2026 10:42:40 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani" <ritesh.list@gmail.com>,
 "Shrikanth Hegde" <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <7c8500c2-4b59-40e2-a227-b488f1336fef@app.fastmail.com>
In-Reply-To: <20261029063522.124421-1-ebiggers@kernel.org>
References: <20261029063522.124421-1-ebiggers@kernel.org>
Subject: Re: [PATCH] lib/crypto: powerpc/poly1305: Remove BROKEN implementation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 29 Oct 2026, at 07:35, Eric Biggers wrote:
> The PowerPC implementation of Poly1305 has been marked as BROKEN for
> well over a year, since commit bc8169003b41 ("crypto: powerpc/poly1305 -
> add depends on BROKEN for now").  So, it's not being built or used.
>
> The justification for marking it BROKEN was that it didn't work in
> softirq context.  That still fully applies.
>
> However, it turns out the assembly file actually also contains logic
> bugs that make it compute incorrect Poly1305 values in some cases.  This
> is shown by it failing the test case test_poly1305_split_update_carry
> (if "depends on BROKEN" is removed).  The cause of that appears to be a
> lost carry bit in Carry_reduction.  However, there also appears to be a
> bug in do_final_update where it incorrectly assumes v6 is fully reduced.
>
> In addition, poly1305_emit_64 contains a secret-dependent branch.
>
> Let's just drop this code.  A fixed version can be reconsidered later.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  lib/crypto/Kconfig                     |    6 +-
>  lib/crypto/Makefile                    |    2 -
>  lib/crypto/powerpc/poly1305-p10le_64.S | 1076 ------------------------
>  lib/crypto/powerpc/poly1305.h          |   76 --
>  4 files changed, 1 insertion(+), 1159 deletions(-)
>  delete mode 100644 lib/crypto/powerpc/poly1305-p10le_64.S
>  delete mode 100644 lib/crypto/powerpc/poly1305.h
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

