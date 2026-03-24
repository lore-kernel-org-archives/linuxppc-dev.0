Return-Path: <linuxppc-dev+bounces-18665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD561F532D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:23:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0Ms2lPzz2ykV;
	Tue, 24 Mar 2026 17:23:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774333385;
	cv=none; b=npU7jp3vetZQPeoNAPQO3VuaeMBFzuhCOftyFerPOnC2HK7sBzou63MQgTeupbKGEGhn6blXOmCNcWcZfhqhtQOQ2sHLxaxnNNuDpVhl0bXVlbJnKqHklHcogxxHJ6LvAK+D/ASWdUc+e9DIVMbnZqKoI6bxncOumnJeXjWxTLOdh+A0JJXwp2T5AxMLIHIRcnHEI1tivpjMIA87QDigYr1RSup10U12xm9gvhXveiEJG2pHtiOcMDZv0hu9F4JEZBiQh3cdtTCnGWtr/RlnINImsT7WOKiL2f4iDZCJPNREgGqSg8kq+ZJpnY4zsgzDQEF24YIJkCAn3X2WeHNpag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774333385; c=relaxed/relaxed;
	bh=llZo5AuQgKfnTDSRj0qABwj+a0z1LvEOtH9cegApi48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BykHXq6mDSiypG/whlPreLAV4IBYdBBT1NEjDEUbsqSxyzTJHrU86fFSoLVKffbkbmN2XZM4byAHNqQNgJHgYYzexqQfdbDMjQvXPGd7klbuiGLWUoCHmAziDeVq4W9QN4Jxq/YgAjbihiRal2iXqmTGJ/Y8H/qy8td2yih/GI+AhiXHm7jesQ0vxPeWckK+Zym6E91vr1cRUE+SavvQfdsPGCkjP2/f5xy9lCtR7qbKQH9a6Y4pXu66bi/NrwtTbY1X2VsYAwp/quIrx7vrNsuO4XFBR8s41HVx3BVKjF5BNRylYO8W8mYAEWL/UJzzeFV2Ii+j5CGkwWXgUbOvmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c65a7z7Q; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c65a7z7Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0Mq2Lwkz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:23:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=llZo5AuQgKfnTDSRj0qABwj+a0z1LvEOtH9cegApi48=; b=c65a7z7QGulg3ZLt9fovvHDcTw
	ZbNOrHtwwGpRemcCz9CWHiJ3Ei2dTofnWWPUL3uUXteeZ8o4CHqd3da+QlqLH8NFQL7+6DxGYY7x/
	ISh83YpgQoFnaMoWYlk1wLHj1Op7kAZwuQikkXrMfcuGzOKD62v6gHZ+2Uxzk4wjwUmL55wqdwWGr
	IUkEuJt/x9DI3icLegpslpm2STLooEogQ9Js9TWsnJBxhBFyaFyZMs/6zvfKcL4tEJRvDHxUd8kBd
	vu03BtS4rMfzdxhHi3ti00AmlupX42OVlGsUDyVcj2JfI7viG3M60ZNS78+dMo3Z7I2Ah04DFsGUu
	c5dVM7YA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4v9l-00000000ggz-358i;
	Tue, 24 Mar 2026 06:22:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: cleanup the RAID5 XOR library v3
Date: Tue, 24 Mar 2026 07:21:36 +0100
Message-ID: <20260324062211.3216301-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

the XOR library used for the RAID5 parity is a bit of a mess right now.
The main file sits in crypto/ despite not being cryptography and not
using the crypto API, with the generic implementations sitting in
include/asm-generic and the arch implementations sitting in an asm/
header in theory.  The latter doesn't work for many cases, so
architectures often build the code directly into the core kernel, or
create another module for the architecture code.

Changes this to a single module in lib/ that also contains the
architecture optimizations, similar to the library work Eric Biggers
has done for the CRC and crypto libraries later.  After that it changes
to better calling conventions that allow for smarter architecture
implementations (although none is contained here yet), and uses
static_call to avoid indirection function call overhead.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git xor-improvements

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements

Changes since v2:
 - drop use of CONFIG_KERNEL_MODE_NEON for arm64
 - drop the new __limit_random_u32_below for the unit test
 - require 64-bit alignment because sparc64 requires it
 - use DEFINE_STATIC_CALL_NULL to avoid exposing a specific xor_gen
   routine
 - keep CONFIG_XOR_BLOCKS_ARCH self-contained in lib/raid/
 - don't select library option from kunit test and add a .kunitconfig
   instead
 - fix the module description for the kunit test
 - add a case where buffers are at the end of the allocation in the kunit test
 - use separate src/dst alignment in the kunit test
 - fix and improve the kunit assert message

Changes since v1:
 - use lockdep_assert_preemption_enabled()
 - improve the commit message for the initial um xor.h cleanup
 - further clean up the um arch specific header
 - add SPDX identifier to the new build system files
 - use bool for xor_forced
 - fix an incorrect printk level conversion from warn to info
 - include xor_impl.h in xor-neon.c
 - remove unused exports for riscv
 - simply move the sparc code instead of splititng it
 - simplify the makefile for the x86-specific implementations
 - remove stray references to xor_blocks in crypto/async_tx
 - rework __DO_XOR_BLOCKS to avoid (theoretical) out of bounds references
 - improve the kerneldoc API documentration for xor_gen()
 - spell the name of the srcs argument to xor_gen correctly in xor.h
 - add a kunit test, and a new random helper for it.

