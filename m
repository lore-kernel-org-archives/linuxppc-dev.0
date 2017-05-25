Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYFLq35qvzDqf2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 13:37:07 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w69so36267470pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 20:37:07 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 christophe.leroy@c-s.fr, paulus@samba.org, rashmica.g@gmail.com,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 0/8] Enable STRICT_KERNEL_RWX
Date: Thu, 25 May 2017 13:36:42 +1000
Message-Id: <20170525033650.10891-1-bsingharora@gmail.com>
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

There are a few bug fixes, the updatepp and updateboltedpp
did not use flags as described in PAPR and the ptdump
utility ignored the first PFN

Balbir Singh (8):
  powerpc/lib/code-patching: Enhance code patching
  powerpc/kprobes: Move kprobes over to patch_instruction
  powerpc/xmon: Add patch_instruction supporf for xmon
  powerpc/vmlinux.lds: Align __init_begin to 16M
  powerpc/platform/pseries/lpar: Fix updatepp and updateboltedpp
  powerpc/mm/hash: Implement mark_rodata_ro() for hash
  powerpc/Kconfig: Enable STRICT_KERNEL_RWX
  powerpc/mm/ptdump: Dump the first entry of the linear mapping as well

 arch/powerpc/Kconfig                       |  1 +
 arch/powerpc/include/asm/book3s/64/hash.h  |  3 +
 arch/powerpc/include/asm/book3s/64/radix.h |  4 ++
 arch/powerpc/kernel/kprobes.c              |  4 +-
 arch/powerpc/kernel/vmlinux.lds.S          | 10 +++-
 arch/powerpc/lib/code-patching.c           | 88 ++++++++++++++++++++++++++++--
 arch/powerpc/mm/dump_hashpagetable.c       |  2 +-
 arch/powerpc/mm/pgtable-hash64.c           | 35 ++++++++++++
 arch/powerpc/mm/pgtable-radix.c            |  7 +++
 arch/powerpc/mm/pgtable_64.c               |  9 +++
 arch/powerpc/platforms/pseries/lpar.c      | 13 ++++-
 arch/powerpc/xmon/xmon.c                   |  7 ++-
 12 files changed, 170 insertions(+), 13 deletions(-)

-- 
2.9.3
