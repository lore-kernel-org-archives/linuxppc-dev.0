Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45Q2q9WzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:44:42 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id cf3so4672024pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:44:42 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC][PATCH 00/14] pseries exception cleanups
Date: Thu, 21 Jul 2016 16:43:59 +1000
Message-Id: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This series does two major things. First is to change how our
feature fixup code works, and second is to reorganise exception
vectors for pseries, and that requires the first.

This has not had a huge amount of testing. In particular endian,
cross compiling, embedded, etc. At this point I want to get
something out for comments because it's become quite a large
change.

To that end, it applies to quite an old -linus revision:
d325ea859490511322d1f151dc38577ee9a7c6da

Rebasing takes a bit of work, but I'll bring it up to date if
the response is positive.

Thanks,
Nick


Nicholas Piggin (14):
  powerpc: add arch/powerpc/tools directory
  powerpc/pseries: remove cross-fixup branches in exception code
  powerpc: build-time fixup alternate feature relative addresses
  powerpc/pseries: move decrementer exception vector out of line
  powerpc/pseries: 4GB exception handler offsets
  powerpc/pseries: h_facility_unavailable realmode exception location
  powerpc/pseries: improved exception vector macros
  powerpc/pseries: consolidate exception handler alignment
  powerpc/64: use gas sections for arranging exception vectors
  powerpc/pseries: move related exception code together
  powerpc/pseries: use single macro for both parts of OOL exception
  powerpc/pseries: remove unused exception code, small cleanups
  powerpc/pseries: consolidate slb exceptions
  powerpc/pseries: exceptions use short handler load again

 arch/powerpc/Makefile                             |   23 +-
 arch/powerpc/include/asm/exception-64s.h          |  155 +-
 arch/powerpc/include/asm/feature-fixups.h         |    5 +-
 arch/powerpc/include/asm/head-64.h                |  351 ++++
 arch/powerpc/include/asm/ppc_asm.h                |   29 +-
 arch/powerpc/kernel/exceptions-64s.S              | 2052 ++++++++++-----------
 arch/powerpc/kernel/head_64.S                     |   84 +-
 arch/powerpc/kernel/vmlinux.lds.S                 |   32 +-
 arch/powerpc/lib/feature-fixups.c                 |   19 +-
 arch/powerpc/relocs_check.sh                      |   59 -
 arch/powerpc/scripts/gcc-check-mprofile-kernel.sh |   23 -
 arch/powerpc/tools/Makefile                       |    3 +
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh   |   23 +
 arch/powerpc/tools/relocs/.gitignore              |    1 +
 arch/powerpc/tools/relocs/Makefile                |    9 +
 arch/powerpc/tools/relocs/code-patching.c         |   82 +
 arch/powerpc/tools/relocs/code-patching.h         |    7 +
 arch/powerpc/tools/relocs/elf_sections.c          |  337 ++++
 arch/powerpc/tools/relocs/elf_sections.h          |   50 +
 arch/powerpc/tools/relocs/process_relocs.c        |  437 +++++
 arch/powerpc/tools/relocs_check.sh                |   59 +
 21 files changed, 2527 insertions(+), 1313 deletions(-)
 create mode 100644 arch/powerpc/include/asm/head-64.h
 delete mode 100755 arch/powerpc/relocs_check.sh
 delete mode 100755 arch/powerpc/scripts/gcc-check-mprofile-kernel.sh
 create mode 100644 arch/powerpc/tools/Makefile
 create mode 100755 arch/powerpc/tools/gcc-check-mprofile-kernel.sh
 create mode 100644 arch/powerpc/tools/relocs/.gitignore
 create mode 100644 arch/powerpc/tools/relocs/Makefile
 create mode 100644 arch/powerpc/tools/relocs/code-patching.c
 create mode 100644 arch/powerpc/tools/relocs/code-patching.h
 create mode 100644 arch/powerpc/tools/relocs/elf_sections.c
 create mode 100644 arch/powerpc/tools/relocs/elf_sections.h
 create mode 100644 arch/powerpc/tools/relocs/process_relocs.c
 create mode 100755 arch/powerpc/tools/relocs_check.sh

-- 
2.8.1
