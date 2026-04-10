Return-Path: <linuxppc-dev+bounces-19530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB4CF36BA5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 03:14:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsMNT31Txz2yZ6;
	Fri, 10 Apr 2026 13:14:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775790242;
	cv=none; b=WQg+F7MsZGOgZ54JQ59WvWiuwTqneYjLg8KosbiS7t1e0Ph6K/VcNu254xpq3f4xPCGDMk5mE3Bt6aKH43DWyLcWlSp26xiPp7qbd/Y4+MYiHFIfjIMQeiTFdH18yalccq+yzMOkxUb1VYCjviFZGiHCWUUL3PNOcwJoIKg4jR6vX+X1g0hrl8crzhLYR7A5+zdTRr/mdAkk6gFMe+eQCnINQxasCXjOZTga6t3cL5FNB4YNsuOZXqGqcTXf/Q/L1hTnEKjRAGc+wjPN3jalk38Itdz7FWYiPiztuG3FNVuXQrdjSL8r/Yxr8FZkcBmGdY69AaISHbGq/8+vOq23PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775790242; c=relaxed/relaxed;
	bh=A1MMLpCtWUIER2yB2khaeXpeJnU94ahgZaruTHZtRRM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=euuxdplKKppLMz1dlOK0wTy2PVKaMKuOAyAA8cVUF8LHAmsvnAMvRDWrzcf3owk+5wMQuEJOPOxvSl2lg+mmVuXnZ6hfMRDb1TpX4CyIe4+deBc6V3e0ZPos8ZkTjGfKW/Tz6MWkCt6SpDis/BOF6vp0km/cQYDCDdxYma6WCesxWfwWtIFlUv/s8XnjOqsTLk4OLgIUKS3FZeJOY+n0npqhTvgaevd95pXRoa6Q+5RgbTgjOap3LD5DAF1GqyPX9nyQJ1wxHMggy1HqLDdH2uh0vZ2/Lr1tnGLYCrYIEoi5AeAXqpTbWdKXvZOhOrOCn/COwKEpoXCeXe6VWhYz/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T/D7P0On; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=djbw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T/D7P0On;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=djbw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsM8J6ry3z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 13:04:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F401C60128;
	Fri, 10 Apr 2026 03:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C90C4AF09;
	Fri, 10 Apr 2026 03:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775790237;
	bh=Nwk8dytVxtAcRGL5pp2fXfwnyG0rAc7e4uC2d6AAYRg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T/D7P0OnXqHBDeQqj0h+GFE/3Xub3uNWD/H6IQFMt2AY/bVaKy+WmWuJnHHHPs4te
	 hV9xrnF3uDTri3QzZLfx5iXWWOJjOHraM49yvjYlNU4idQTQ+/Sm3e0QBl2DI93SWn
	 lV68Gq3HrDHSYteo85CoZZEXlSJugMUTCVv+QbvJPDu34f6X/8VLyYV6FTPQEDtclJ
	 ajyD2uqb/ZTUnOgDwjdDTl+pyVgJHVqYiR+gAIfeeejGfdPS8EzWxC8Kd1fe1Qw6HU
	 n0zDG+/IH8P7jUAey0rb5m9iJQ+QpVGqPHl1+NZdXdiwtZ0yCDj1wYJccYYpDVlwtg
	 segn4CgTD+0SQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1DD50F4006C;
	Thu,  9 Apr 2026 23:03:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 23:03:55 -0400
X-ME-Sender: <xms:m2jYaVvuNB5v6GdnqhWjXHPrj-Xs1ai94wK3KRNupkgFhOqQzZzC3g>
    <xme:m2jYaUkpyJyCUCNgE74bnGCIbxEU2FOGFeTlPUTKpeQlSmmrwZCpKgaYK17P95KFr
    nEzX-ncsYgUTkO6FZme_rDCXDG2CwOa1VyCDjvXXLNAOHNJiDm0VQ>
