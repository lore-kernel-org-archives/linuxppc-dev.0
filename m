Return-Path: <linuxppc-dev+bounces-21035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC9CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:18:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmL461S1z2yRF;
	Mon, 18 May 2026 15:18:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779081516;
	cv=none; b=mudJODh/+pUH7YDz+NvmbVTFoM/95Q/whF6g1HfzUelHnaBMs8V5v4xaMhnzSuSXY87bDTKoxpwl/LF57pFD08uFWF+vm7Ux25wWxVbQZ4qPurMZTok4ZbeYzV2OCNeS8NSVwBa2HjitXb+X4qqBuaB3Y0Zam4/7E6yDfeJMlyQ+RRQPWrCLByZzZXHZxk4q3KPSHnafuVKzuMmM4WV4rqEjJDE2LUtw6d2pBq2uy0Ce8IpV5/v3yA59P5KeqWVJGP21gmABilmd+Nrl6B7n/qf449YtuKXjdinMYIJr5J68FBcDBLpzaz2fn4aToWIHjPKEl1qiUKYYW4OwfkmCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779081516; c=relaxed/relaxed;
	bh=dwab+Vrf0RkpX4kATklkT0WVGxtwKqB/2sp1x4ycw+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n//NTuat8LcOmgxgAYU1bpI1MmNtybRlKxkG27O5ZU2xd4vnVm7A/iVWWaehb/gtYKXXXuarDJqx8BNVBd5+aum2ue4ljbuJ6gnnRGl4n6kRrexmbvhIjRcnON3TW52hIK6XK0XDGWloEIaDPPKoPC97yLa6wpG5FXhkXe00G/pq0WLTHCYT9C1O8jvqKNjP8C6TocsHyMNV/LcW7h03Zvk9kkPQVIEB6DXvhoL3Z58lCIJkZbIy9bzJ4zDbEetH9UBO+Dgs+EMdUYRc/Vo4jZ00tTpcNhcsKhGdJIVM5/FPI2PcC3hX3H12pKt0ROCkPo5uWNV/23it+GjToN9abg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p5/p7Jqh; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p5/p7Jqh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmL35ytCz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:18:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dwab+Vrf0RkpX4kATklkT0WVGxtwKqB/2sp1x4ycw+I=; b=p5/p7JqhZ+M4Mo+jYDHA8iQZq+
	AaXI3mG9RQD7KhF9ESo6nlZz4faGzgGwaXMiiWQksWQXg3C1vfUIWWi1lMctJmg70RGGz/ZHg6ZVW
	FoDczJXslwMYAhOhq7IvnRPGF8Q+07mwrA3SKGRNg5tpfaxPlJUeq9kDRj9NBwxQMKcEcZQfJLZeT
	ilBkdIXsKBQ44xVAYqUMcIatOyT6Sq+6f4PdiiMQWLXFd4vFFmCErzawf/0TBrK9+Xz5hGF4DHJC9
	Obcjgt3OjS0MU8Y6J1Acw2fEWjhYTupWVIiM8oe6JK/H4B2+efiMQ0rpnMBTqYWMHd/3LZOo0nlal
	NOS4eN9A==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqMr-0000000EFSf-3TrP;
	Mon, 18 May 2026 05:18:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: cleanup the RAID6 P/Q library v3
Date: Mon, 18 May 2026 07:17:43 +0200
Message-ID: <20260518051804.462141-1-hch@lst.de>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series cleans up the RAID6 P/Q library to match the recent updates
to the RAID 5 XOR library and other CRC/crypto libraries.  This includes
providing properly documented external interfaces, hiding the internals,
using static_call instead of indirect calls and turning the user space
test suite into an in-kernel kunit test which is also extended to
improve coverage.

Note that this changes registration so that non-priority algorithms are
not registered, which greatly helps with the benchmark time at boot time.
I'd like to encourage all architecture maintainers to see if they can
further optimized this by registering as few as possible algorithms when
there is a clear benefit in optimized or more unrolled implementations.

This series sits on top of the "cleanup the RAID5 XOR library v3" series.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git lib-raid6

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/lib-raid6

Changes since v2:
 - merge two patches that should have been one
 - split out enforcing the 4-device minimum into a well-documented patch
   explaining the rationale
 - drop the btrfs patch to restrict the number of devices again
 - fix them module description for the kunit test
 - add -I $(src) to fix out of srctree builds for architectures with
   headers in the architecture-specific directories
 - always add the least optimized/unrolled algorithms first to keep the
   existing no-benchmark behavior
 - drop the delayed benchmarking for now to avoid corner cases
 - improve a few commit messages

