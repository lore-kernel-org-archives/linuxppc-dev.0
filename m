Return-Path: <linuxppc-dev+bounces-27803-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E058C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 06:37:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpD6N3q8dz2xk7;
	Mon, 21 Sep 2026 16:37:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789972620;
	cv=none; b=cu9Q8ekaAbZvZqv/A/Vc+VMF0C61v2SrNnKtvC63peIoBCNOgnfGbHpRWJaGI7Wqy6+4Qsv85DmJHV8yVPkb8ZdwQVn5z+Ww8vc3ibcZGN6gweEyVXnnlJ/QyBSxgRhqNkmT6AiWXKMV9erA6DixeP5RS7L1W03eptWkdgHtMqlP5SO/99yoCp32E0gF+cjwFDS8LfSIeejVsBmQo/XnMYw9lrXWgxgCdZ9wQIynZxJBkbua0zHJadvSzeWr5fm3DqyClUmc871SVxm568GSowqysjwtrcjhBmHE4r/h6U/ovK7f2DIE/ivDd+LdFbskd/SUYspweCzRaeXj7wfUug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789972620; c=relaxed/relaxed;
	bh=R+xk4C4kNi+974cCDKa30TAiC73V15NHvprk7wFBCRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwZ1BzIaZ5FNcFWcU6o/6VxNv3DhPTUEyDGuLgrAVhOByGdSqkk17l/dnGQdtQcQP/PWAHoWI/OgeERdjgkDl2+qr6BOBpcC0oljtiGxDzF8gKGxewZcalKhQr0tT0IjwKOiLzgergU54ZnNLBsySgwgXN1wGqD+OMdd+JzIczOhDm2PIxYJmNf0zTnsBYbU2WnGRLXOib5DlRBORoj1dGh79V6tvD75o618WL9R/wT7o77+4CYF00/sUuCNqG1L66OzBEVRY/mYNlzhOSdaFGCKYrljfbuUoYMg5mmiywQgxdTWxTJyv89OIqB+H7Q4JSYTky41xUTo4gI96qskTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5EMJGDj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5EMJGDj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpD6L6v2Pz2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 16:36:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 15AC5600D1;
	Mon, 21 Sep 2026 06:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9871F00893;
	Mon, 21 Sep 2026 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972615;
	bh=R+xk4C4kNi+974cCDKa30TAiC73V15NHvprk7wFBCRE=;
	h=From:To:Cc:Subject:Date;
	b=n5EMJGDj+zLmxsPkZtyPhFMc5SdW91+kVGQKlZRGoEuRhgqy+jOXiC22FJZPTRnx/
	 8ZWNT+7XmAJ6Y8z2LQmLv24qXA8HLxeuIXm/OFyOPPDkdoznCOj0FcrWVciDQWhWPZ
	 r2BBS9zHeDeT40YsZcdE2X/nGO7Y+Pvl1UFRGID6F1kuxWb8hCPztYF6RvfyPIGzkN
	 44/ltkFkEuJwpg83+HSydVZOf9Xq5rOieR5Vczi3Cxy3yVrWkPRZCX/sDeOksdaSHq
	 noytLDOn+2WCcSM2Fxmcpi0kB7rsuWtI2CLNMRjSWllNrf1MYOx4tv5psHf8hAcATC
	 QRVreDt2BG9Bg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v5 0/6] dma: swiotlb: Centralize default pool policy and sizing
Date: Mon, 21 Sep 2026 12:06:22 +0530
Message-ID: <20260921063628.362078-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Hi,

This series centralizes swiotlb default-pool selection and sizing, and
simplifies the initialization flags used to describe pool placement.

The first patch replaces the addressing-limit argument with initialization
flags and introduces explicit policies for the different reasons a default
pool may be needed. Architectures now report DMA addressing constraints with
SWIOTLB_INIT_ADDRESSING_LIMIT, while the core selects the corresponding pool
policy.

The second patch moves the reduced sizing used when the pool is needed only
for unaligned kmalloc bouncing from arm64 and RISC-V into the swiotlb core.

The third patch centralizes swiotlb sizing for memory-encrypted systems. It
moves the existing x86 guest-sizing policy into the core. Host memory
encryption retains the normal pool size, and a shared default pool is not
selected solely for guest memory encryption when a restricted DMA pool is
present.

The fourth patch removes SWIOTLB_ANY. Pool placement is derived directly from
SWIOTLB_INIT_ADDRESSING_LIMIT: pools required for limited DMA addressing are
allocated below the architecture's low address limit, while other pools may
be allocated anywhere in directly mapped memory. Xen continues to request a
pool explicitly with SWIOTLB_INIT_REMAP without imposing a low-address
constraint.

Changes from v4:
https://lore.kernel.org/all/20260914070135.313337-1-aneesh.kumar@kernel.org
* Collect Reviewed-by tags.
* Add a new patch, "dma: swiotlb: Track whether the pool size was explicitly set".
* Retain SWIOTLB_ANY usage for RISC-V until patch 6.
* Rename SWIOTLB_INIT_FORCE_DISABLE to SWIOTLB_INIT_DEFAULT_OFF.

Changes from v3:
https://lore.kernel.org/all/20260904101810.1193505-1-aneesh.kumar@kernel.org
* Add a new patch, "dma: swiotlb: Add an overridable architecture pool opt-out".
* Clarify the change in default behavior with the removal of SWIOTLB_ANY.

Changes from v2:
https://lore.kernel.org/all/20260813102521.1367737-1-aneesh.kumar@kernel.org
* Rebase to latest tree.
* Drop SWIOTLB_ANY and derive that based on SWIOTLB_INIT_ADDRESSING_LIMIT
* Add SWIOTLB_INIT_REMAP.

v1:
https://lore.kernel.org/all/20260811134056.756015-1-aneesh.kumar@kernel.org

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>
Cc: Petr Tesarik <ptesarik@suse.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org

Aneesh Kumar K.V (Arm) (6):
  dma: swiotlb: Centralize default pool policy selection
  dma: swiotlb: Track whether the pool size was explicitly set
  dma: swiotlb: Centralize minimal pool sizing
  dma: swiotlb: Centralize memory-encryption pool sizing
  dma: swiotlb: Add an overridable architecture pool opt-out
  dma: swiotlb: Remove SWIOTLB_ANY

 Documentation/core-api/swiotlb.rst   |   8 +-
 arch/arm/mm/init.c                   |   6 +-
 arch/arm64/mm/init.c                 |  14 +-
 arch/loongarch/kernel/setup.c        |   2 +-
 arch/mips/cavium-octeon/dma-octeon.c |   2 +-
 arch/mips/loongson64/dma.c           |   2 +-
 arch/mips/sibyte/common/dma.c        |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
 arch/powerpc/mm/mem.c                |  17 ++-
 arch/powerpc/platforms/pseries/svm.c |  10 --
 arch/powerpc/sysdev/fsl_pci.c        |   1 +
 arch/riscv/mm/init.c                 |  24 +--
 arch/s390/mm/init.c                  |   2 +-
 arch/x86/include/asm/crash_reserve.h |   6 +-
 arch/x86/kernel/pci-dma.c            |  23 ++-
 arch/x86/mm/mem_encrypt.c            |  24 ---
 include/linux/swiotlb.h              |  21 ++-
 kernel/dma/swiotlb.c                 | 220 +++++++++++++++++++++------
 18 files changed, 248 insertions(+), 140 deletions(-)


base-commit: 704340f1cd0dcef829eb62f5b48ae95a2ce17bdf
-- 
2.43.0


