Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whdyS0sRFzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 14:30:08 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id u26so23038438pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 21:30:08 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 0/9] Enable STRICT_KERNEL_RWX
Date: Tue,  6 Jun 2017 14:29:36 +1000
Message-Id: <20170606042945.24997-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable STRICT_KERNEL_RWX for PPC64/BOOK3S

These patches enable RX mappings of kernel text.
rodata is mapped RX as well as a trade-off, there
are more details in the patch description

As a prerequisite for R/O text, patch_instruction
is moved over to using a separate mapping that
allows write to kernel text. xmon/ftrace/kprobes
have been moved over to work with patch_instruction

There is a bug fix, the updatepp and updateboltedpp
(pseries) providers, did not use flags as described in
PAPR

There are patches for 32 bit support from Christophe Leroy
at http://patchwork.ozlabs.org/patch/768257/. The patches
for map_page to map_kernel_page are a pre-requisite to
this series being applied.

Another build failure was reported, because instead
of using ARCH_HAS_SET_MEMORY as a gate for set_memory.h
inclusion, some of the infrastructure in the core kernel
uses CONFIG_STRICT_KERNEL_RWX. I've sent a fix to the
fix the latter.

Changelog v3:
	Support radix
	Drop ptdump patch, already picked from v2
Changelog v2:
	Support optprobes via patch_instruction

Balbir Singh (9):
  powerpc/lib/code-patching: Enhance code patching
  powerpc/kprobes: Move kprobes over to patch_instruction
  powerpc/kprobes/optprobes: Move over to patch_instruction
  powerpc/xmon: Add patch_instruction supporf for xmon
  powerpc/vmlinux.lds: Align __init_begin to 16M
  powerpc/platform/pseries/lpar: Fix updatepp and updateboltedpp
  powerpc/mm/hash: Implement mark_rodata_ro() for hash
  powerpc/Kconfig: Enable STRICT_KERNEL_RWX
  powerpc/mm/radix: Implement mark_rodata_ro() for radix

 arch/powerpc/Kconfig                       |   1 +
 arch/powerpc/include/asm/book3s/64/hash.h  |   3 +
 arch/powerpc/include/asm/book3s/64/radix.h |   4 +
 arch/powerpc/kernel/kprobes.c              |   4 +-
 arch/powerpc/kernel/optprobes.c            |  58 +++++++-----
 arch/powerpc/kernel/vmlinux.lds.S          |  10 ++-
 arch/powerpc/lib/code-patching.c           | 140 ++++++++++++++++++++++++++++-
 arch/powerpc/mm/pgtable-hash64.c           |  35 ++++++++
 arch/powerpc/mm/pgtable-radix.c            |  73 ++++++++++++++-
 arch/powerpc/mm/pgtable_64.c               |   9 ++
 arch/powerpc/platforms/pseries/lpar.c      |  13 ++-
 arch/powerpc/xmon/xmon.c                   |   7 +-
 12 files changed, 323 insertions(+), 34 deletions(-)

-- 
2.9.4
