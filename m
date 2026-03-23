Return-Path: <linuxppc-dev+bounces-18599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43EEC01A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:48:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQKL0P86z2yZN;
	Mon, 23 Mar 2026 18:48:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252133;
	cv=none; b=daO4gRJkyIbxCrIFWHhAf+Y34FIOeV7qCyaWYjLSoSUL6TnpirDBrf37QULwgtPx1UM+xAsQkYQ+r6wwbKup0lMQhCDp068ce+woHhY9txKbpki4a6baWgBk1aHFS5ipfTwsSN1Iq2SGO1PhAFFGxFHj3K8adHkX1uBS9IR27zoYWZa24LZTtjTpa8bSAcbkoSO5TU6rDl2NzxZEeKFEfn9Zpy4GHvi2wzz2ypsNA8u7VUz+5NXdMeEh5thh7OqGiFGBg3ARPPrI7IFHQIOS7R7GFmLY6wVVj3P2ry3rF90t1gySRFrY1a+tkEFWrEkuvR0VH3ej5ANrxfSGLb8q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252133; c=relaxed/relaxed;
	bh=IytCGZb8QoqUKOg+ctT1e1Ezzg+jN0P1FskdLA5DESs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3wzgZN+Wtvk5wnyNZGDPyro1o9JD0LTRafE1/FbSZnhic5QjLXdOLRneAsjGddnZfOVx18QOu6Jm+ufDjyPwojeZuAls6M7ANEp6wJrwETQ3AHVYovwtEAZl942gqWxRMLZ3tWwIYBlBCAjL2zoZPnx2BUJUqN9PyJqQQiCSnQOsUOkBvlxXzuWLzqMfZKcCn6oi7SiDRcQ1+CqZBuzGK3yzZp6MZWwo8s3M2UB5j+lVEFqPT24zDFhpg5V7kPU0gaOyGcOjDa7zQe6X8JfLPqwObWt8BJ8i/rTV5dLqwaSYG6I1JwXuxhNySLW97PZmOLM8wbt9TX6OSnGCDoCFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rlv1S8+0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rlv1S8+0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQKJ6qV9z2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:48:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B58BB600C4;
	Mon, 23 Mar 2026 07:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC71BC4CEF7;
	Mon, 23 Mar 2026 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252130;
	bh=pCbilTTHI/VwIdYALA976lc/t17gtYFZ5ukjoWq9Zt0=;
	h=From:To:Cc:Subject:Date:From;
	b=Rlv1S8+0zQURdG9YTxr4y3pNRy8/ylu6kZZ6eCiQf+sFd02KfS8+YNnbcyhsi4jov
	 S5w11oK7YTX3gkuWTcyu3hCCiTiR3veT8ei69ieEMGgMa2ZYMUeINhQjyhnr9FSaE8
	 Uj98YvIFa19EU/fOo55YccuDjUkb9MArMrSqYZ/sLc3WXjjEkYT/en9m3MbKASypiu
	 mxy2taD/9hMXzY7nvOCde6k5j3T9Mi98SQf3en8jrYNH2nRMr3fIiwj2mujYUhGjba
	 bnwQO6qLYjo9aQPPjQMfazIbKXhjL7hgiC8xGbSCEvOmYFBujPtB+XyBem0ZCuxVV4
	 bFbyai2HlbXwg==
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
Subject: [PATCH v2 0/9] memblock: improve late freeing of reserved memory
Date: Mon, 23 Mar 2026 09:48:27 +0200
Message-ID: <20260323074836.3653702-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
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

v2 changes:
* fix UAF issue in memblock_discard() reported by 0day and sashiko
* address relevant sashiko comments
* squash memblock test stubs changes into the commit with core updates

v1: https://lore.kernel.org/all/20260318105827.1358927-1-rppt@kernel.org

Mike Rapoport (Microsoft) (9):
  memblock: reserve_mem: fix end caclulation in reserve_mem_release_by_name()
  powerpc: fadump: pair alloc_pages_exact() with free_pages_exact()
  powerpc: opal-core: pair alloc_pages_exact() with free_pages_exact()
  mm: move free_reserved_area() to mm/memblock.c
  memblock: make free_reserved_area() more robust
  memblock: extract page freeing from free_reserved_area() into a helper
  memblock: make free_reserved_area() update memblock if ARCH_KEEP_MEMBLOCK=y
  memblock, treewide: make memblock_free() handle late freeing
  memblock: warn when freeing reserved memory before memory map is initialized

 arch/arm64/mm/init.c                       |   3 -
 arch/powerpc/kernel/fadump.c               |  16 +--
 arch/powerpc/platforms/powernv/opal-core.c |  11 +-
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
 mm/memblock.c                              | 124 +++++++++++++++------
 mm/page_alloc.c                            |  46 --------
 tools/include/linux/mm.h                   |   1 +
 tools/testing/memblock/internal.h          |  34 +++++-
 19 files changed, 144 insertions(+), 139 deletions(-)


base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.53.0


