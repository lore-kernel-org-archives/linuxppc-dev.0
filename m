Return-Path: <bsingharora@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GvH448rMzF1kQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 17:15:12 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id x144-v6so1041914itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 00:15:12 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-nvdimm@lists.01.org, npiggin@gmail.com, mpe@ellerman.id.au,
 oohall@gmail.com, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 0/3]  Add support for memcpy_mcsafe
Date: Thu,  5 Apr 2018 17:14:57 +1000
Message-Id: <20180405071500.22320-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memcpy_mcsafe() is an API currently used by the pmem subsystem to convert
errors while doing a memcpy (machine check exception errors) to a return
value. This patchset consists of three patches

1. The first patch is a bug fix to handle machine check errors correctly
while walking the page tables in kernel mode, due to huge pmd/pud sizes
2. The second patch adds memcpy_mcsafe() support, this is largely derived
from existing code
3. The third patch registers for callbacks on machine check exceptions and
in them uses specialized knowledge of the type of page to decide whether
to handle the MCE as is or to return to a fixup address present in
memcpy_mcsafe(). If a fixup address is used, then we return an error
value of -EFAULT to the caller.

Testing

A large part of the testing was done under a simulator by selectively
inserting machine check exceptions in a test driver doing memcpy_mcsafe
via ioctls.

Changelog v2
 - Fix the logic of shifting in addr_to_pfn
 - Use shift consistently instead of PAGE_SHIFT
 - Fix a typo in patch1

Balbir Singh (3):
  powerpc/mce: Bug fixes for MCE handling in kernel space
  powerpc/memcpy: Add memcpy_mcsafe for pmem
  powerpc/mce: Handle memcpy_mcsafe

 arch/powerpc/include/asm/mce.h      |   3 +-
 arch/powerpc/include/asm/string.h   |   2 +
 arch/powerpc/kernel/mce.c           |  77 ++++++++++++-
 arch/powerpc/kernel/mce_power.c     |  26 +++--
 arch/powerpc/lib/Makefile           |   2 +-
 arch/powerpc/lib/memcpy_mcsafe_64.S | 212 ++++++++++++++++++++++++++++++++++++
 6 files changed, 308 insertions(+), 14 deletions(-)
 create mode 100644 arch/powerpc/lib/memcpy_mcsafe_64.S

-- 
2.13.6
