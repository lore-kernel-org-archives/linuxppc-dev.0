Return-Path: <linuxppc-dev+bounces-18764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0DCFEA835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 08:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fggd84sbPz2xMt;
	Wed, 25 Mar 2026 19:51:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774428716;
	cv=none; b=XenXgQhYZnAOCQlOHAqiWZshcr61Tqq+aCRUNqkYmNQH92IdRqaCS9d/1mjHSxArL5Da9+YMO7z8OFCiuhLyPCWzxWskLA1cd3KxyCGO3hh3mZHHil2QdkGXhqIlGot0xOxIIa5JuhfDbGC5Btogw15uxpPm+NsHhXkv01vilwk8QvUiISBbHm25MS7JpUkSZpJOuDfwRRqfZCP+Kt1gwDxoWxYz+6lZoWVVsiM73bZKDdZTS6xTOnBi3Y+ZF5ALn/1t117oFbPHF06EzPiw5VZY7Mj0lm2SMhaDkuNmAcBKJJKYjqLz4cfF+uqFUv2jXLMxyTi6GtMScTPrY00HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774428716; c=relaxed/relaxed;
	bh=728svDarDpybv6q7KG00Eki4xvaBhCJwwC+/P9iXkjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCKMOvEzEh8rNSCtpWtLCd+u5EseddTfFOPb4J2Co2fgvhg2r6mExb7Vsffy1EcBVPbK0Z5qbvkOJQui3oMV9cU0GUXA4UtHDwEHnGHLHaGmgYP4JL+GWnbGCUfOC4WLBX6pTKTI7eiMg5PqixHYiDyHjtl4n+38gJXOYDxdQiL0ru0vPrVYvpx3ePUUEid7iAlmNgVj/Aw4jYY1u/oUl1kAhepMrmq4ZGJzfVpxBUPx4S5f4BxjUURS1SIPQZLB8/uOrY/j71Oor//wkW0PJaOjA4ezypVNTJey2X8E+qIQBBpSz8n6s2n6fuQZFjlqUEnfawL7z5x4ii/GsmZYXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b1e3/Kii; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b1e3/Kii;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fggd75dkhz2xLv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 19:51:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33F004023D;
	Wed, 25 Mar 2026 08:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F3AC4CEF7;
	Wed, 25 Mar 2026 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774428713;
	bh=wb0mpku6g4vk6LeYoqKTVgZtD079ouSEG5afLG7CYHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1e3/Kii8oNvJgJ1AntUStWco7jvCebnWCtuv9zQCi2oUsNeV3CcabZ/VnDWT/4Bu
	 SdMcpnZUmux3R7PA238aj+buhQoQTRaRCXpWVo3lfGnlVNamvRsJHecUDO4uY4JETZ
	 xHJynwGclZ7csipkKUqwqfdSbhr2yZe/cHdAo7WUa3IRdxgN7vSItNWj8/2zpJM8+z
	 ZD01fhqLFQqk3slMEX+1PFlTdn7jeaS5TQm3vnMZ8RuoTjWtwNM3l4/A2ygJ2Hvbj0
	 HyR0HIfxv2d4zYS9GJNQyVlSryBTgfJVvw36EgMl3VIff5tJxeQAebFY0sT7kqzmW+
	 QsAWpfwuNt7wg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <jackmanb@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH v2 0/9] memblock: improve late freeing of reserved memory
Date: Wed, 25 Mar 2026 10:51:37 +0200
Message-ID: <177442863989.343689.8532363597437067519.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323074836.3653702-1-rppt@kernel.org>
References: <20260323074836.3653702-1-rppt@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 09:48:27 +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> Following a recent discussion about leaks in x86 EFI [1], I audited usage of
> memblock_free_late() and free_reserved_area() and made some imporovements how
> we handle late freeing of the memory allocated with memblock.
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[1/9] memblock: reserve_mem: fix end caclulation in reserve_mem_release_by_name()
      commit: ea459d3c24fefd90b60a702f4a73833434ae0248
[2/9] powerpc: fadump: pair alloc_pages_exact() with free_pages_exact()
      commit: 6e827110aea5fb9c53a5bf070413ffe5cad105b0
[3/9] powerpc: opal-core: pair alloc_pages_exact() with free_pages_exact()
      commit: 3cf80188ecb828ed034ba562614cf1d48156b126
[4/9] mm: move free_reserved_area() to mm/memblock.c
      commit: 0aa264cda784f9fbe1a80ef13144cf81610086c7
[5/9] memblock: make free_reserved_area() more robust
      commit: 456ac994018598bc57ceaacb8a2c72e722c9755b
[6/9] memblock: extract page freeing from free_reserved_area() into a helper
      commit: 40191dae9ed84c816b593bb1b36a80f86c2279d1
[7/9] memblock: make free_reserved_area() update memblock if ARCH_KEEP_MEMBLOCK=y
      commit: b9e028ca869de24df00206d7ec640380670fc38f
[8/9] memblock, treewide: make memblock_free() handle late freeing
      commit: 64cb853c2ab4d8bd25b965f05e33ac0c6672bae7
[9/9] memblock: warn when freeing reserved memory before memory map is initialized
      commit: c7fc9cde41be029cf6675befbafcbb2dab40b39b

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.


