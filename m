Return-Path: <linuxppc-dev+bounces-16802-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B851CEB2719
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:32:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9vr21tl5z2xlp;
	Wed, 11 Feb 2026 21:32:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770805922;
	cv=none; b=dP6USfHUYnsjaEtXk+LxKpRWhL5KBMJeRu9SrY98yc6lnxaD0cAW0hgiH4cwApif+/m8HcYKKq7QN9HOxuMGgwcRmHAFHriRXeTF4vjcadHiXu1SQuBWU27qGyBix42/utIQT1HKsCDbp/HODJfjF2uwrfSubeZi22wt3zr4jReNIozfTPScGLb5+5LCvTEQjzIdRrJm48KFyzF5wzGF83w7Ez9+bwS9vSgQ6++9uWYsED32aRzt4gEWcl/dbyi+08TBCnpwqXwA2wO/zWPLoNb6pPUvsmkNZyx0ha2Gy2A+0mIjg4UsdGiDBHZMko18/3XLPmM+R3VowDAbpQzBww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770805922; c=relaxed/relaxed;
	bh=icF2+PwVaSY7S9HGXldpzB+lF1cDxRtpf0+cMzX32GE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1iWvvsb1V3S53ThUoBCPtWvtj9FeyRLnBvBfObol3skapXKndSwyO4iZKuMxoktksHJF1pFFqz4uC6OPNSE/M4k49KRU/RcXtmTph52Gj/pQWzpHY+iSYO6a/NXpdcplz/Wi5ZRNLNJqYhlzjIWs+bj8oQbHnWx21WQmpw1pWbfbrNXU6I58Scn57lZE2GslMmxEn6q6zH5048akNmuq5D/+ApfIYiJU3b6s1/XIZQxJfdm+3Jx1c1KsG7hWuinWkVY0im2eAW/jMdM+R0cotcWgoLo5Kny2177pOW107NqiBgE9x93g9IYB7rpFSW5taZJNOofZCGYmabMcyE3ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PV/jXKpF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PV/jXKpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9vr110PQz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 21:32:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 80DAE43D75;
	Wed, 11 Feb 2026 10:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D364AC19421;
	Wed, 11 Feb 2026 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770805918;
	bh=BzPjss/o79E8vniYif3vhWCcMbpnh+bfpm0PwJifv0s=;
	h=From:To:Cc:Subject:Date:From;
	b=PV/jXKpFwT8Fev+iuIdzwDQGCp1d9tQZwQOxpL0LXiHzOkF4CIyDk3VR8KHKDtHPW
	 95broCDwDG6FDa0dsrh08bvjDtJvEVi+8U3bdfQGt0/3GFehuGtNXEfr5rcfZqIyHe
	 4Gas0OFpDJ0b6cdfz9zvpAFeNg4A3xRSvqWBEmxAoCac9/v12nM5/tozP4vCWoIt3t
	 WM1Df8XDDZbZ4yrkjS35IzQoTegVuVT5cx/AIkgGipbvq47QF+8iCUbZqSYaNcR9kd
	 /L0GUWtHeBli4O4MUGnMTsxwsezchH/soEQNYXQrx3YIGnwJ/R226FAA4/HIBChyBn
	 bpfII91wxqjeA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v3 0/4] arch, mm: consolidate empty_zero_page
Date: Wed, 11 Feb 2026 12:31:37 +0200
Message-ID: <20260211103141.3215197-1-rppt@kernel.org>
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

These patches cleanup handling of ZERO_PAGE() and zero_pfn.

v3 changes:
* move zero_page_pfn extern declaration back inside the helpers
* add tags, thanks all!

v2: https://lore.kernel.org/all/20260209144058.2092871-1-rppt@kernel.org
* add patches that cleanup zero_pfn code a bit (patches 1,2)
* add a patch that caches struct page for empty_zero_page (patch 4)
* use uint8_t instead of unsigned long for empty_zero_page
* fix sparc64 changes in patch 3

v1: https://lore.kernel.org/all/20260124095628.668870-1-rppt@kernel.org

