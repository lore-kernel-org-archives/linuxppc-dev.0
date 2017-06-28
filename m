Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyTfn4KBvzDr3q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:04:33 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e199so9770811pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 10:04:33 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v5 0/7] Provide STRICT_KERNEL_RWX for powerpc
Date: Thu, 29 Jun 2017 03:04:04 +1000
Message-Id: <20170628170411.28864-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide STRICT_KERNEL_RWX for PPC64/BOOK3S

These patches enable RX mappings of kernel text.
rodata is mapped RX as well as a trade-off, there
are more details in the patch description

As a prerequisite for R/O text, patch_instruction
is moved over to using a separate mapping that
allows write to kernel text. xmon/ftrace/kprobes
have been moved over to work with patch_instruction

There is a bug fix, the updatepp and updateboltedpp
(pseries) providers, did not use flags as described in
PAPR (patch 3). I would like to see that patch marked
to stable, I've not added a Cc:stable myself.

Another build failure was reported, because instead
of using ARCH_HAS_SET_MEMORY as a gate for set_memory.h
inclusion, some of the infrastructure in the core kernel
uses CONFIG_STRICT_KERNEL_RWX. I've sent a fix to the
fix the latter. It should be picked up by 4.13 at which
time we can remove the config dependency on !HIBERNATION
in arch/powerpc/Kconfig

This version received testing under CONFIG_RELOCATABLE_TEST.
CONFIG_STRICT_KERNEL_RWX does not work great with that config
and disables the feature when relocation is on and prints
a warning message. 

After these changes go in we can get the PPC32 varaint
for the same feature based on patches already posted
by Christophe.

Changelog v5:
	Drop patches accepted by Michael Ellerman
	The radix patch has been reworked to
	a. avoid splitting linear mapping when
	   CONFIG_STRICT_KERNEL_RWX is off
	b. Fix the psize used for the linear mapping
	There is also a bug fix to allow vector
	areas to remain executable.
Changelog v4:
	Multiple cleanups to patch_instruction() based on
	review comments from Michael Ellerman
	Changes to Kconfig to make the feature selectable
Changelog v3:
	Support radix
	Drop ptdump patch, already picked from v2
Changelog v2:
	Support optprobes via patch_instruction

Balbir Singh (7):
  powerpc/lib/code-patching: Use alternate map for patch_instruction()
  powerpc/vmlinux.lds: Align __init_begin to 16M
  powerpc/platform/pseries/lpar: Fix updatepp and updateboltedpp
  powerpc/mm/hash: Implement mark_rodata_ro() for hash
  powerpc/mm/radix: Implement mark_rodata_ro() for radix
  mm/radix: Fix permissions correctly for interrupt_vectors
  powerpc/Kconfig: Enable STRICT_KERNEL_RWX

 arch/powerpc/Kconfig                       |   2 +
 arch/powerpc/include/asm/book3s/64/hash.h  |   3 +
 arch/powerpc/include/asm/book3s/64/radix.h |   4 +
 arch/powerpc/kernel/vmlinux.lds.S          |  10 +-
 arch/powerpc/lib/code-patching.c           | 160 ++++++++++++++++++++++++++++-
 arch/powerpc/mm/pgtable-hash64.c           |  41 ++++++++
 arch/powerpc/mm/pgtable-radix.c            |  86 +++++++++++++++-
 arch/powerpc/mm/pgtable_64.c               |   9 ++
 arch/powerpc/platforms/pseries/lpar.c      |  21 +++-
 9 files changed, 327 insertions(+), 9 deletions(-)

-- 
2.9.4
