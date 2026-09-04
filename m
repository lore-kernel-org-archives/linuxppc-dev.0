Return-Path: <linuxppc-dev+bounces-26548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86629C624D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:18:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbsqs0nxMz2y2K;
	Fri, 04 Sep 2026 20:18:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788517113;
	cv=none; b=jK4aktM4coM4deodG1JQXIXO5aEf1CdRxbNdwy8r2U8N85uVx1p/BNQhnqb/FjGyAyFBY5n2jbEHNXVsDSH3fvzGhPkj9TjxSsz5wfEKOFvCDguN2dWrKGFvSkI6WgYW37Cr5I4U7XLdW7TBT4y/NF+EHfo1d9KjsuC9UvbCuWXE/a55Y7eWsKmC5xYB0E4fDZX8QxP3VtJTVvPo3B059MFd+/hBMPq6m6yuym5493xKLTqip72kdsDDUojDbwBrcO21IHXheRkuUb38c32f58SPLVwRXf9tl8FSb6BVtvd6mmSeNWXL3J/XDmsvzoPhGsuq6FLLXx7GbuYdbDEW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788517113; c=relaxed/relaxed;
	bh=tw800+P4uDfhJ9ocmTWTBk5vEmN83SP+jsZApX/yv74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YeZOkYhZjbqGUzqojOulu5Ws7KuZfY/tV20ZsFc2eSmM/Xe4AS8dHNO7s5Bw07kwsvnvSpvSAarqSgXedsa1upLcDtpO+HvU+kjwQv49VSZD2TSzAyPJ+T5J8Ovm/xWrg+8+6CXzG7xFYJf0jf3Vo4QGulFLMgmkg8cH7IbHecI7R+DsJQ8YQ5iaJoQRsmBWlE0Qyc9eCDrDi0x4ziGKAGAHTeeBw5PXvqAhOsTAIr+a1KN/2O+iIPNnfooq40jeK/kmUKyY1biDtTFgZRkGfj0tC9s1MI+8PE1GxlvdkGREOT96X1cgS3nzB5GxBjXTZOv4r5sx4LnASImEfaIHvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeD6Tsvu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeD6Tsvu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbsqr1vK5z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 20:18:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DFFB160216;
	Fri,  4 Sep 2026 10:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583791F00A3D;
	Fri,  4 Sep 2026 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517109;
	bh=tw800+P4uDfhJ9ocmTWTBk5vEmN83SP+jsZApX/yv74=;
	h=From:To:Cc:Subject:Date;
	b=VeD6TsvuxNdszngd9kfRSkBJ6wa+qxTTVLQDoCKpXCgqM3cJiEvokNzjA3rxoeTTi
	 MKqpiukio34QjfY74UOEleZKzmBCDhEaOZgLRF4nsRgjo4boReS7dBvvdH4L+8Agv/
	 UheiOOtvWR52mJOsspkre/rzDUAGWb3jaigazXbTkTsVmbDmSEcuYr5Hlzbmoao8M5
	 XdMkR1WsmH8Z0lfPojuOIreL3BXvH0yzmNvftiKypljjLqP4B89FE8ETuLNdYr1W4t
	 GG3OxFHpAe6m/5nn8gwJDaHkUMpXRtIRruqKlK+LFkd1ZB4xByDyS+dH2m8zWWMCIj
	 lPBfH2ns3cLUQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
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
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 0/4] dma: swiotlb: Centralize default pool policy and sizing
Date: Fri,  4 Sep 2026 15:48:06 +0530
Message-ID: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
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

Aneesh Kumar K.V (Arm) (4):
  dma: swiotlb: Centralize default pool policy selection
  dma: swiotlb: Centralize minimal pool sizing
  dma: swiotlb: Centralize memory-encryption pool sizing
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
 arch/x86/include/asm/crash_reserve.h |   4 +-
 arch/x86/include/asm/iommu.h         |   2 +
 arch/x86/kernel/amd_gart_64.c        |   1 +
 arch/x86/kernel/pci-dma.c            |  19 ++-
 arch/x86/mm/mem_encrypt.c            |  24 ---
 include/linux/swiotlb.h              |  19 ++-
 kernel/dma/swiotlb.c                 | 214 ++++++++++++++++++++-------
 20 files changed, 236 insertions(+), 141 deletions(-)


base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
-- 
2.43.0