Mike Rapoport (Microsoft) (4):
  mm: don't special case !MMU for is_zero_pfn() and my_zero_pfn()
  mm: rename my_zero_pfn() to zero_pfn()
  arch, mm: consolidate empty_zero_page
  mm: cache struct page for empty_zero_page and return it from ZERO_PAGE()

 arch/alpha/include/asm/pgtable.h          |  6 ---
 arch/arc/include/asm/pgtable.h            |  3 --
 arch/arc/mm/init.c                        |  2 -
 arch/arm/include/asm/pgtable.h            |  9 -----
 arch/arm/mm/mmu.c                         |  7 ----
 arch/arm/mm/nommu.c                       |  7 ----
 arch/arm64/include/asm/pgtable.h          |  7 ----
 arch/arm64/mm/init.c                      |  5 +++
 arch/arm64/mm/mmu.c                       |  7 ----
 arch/csky/include/asm/pgtable.h           |  3 --
 arch/csky/mm/init.c                       |  3 --
 arch/hexagon/include/asm/pgtable.h        |  6 ---
 arch/hexagon/kernel/head.S                |  5 ---
 arch/hexagon/kernel/hexagon_ksyms.c       |  1 -
 arch/loongarch/include/asm/pgtable.h      |  9 -----
 arch/loongarch/mm/init.c                  |  3 --
 arch/m68k/include/asm/pgtable_mm.h        |  9 -----
 arch/m68k/include/asm/pgtable_no.h        |  7 ----
 arch/m68k/mm/init.c                       |  9 -----
 arch/m68k/mm/mcfmmu.c                     |  2 -
 arch/m68k/mm/motorola.c                   |  6 ---
 arch/m68k/mm/sun3mmu.c                    |  2 -
 arch/microblaze/include/asm/pgtable.h     | 10 -----
 arch/microblaze/kernel/head.S             |  4 --
 arch/microblaze/kernel/microblaze_ksyms.c |  2 -
 arch/mips/mm/init.c                       | 11 +-----
 arch/nios2/include/asm/pgtable.h          |  7 ----
 arch/nios2/kernel/head.S                  | 10 -----
 arch/nios2/kernel/nios2_ksyms.c           |  1 -
 arch/openrisc/include/asm/pgtable.h       |  4 --
 arch/openrisc/kernel/head.S               |  3 --
 arch/openrisc/kernel/or32_ksyms.c         |  1 -
 arch/openrisc/mm/init.c                   |  3 --
 arch/parisc/include/asm/pgtable.h         | 11 ------
 arch/parisc/mm/init.c                     |  6 ---
 arch/powerpc/include/asm/pgtable.h        |  6 ---
 arch/powerpc/mm/mem.c                     |  3 --
 arch/riscv/include/asm/pgtable.h          |  7 ----
 arch/riscv/mm/init.c                      |  4 --
 arch/s390/mm/init.c                       |  4 +-
 arch/sh/include/asm/pgtable.h             |  8 ----
 arch/sh/include/asm/setup.h               |  3 +-
 arch/sh/kernel/head_32.S                  |  4 +-
 arch/sh/kernel/sh_ksyms_32.c              |  1 -
 arch/sh/mm/init.c                         |  1 -
 arch/sparc/include/asm/pgtable_32.h       |  8 ----
 arch/sparc/include/asm/pgtable_64.h       |  3 --
 arch/sparc/include/asm/setup.h            |  2 -
 arch/sparc/kernel/head_32.S               |  7 ----
 arch/sparc/mm/init_32.c                   |  4 --
 arch/sparc/mm/init_64.c                   | 24 +++++-------
 arch/um/include/asm/pgtable.h             |  9 -----
 arch/um/include/shared/kern_util.h        |  1 -
 arch/um/kernel/mem.c                      | 16 --------
 arch/um/kernel/um_arch.c                  |  1 -
 arch/x86/include/asm/pgtable.h            |  8 ----
 arch/x86/kernel/head_32.S                 |  4 --
 arch/x86/kernel/head_64.S                 |  7 ----
 arch/x86/kvm/mmu/spte.h                   |  2 +-
 arch/xtensa/include/asm/pgtable.h         |  4 --
 arch/xtensa/kernel/head.S                 |  3 --
 arch/xtensa/kernel/xtensa_ksyms.c         |  2 -
 fs/dax.c                                  |  2 +-
 fs/proc/vmcore.c                          |  2 +-
 include/linux/pgtable.h                   | 48 ++++++++++++++---------
 mm/huge_memory.c                          |  2 +-
 mm/memory.c                               | 15 +------
 mm/migrate.c                              |  2 +-
 mm/mm_init.c                              | 28 +++++++++++++
 mm/userfaultfd.c                          |  4 +-
 70 files changed, 86 insertions(+), 354 deletions(-)


base-commit: 50c7f34c5c7403a12003c6759f6f6ca9a5a10872
--
2.51.0

*** BLURB HERE ***

