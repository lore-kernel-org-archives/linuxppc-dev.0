Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMDXH2vFyzDrjJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 21:25:51 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id t86so2065252pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 04:25:50 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 0/3] Implement set_memory_xx for ppc64 book3s
Date: Tue,  1 Aug 2017 21:25:32 +1000
Message-Id: <20170801112535.20765-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After implementing STRICT_KERNEL_RWX, it turns out that implementing
set_memory_ro/rw/x/nx is quite easy. The first patch is applied on
top (http://patchwork.ozlabs.org/patch/795745/).

The first patch implements the various routines, the second patch
enables ARCH_HAS_SET_MEMORY for PPC_BOOK3S_64 and the third patch
enables the BPF infrastructure to use the set_memory_ro and
set_memory_rw routines.

Balbir Singh (3):
  arch/powerpc/set_memory: Implement set_memory_xx routines
  Enable ARCH_HAS_SET_MEMORY
  arch/powerpc/net/bpf: Basic EBPF support

 arch/powerpc/Kconfig                       |  1 +
 arch/powerpc/include/asm/book3s/64/hash.h  |  6 +++
 arch/powerpc/include/asm/book3s/64/radix.h |  6 +++
 arch/powerpc/include/asm/set_memory.h      | 34 +++++++++++++++
 arch/powerpc/mm/pgtable-hash64.c           | 51 ++++++++++++++++++++--
 arch/powerpc/mm/pgtable-radix.c            | 26 ++++++------
 arch/powerpc/mm/pgtable_64.c               | 68 ++++++++++++++++++++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c          | 13 +-----
 8 files changed, 177 insertions(+), 28 deletions(-)
 create mode 100644 arch/powerpc/include/asm/set_memory.h

-- 
2.9.4