Changes since v1:
 - fix arm64 objdir != srcdir builds
 - call the kunit module raid6_kunit.ko from the beginning
 - update MAINTAINERS
 - don't require preemptible context and apply the same restrictions as
   the merged version of the XOR API
 - fix the arm64 default in Kconfig
 - pick the last registered (and presumably most optimized) algorithm when
   benchmarking is disabled
 - port over the randomization fixes from the XOR series
 - misc other kunit cleanups
 - require at least 4 devices for RAID6 to skip broken special cases

Diffstat:
 b/Documentation/crypto/async-tx-api.rst           |    4 
 b/MAINTAINERS                                     |    2 
 b/crypto/async_tx/async_pq.c                      |    9 
 b/crypto/async_tx/async_raid6_recov.c             |    9 
 b/drivers/dma/bcm-sba-raid.c                      |    1 
 b/drivers/md/raid5.c                              |    4 
 b/fs/btrfs/raid56.c                               |    8 
 b/include/linux/raid/pq.h                         |  216 ------------
 b/include/linux/raid/pq_tables.h                  |   19 +
 b/lib/Kconfig                                     |   11 
 b/lib/Makefile                                    |    1 
 b/lib/raid/Kconfig                                |   33 +
 b/lib/raid/Makefile                               |    2 
 b/lib/raid/raid6/Makefile                         |  128 +++++++
 b/lib/raid/raid6/algos.c                          |  377 ++++++++++++++++++++++
 b/lib/raid/raid6/algos.h                          |   41 ++
 b/lib/raid/raid6/arm/neon.c                       |   23 -
 b/lib/raid/raid6/arm/neon.uc                      |    2 
 b/lib/raid/raid6/arm/pq_arch.h                    |   21 +
 b/lib/raid/raid6/arm/recov_neon.c                 |   27 -
 b/lib/raid/raid6/arm/recov_neon_inner.c           |    2 
 b/lib/raid/raid6/arm64/pq_arch.h                  |    1 
 b/lib/raid/raid6/int.uc                           |   10 
 b/lib/raid/raid6/loongarch/loongarch_simd.c       |   31 -
 b/lib/raid/raid6/loongarch/pq_arch.h              |   23 +
 b/lib/raid/raid6/loongarch/recov_loongarch_simd.c |   39 --
 b/lib/raid/raid6/mktables.c                       |   28 -
 b/lib/raid/raid6/powerpc/altivec.uc               |   32 -
 b/lib/raid/raid6/powerpc/pq_arch.h                |   32 +
 b/lib/raid/raid6/powerpc/vpermxor.uc              |   29 -
 b/lib/raid/raid6/recov.c                          |   62 ---
 b/lib/raid/raid6/riscv/pq_arch.h                  |   21 +
 b/lib/raid/raid6/riscv/recov_rvv.c                |   14 
 b/lib/raid/raid6/riscv/rvv.h                      |   26 -
 b/lib/raid/raid6/s390/pq_arch.h                   |   15 
 b/lib/raid/raid6/s390/recov_s390xc.c              |   14 
 b/lib/raid/raid6/s390/s390vx.uc                   |   15 
 b/lib/raid/raid6/tests/Makefile                   |    3 
 b/lib/raid/raid6/tests/raid6_kunit.c              |  321 ++++++++++++++++++
 b/lib/raid/raid6/x86/avx2.c                       |   47 --
 b/lib/raid/raid6/x86/avx512.c                     |   57 +--
 b/lib/raid/raid6/x86/mmx.c                        |   39 --
 b/lib/raid/raid6/x86/pq_arch.h                    |   96 +++++
 b/lib/raid/raid6/x86/recov_avx2.c                 |   22 -
 b/lib/raid/raid6/x86/recov_avx512.c               |   26 -
 b/lib/raid/raid6/x86/recov_ssse3.c                |   23 -
 b/lib/raid/raid6/x86/sse1.c                       |   49 --
 b/lib/raid/raid6/x86/sse2.c                       |   47 --
 lib/raid6/Makefile                                |   83 ----
 lib/raid6/algos.c                                 |  291 ----------------
 lib/raid6/loongarch.h                             |   38 --
 lib/raid6/test/.gitignore                         |    3 
 lib/raid6/test/Makefile                           |  156 ---------
 lib/raid6/test/test.c                             |  152 --------
 lib/raid6/x86.h                                   |   75 ----
 55 files changed, 1349 insertions(+), 1511 deletions(-)