Diffstat:
 arch/arm64/include/asm/xor.h              |   73 --
 arch/loongarch/include/asm/xor.h          |   68 --
 arch/loongarch/include/asm/xor_simd.h     |   34 -
 arch/loongarch/lib/xor_simd_glue.c        |   72 --
 arch/powerpc/include/asm/xor.h            |   47 -
 arch/powerpc/include/asm/xor_altivec.h    |   22 
 arch/powerpc/lib/xor_vmx.h                |   22 
 arch/powerpc/lib/xor_vmx_glue.c           |   63 --
 arch/riscv/include/asm/xor.h              |   68 --
 arch/s390/include/asm/xor.h               |   21 
 arch/sparc/include/asm/xor.h              |    9 
 arch/um/include/asm/xor.h                 |   24 
 arch/x86/include/asm/xor_64.h             |   28 -
 b/arch/arm/lib/Makefile                   |    5 
 b/arch/arm64/lib/Makefile                 |    6 
 b/arch/loongarch/lib/Makefile             |    2 
 b/arch/powerpc/lib/Makefile               |    5 
 b/arch/riscv/lib/Makefile                 |    1 
 b/arch/s390/lib/Makefile                  |    2 
 b/arch/sparc/include/asm/asm-prototypes.h |    1 
 b/arch/sparc/lib/Makefile                 |    2 
 b/crypto/Kconfig                          |    2 
 b/crypto/Makefile                         |    1 
 b/crypto/async_tx/async_xor.c             |   34 -
 b/fs/btrfs/raid56.c                       |   27 -
 b/include/asm-generic/Kbuild              |    1 
 b/include/linux/raid/xor.h                |   27 -
 b/lib/Kconfig                             |    1 
 b/lib/Makefile                            |    2 
 b/lib/raid/.kunitconfig                   |    3 
 b/lib/raid/Kconfig                        |   30 +
 b/lib/raid/Makefile                       |    3 
 b/lib/raid/xor/Makefile                   |   42 +
 b/lib/raid/xor/alpha/xor.c                |   46 -
 b/lib/raid/xor/alpha/xor_arch.h           |   22 
 b/lib/raid/xor/arm/xor-neon-glue.c        |   19 
 b/lib/raid/xor/arm/xor-neon.c             |   22 
 b/lib/raid/xor/arm/xor.c                  |  105 ----
 b/lib/raid/xor/arm/xor_arch.h             |   22 
 b/lib/raid/xor/arm64/xor-neon-glue.c      |   26 +
 b/lib/raid/xor/arm64/xor-neon.c           |   94 +--
 b/lib/raid/xor/arm64/xor-neon.h           |    6 
 b/lib/raid/xor/arm64/xor_arch.h           |   21 
 b/lib/raid/xor/loongarch/xor_arch.h       |   33 +
 b/lib/raid/xor/loongarch/xor_simd_glue.c  |   37 +
 b/lib/raid/xor/powerpc/xor_arch.h         |   22 
 b/lib/raid/xor/powerpc/xor_vmx.c          |   40 -
 b/lib/raid/xor/powerpc/xor_vmx.h          |   10 
 b/lib/raid/xor/powerpc/xor_vmx_glue.c     |   28 +
 b/lib/raid/xor/riscv/xor-glue.c           |   25 +
 b/lib/raid/xor/riscv/xor.S                |    4 
 b/lib/raid/xor/riscv/xor_arch.h           |   17 
 b/lib/raid/xor/s390/xor.c                 |   15 
 b/lib/raid/xor/s390/xor_arch.h            |   13 
 b/lib/raid/xor/sparc/xor-sparc32.c        |   32 -
 b/lib/raid/xor/sparc/xor-sparc64-glue.c   |   48 -
 b/lib/raid/xor/sparc/xor-sparc64.S        |   10 
 b/lib/raid/xor/sparc/xor_arch.h           |   35 +
 b/lib/raid/xor/tests/Makefile             |    3 
 b/lib/raid/xor/tests/xor_kunit.c          |  187 +++++++
 b/lib/raid/xor/um/xor_arch.h              |    2 
 b/lib/raid/xor/x86/xor-avx.c              |   52 --
 b/lib/raid/xor/x86/xor-mmx.c              |  120 +---
 b/lib/raid/xor/x86/xor-sse.c              |  105 +---
 b/lib/raid/xor/x86/xor_arch.h             |   36 +
 b/lib/raid/xor/xor-32regs-prefetch.c      |  267 ++++++++++
 b/lib/raid/xor/xor-32regs.c               |  217 ++++++++
 b/lib/raid/xor/xor-8regs-prefetch.c       |  146 +++++
 b/lib/raid/xor/xor-8regs.c                |  103 ++++
 b/lib/raid/xor/xor-core.c                 |  192 +++++++
 b/lib/raid/xor/xor_impl.h                 |   56 ++
 crypto/xor.c                              |  174 -------
 include/asm-generic/xor.h                 |  738 ------------------------------
 73 files changed, 1831 insertions(+), 2067 deletions(-)

