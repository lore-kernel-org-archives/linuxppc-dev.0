Return-Path: <linuxppc-dev+bounces-18342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58907103E162
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:58:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbQml74Cmz2ygT;
	Wed, 18 Mar 2026 21:58:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773831527;
	cv=none; b=nPzDWqC4NnrUjjjnIhPo3Hck6RAajC1Cs2n0N0Sv4uY4qCAcbwg+Escftu7ByuoddxxPI3vy9/cAQlcwjZhVvReiuxHdtR7cpr3hqu2Tm/qKXUl/X7YXV/ysPc8ZZfVRZDY9XpZitdXHXpEkXWvDe/Ij8wNJ00bvxNB9wM6J+eVpxft5QUmz+xboj87wGHPzXF/l0oWtKScsurPftYLVJk4oYCMVXB+QCPvCqUm2wAjSuRF5xF8PmtFR7SyWc8RIDUVFmJ14cYIMwBWoQVt4dDXzGAonnPrzYHxe+idDxxYAZ1N+Le3jzA3S3/KRKpQBKAQZJ7bv84s4sDnWE0679Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773831527; c=relaxed/relaxed;
	bh=YpWbdmy2u35pquIoQDOkSYbA2SDw10dr75CUG2SUk9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBsRrs3LSrJABI7aVABcoSyk7Ny4s1EPgdixMezI8tv3HGEglVvfqPypHOH48RtOXhzu7ZPqhzM0lkt7Co8yq0u5GHxCZJHf27mru6PZIaGXI/q56RxEaGr+iPyv/ANzS+IowYDIKFy+ovQzp/WEZqNyzJ3/TIhXhsqSE8RFm5YqeNxkwo/D71eDWNztWg4xvIGINi2GCRaQlhFYD6dx0kXokm2JfAGMRiWYDhClt4/3Vvt33p/22lf7K228Jj6s4+4sBbWr2KY/eWDuI8zdKuRoMT6Ml+zyLxgFoj7b5KOibimzptDo/roue2FFheV6mMSG/jQaFQb+nqp/kKGwVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eKiMcZ85; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eKiMcZ85;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbQml1Hl6z2xlx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 21:58:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AC42B4474A;
	Wed, 18 Mar 2026 10:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65881C19421;
	Wed, 18 Mar 2026 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831521;
	bh=kLYySycm4Q+kO2x2jmLEs+z7oAnQtdjmqDIbHrWcbjw=;
	h=From:To:Cc:Subject:Date:From;
	b=eKiMcZ85WLFC8bXWA/cKx5AD46CSeZMTj7t+7hTK626aenEZLjVU/M1bTaE/8BRRS
	 X6S1Y6bTAssMWXPL91D/crg1FtPFmAE77lAntj2Q7m/PYz0wUHGJzu4AZOtr5VKYhD
	 O9x+2NB3x0e+Qee3RPqpqmkTck/x41t2dPoDUPGIkmdpXAuih590JlibeZmTDiQlQj
	 +q9tqVFXNLT50Bo4J93EDhzKNN36MtH2iOtNw1iebPTvJL5rSLJyP/H3K7GSINY4cU
	 Jl739DvgI4xC+TxFvGCyIhqDj4Pg7a/bTjrprZ63VJjVDKtRWfpfjBV+NYDfdH+Dsr
	 4yKWpa/0srIqQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
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
	x86@kernel.org
Subject: [PATCH 0/8] memblock: improve late freeing of reserved memory
Date: Wed, 18 Mar 2026 12:58:19 +0200
Message-ID: <20260318105827.1358927-1-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
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
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following a recent discussion about leaks in x86 EFI [1], I audited usage of
memblock_free_late() and free_reserved_area() and made some imporovements how
we handle late freeing of the memory allocated with memblock.

[1] https://lore.kernel.org/all/ec2aaef14783869b3be6e3c253b2dcbf67dbc12a.camel@kernel.crashing.org/

Mike Rapoport (Microsoft) (8):
  powerpc: fadump: pair alloc_pages_exact() with free_pages_exact()
  powerpc: opal-core: pair alloc_pages_exact() with free_pages_exact()
  mm: move free_reserved_area() to mm/memblock.c
  memblock: make free_reserved_area() more robust
  memblock: extract page freeing from free_reserved_area() into a helper
  memblock: make free_reserved_area() update memblock if ARCH_KEEP_MEMBLOCK=y
  memblock, treewide: make memblock_free() handle late freeing
  memblock: warn when freeing reserved memory before memory map is
    initialized

 arch/arm64/mm/init.c                       |   3 -
 arch/powerpc/kernel/fadump.c               |  16 +--
 arch/powerpc/platforms/powernv/opal-core.c |   9 +-
 arch/sparc/kernel/mdesc.c                  |   4 +-
 arch/x86/kernel/setup.c                    |   2 +-
 arch/x86/platform/efi/memmap.c             |   5 +-
 arch/x86/platform/efi/quirks.c             |   2 +-
 drivers/firmware/efi/apple-properties.c    |   2 +-
 drivers/of/kexec.c                         |   2 +-
 include/linux/memblock.h                   |   2 -
 init/initramfs.c                           |   7 --
 kernel/dma/swiotlb.c                       |   6 +-
 lib/bootconfig.c                           |   2 +-
 mm/internal.h                              |  10 ++
 mm/kfence/core.c                           |   4 +-
 mm/memblock.c                              | 110 ++++++++++++++-------
 mm/page_alloc.c                            |  46 ---------
 17 files changed, 102 insertions(+), 130 deletions(-)


base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
--
2.51.0

