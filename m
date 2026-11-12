Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CDD606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiDyh9CS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJZb1SKkz2xLs;
	Thu, 12 Nov 2026 22:49:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794484151;
	cv=none; b=hCPhUVDrqrWOu90IlTRZJIaImf9ZVxxXnYGbEzaBWAfgeHE4KLoI6ZPqHe1OpQl96EzjKCIZnxFf6lBIHNIXDy1AIGeip58pGRgcTQptBGxWUM7bFXlLOhADY78PVUL6hJ4tZCoHw5nVYkKJy/vXK7umMvLhish5k5Cf4Wyv/HAR5sr4Q1pevFHsdYqyDBL+ZnGt1Fa+LCZFijfoAsjV9XKobaAGDMJ/Xp6sLcmyo/XGXkGNEKN2a4LToso9mpY8Wc2bgUoOgH7buGVRBdlykL+R8EIEoM14kjMEoKNxhBnYKCjkxoP5i7SAfkCIWH3vKJqMIcv/jMKRKqkSrnD0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794484151; c=relaxed/relaxed;
	bh=MKcG3X7dsKXAw4NNVjEt7ZV1vzPfMBBW0q4ysZTtxpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6XQZZinm/GV4KhtZgrUtEvS4/i6fuBCkM07AW3Z4p+Ya1GeYrVtcjrlG2dkyxfU4eMVZzvK3Zem+O8/3CVDlMbHHaKa4gk5c4q035kf2wcq9dGlIPIRLMTZd/VzlD/wnWH4ZD1euLwy7WquPqqpiiS1G5gZYH9Lja0j/6y3XykD9UHRHX1sNGAG8fsBzaE0h3ax4doI0bffGddhL4PT1Jo5my3lBbCVojgxbV209jJMsepsB61pKLjpHD3xMcU1N3+AyyNdqubfvhBJnefabpD3eoc+p4q+c1g/Aqz/rWVBzDGiHS7dCIKg37IEjsioIHYsiO4V+DUri3O+SjavPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiDyh9CS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiDyh9CS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJZY5WsPz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 22:49:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A11E66186E;
	Thu, 12 Nov 2026 11:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07851F00A05;
	Thu, 12 Nov 2026 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484147;
	bh=MKcG3X7dsKXAw4NNVjEt7ZV1vzPfMBBW0q4ysZTtxpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NiDyh9CSMf4fnMa1aXCvHZxu1XNPZLF0/Dl9XempRO4DnG2Rnv4Cg3GohFO4EBFz5
	 81EpjF4nYwMtW7DcmV9HhlhPBEuZxpj9uyD4iv4l+EKqjYt1CyiVf+ASqrTv29jCn3
	 vw7Cq+OEghXqj50p1/echU8vAtiEFP2pHx3+Q4f2zoGs8RITGhiQpBM9qNWaKvF/t9
	 ziJmXqbPJb/qA9zZhB4bk4YCtqBFzsbaLaPIXeFmU1UPyBqijY4Klvc2TZ7W6n9eeT
	 xG4p1Q4rF39lKl8yaiQimmWpvUVrLuHhJOiY8tpsIULS66Q4FRARKhqorLxL8+DzQm
	 tq7vXZ+PENnMA==
Date: Thu, 12 Nov 2026 13:48:58 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 2/6] mm: remove ARCH_NEEDS_KMAP_HIGH_GET
Message-ID: <avWnqt1E9ssKQDWt@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-3-arnd@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112112528.1116405-3-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:25:24PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Arm has stopped setting ARCH_NEEDS_KMAP_HIGH_GET, so this
> is handled using the same wrappers across all architectures
> now, which leaves room for simplification.
> 
> Replace lock_kmap()/unlock_kmap() with open-coded spinlocks
> and drop the now empty arch_kmap_local_high_get() and
> kmap_high_unmap_local() helpers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/highmem.c | 100 ++++++---------------------------------------------
>  1 file changed, 10 insertions(+), 90 deletions(-)

Nice :)

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


-- 
Sincerely yours,
Mike.

