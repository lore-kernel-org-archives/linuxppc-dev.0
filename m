Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CNRd3kGnzF1wn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 00:55:24 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id y63so5094147pgy.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 06:55:24 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
 oohall@gmail.com, Balbir Singh <bsingharora@gmail.com>
Subject: [RFC 0/3] Add support for memcpy_mcsafe
Date: Sat, 31 Mar 2018 00:55:09 +1100
Message-Id: <20180330135512.23760-1-bsingharora@gmail.com>
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

Balbir Singh (3):
  powerpc/mce: Bug fixes for MCE handling in kernel space
  powerpc/memcpy: Add memcpy_mcsafe for pmem
  powerpc/mce: Handle memcpy_mcsafe

 arch/powerpc/include/asm/mce.h      |   3 +-
 arch/powerpc/include/asm/string.h   |   2 +
 arch/powerpc/kernel/mce.c           |  76 +++++++++++-
 arch/powerpc/kernel/mce_power.c     |  17 +--
 arch/powerpc/lib/Makefile           |   2 +-
 arch/powerpc/lib/memcpy_mcsafe_64.S | 225 ++++++++++++++++++++++++++++++++++++
 6 files changed, 314 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/lib/memcpy_mcsafe_64.S

-- 
2.13.6