Mike Rapoport (Microsoft) (4):
  mm: don't special case !MMU for is_zero_pfn() and my_zero_pfn()
  mm: rename my_zero_pfn() to zero_pfn()
  arch, mm: consolidate empty_zero_page
  mm: cache struct page for empty_zero_page and return it from
    ZERO_PAGE()

 arch/alpha/include/asm/pgtable.h          |  6 ---
 arch/arc/include/asm/pgtable.h            |  3 --
 arch/arc/mm/init.c                        |  2 -
 arch/arm/include/asm/pgtable.h            |  9 ----
 arch/arm/mm/mmu.c                         |  7 ----
 arch/arm/mm/nommu.c                       |  7 ----
 arch/arm64/include/asm/pgtable.h          |  7 ----
 arch/arm64/mm/init.c                      |  5 +++
 arch/arm64/mm/mmu.c                       |  7 ----
 arch/csky/include/asm/pgtable.h           |  3 --
 arch/csky/mm/init.c                       |  3 --
 arch/hexagon/include/asm/pgtable.h        |  6 ---
 arch/hexagon/kernel/head.S                |  5 ---
 arch/hexagon/kernel/hexagon_ksyms.c       |  1 -
 arch/loongarch/include/asm/pgtable.h      |  9 ----
 arch/loongarch/mm/init.c                  |  3 --
 arch/m68k/include/asm/pgtable_mm.h        |  9 ----
 arch/m68k/include/asm/pgtable_no.h        |  7 ----
 arch/m68k/mm/init.c                       |  9 ----
 arch/m68k/mm/mcfmmu.c                     |  2 -
 arch/m68k/mm/motorola.c                   |  6 ---
 arch/m68k/mm/sun3mmu.c                    |  2 -
 arch/microblaze/include/asm/pgtable.h     | 10 -----
 arch/microblaze/kernel/head.S             |  4 --
 arch/microblaze/kernel/microblaze_ksyms.c |  2 -
 arch/mips/mm/init.c                       | 11 +----
 arch/nios2/include/asm/pgtable.h          |  7 ----
 arch/nios2/kernel/head.S                  | 10 -----
 arch/nios2/kernel/nios2_ksyms.c           |  1 -
 arch/openrisc/include/asm/pgtable.h       |  4 --
 arch/openrisc/kernel/head.S               |  3 --
 arch/openrisc/kernel/or32_ksyms.c         |  1 -
 arch/openrisc/mm/init.c                   |  3 --
 arch/parisc/include/asm/pgtable.h         | 11 -----
 arch/parisc/mm/init.c                     |  6 ---
 arch/powerpc/include/asm/pgtable.h        |  6 ---
 arch/powerpc/mm/mem.c                     |  3 --
 arch/riscv/include/asm/pgtable.h          |  7 ----
 arch/riscv/mm/init.c                      |  4 --
 arch/s390/mm/init.c                       |  4 +-
 arch/sh/include/asm/pgtable.h             |  8 ----
 arch/sh/include/asm/setup.h               |  3 +-
 arch/sh/kernel/head_32.S                  |  4 +-
 arch/sh/kernel/sh_ksyms_32.c              |  1 -
 arch/sh/mm/init.c                         |  1 -
 arch/sparc/include/asm/pgtable_32.h       |  8 ----
 arch/sparc/include/asm/pgtable_64.h       |  3 --
 arch/sparc/include/asm/setup.h            |  2 -
 arch/sparc/kernel/head_32.S               |  7 ----
 arch/sparc/mm/init_32.c                   |  4 --
 arch/sparc/mm/init_64.c                   | 24 ++++-------
 arch/um/include/asm/pgtable.h             |  9 ----
 arch/um/include/shared/kern_util.h        |  1 -
 arch/um/kernel/mem.c                      | 16 -------
 arch/um/kernel/um_arch.c                  |  1 -
 arch/x86/include/asm/pgtable.h            |  8 ----
 arch/x86/kernel/head_32.S                 |  4 --
 arch/x86/kernel/head_64.S                 |  7 ----
 arch/x86/kvm/mmu/spte.h                   |  2 +-
 arch/xtensa/include/asm/pgtable.h         |  4 --
 arch/xtensa/kernel/head.S                 |  3 --
 arch/xtensa/kernel/xtensa_ksyms.c         |  2 -
 fs/dax.c                                  |  2 +-
 fs/proc/vmcore.c                          |  2 +-
 include/linux/pgtable.h                   | 51 +++++++++++++++--------
 mm/huge_memory.c                          |  2 +-
 mm/memory.c                               | 15 +------
 mm/migrate.c                              |  2 +-
 mm/mm_init.c                              | 28 +++++++++++++
 mm/userfaultfd.c                          |  4 +-
 70 files changed, 89 insertions(+), 354 deletions(-)


base-commit: 50c7f34c5c7403a12003c6759f6f6ca9a5a10872
--
2.51.0