X-ME-Received: <xmr:m2jYabd6-O1qxrmkpOxlYl4FVsVLLTtlO0FUgeKGKnisk32YMxXKA6ajLjBSsi4OwpBieBXg5XNaIMpiNH287KhulUeaVDZHAno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeehjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgt
    hheslhhsthdruggvpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshhonheslh
    hinhgrrhhordhorhhgpdhrtghpthhtohepmhgrthhtshhtkeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheplhhinhhmrghgjeesghhmrghilhdrtghomhdprhgtphhtthhopehlih
    hnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheptggrthgrlhhinhdr
    mhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m2jYaaC4G7STwDvUR7CS2sxLuhd9_4NTIflnGuzCDX01-Jgs4uT14w>
    <xmx:m2jYabFJVBuKmgUrK5OxBUlDqAvsZl1v-KMAzmE5eUIfVrz_tB9pMg>
    <xmx:m2jYaaX7R7qnh6LbNHm0_HED8Pa2kjuIJjs5gCHCF1o3NoJmwEhrDw>
    <xmx:m2jYaRZOO7FN7nulMEWiPxFetgPeGu3izX4XOgb9ubOxzrqmygE-lA>
    <xmx:m2jYaUDJMWByc2-YkX4kdjvhaEqEcInJJMajfYWN-Sgm8d1ZFIpInjBP>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 23:03:53 -0400 (EDT)
Date: Thu, 09 Apr 2026 20:03:52 -0700
From: Dan Williams <djbw@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Henderson <richard.henderson@linaro.org>,
  Matt Turner <mattst88@gmail.com>,  Magnus Lindholm <linmag7@gmail.com>,
  Russell King <linux@armlinux.org.uk>,
  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Ard Biesheuvel <ardb@kernel.org>,
  Huacai Chen <chenhuacai@kernel.org>,  WANG Xuerui <kernel@xen0n.name>,
  Madhavan Srinivasan <maddy@linux.ibm.com>,
  Michael Ellerman <mpe@ellerman.id.au>,
  Nicholas Piggin <npiggin@gmail.com>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,
  Heiko Carstens <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,
  Alexander Gordeev <agordeev@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,
  Sven Schnelle <svens@linux.ibm.com>,
  "David S. Miller" <davem@davemloft.net>,
  Andreas Larsson <andreas@gaisler.com>,
  Richard Weinberger <richard@nod.at>,
  Anton Ivanov <anton.ivanov@cambridgegreys.com>,
  Johannes Berg <johannes@sipsolutions.net>,
  Thomas Gleixner <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,
  Dave Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,
  "H. Peter Anvin" <hpa@zytor.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,
  Dan Williams <djbw@kernel.org>,  Chris Mason <clm@fb.com>,
  David Sterba <dsterba@suse.com>,  Arnd Bergmann <arnd@arndb.de>,
  Song Liu <song@kernel.org>,  Yu Kuai <yukuai@fnnas.com>,
  Li Nan <linan122@huawei.com>,  Theodore Ts'o <tytso@mit.edu>,
  "Jason A. Donenfeld" <Jason@zx2c4.com>,  linux-alpha@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  loongarch@lists.linux.dev,  linuxppc-dev@lists.ozlabs.org,
  linux-riscv@lists.infradead.org,  linux-s390@vger.kernel.org,
  sparclinux@vger.kernel.org,  linux-um@lists.infradead.org,
  linux-crypto@vger.kernel.org,  linux-btrfs@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-raid@vger.kernel.org
Message-ID: <69d86898b666c_2b31100cd@djbw-dev.notmuch>
In-Reply-To: <20260327061704.3707577-23-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
 <20260327061704.3707577-23-hch@lst.de>
Subject: Re: [PATCH 22/28] xor: add a better public API
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
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
> xor_blocks is very annoying to use, because it is limited to 4 + 1
> sources / destinations, has an odd argument order and is completely
> undocumented.
> 
> Lift the code that loops around it from btrfs and async_tx/async_xor into
> common code under the name xor_gen and properly document it.

Apologies for the latency on taking a look at this set from me. This and
the touch to async_xor() look good.

Reviewed-by: Dan Williams <djbw@kernel.org>

