Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2EDC6B7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 11:20:45 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6B53DDDD4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 11:20:44 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [00/15] swiotlb cleanup
Date: Fri, 10 Jul 2009 10:04:49 +0900
Message-Id: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, x86@kernel.org,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- removes unused (and unnecessary) hooks in swiotlb.

- adds dma_capable() and converts swiotlb to use it. It can be used to
know if a memory area is dma capable or not. I added
is_buffer_dma_capable() for the same purpose long ago but it turned
out that the function doesn't work on POWERPC.

This can be applied cleanly to linux-next, -mm, and mainline. This
patchset touches multiple architectures (ia64, powerpc, x86) so I
guess that -mm is appropriate for this patchset (I don't care much
what tree would merge this though).

This is tested on x86 but only compile tested on POWERPC and IA64.

Thanks,

=
 arch/ia64/include/asm/dma-mapping.h    |   18 ++++++
 arch/powerpc/include/asm/dma-mapping.h |   23 +++++++
 arch/powerpc/kernel/dma-swiotlb.c      |   48 +---------------
 arch/x86/include/asm/dma-mapping.h     |   18 ++++++
 arch/x86/kernel/pci-dma.c              |    2 +-
 arch/x86/kernel/pci-gart_64.c          |    5 +-
 arch/x86/kernel/pci-nommu.c            |    2 +-
 arch/x86/kernel/pci-swiotlb.c          |   25 --------
 include/linux/dma-mapping.h            |    5 --
 include/linux/swiotlb.h                |   11 ----
 lib/swiotlb.c                          |  102 +++++++++-----------------------
 11 files changed, 92 insertions(+), 167 deletions(-)
