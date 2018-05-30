Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wqQv13ZgzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 22:19:35 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e9-v6so8947498pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 05:19:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v5 0/4] powerpc patches for new Kconfig language
Date: Wed, 30 May 2018 22:19:18 +1000
Message-Id: <20180530121922.22122-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches improves th powerpc kbuild system. The
motivation was to to be compatible with the new Kconfig scripting
language that Yamada-san has implemented here for merge:

https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=kconfig

I have tested on top of that tree, powerpc now builds there.

To avoid build breakage, the first 3 patches must go before the
kconfig change, and the 4th patch must go after it.

v5 changes:
- Patch 4 update to syntax changed since kconfig-shell-v3 release.
- Patch 4 suggestions from Masahiro Yamada, remove unnecessary "OK"
  output from check mprofile script, and fold CC_USING_MPROFILE_KERNEL
  into CONFIG_MPROFILE_KERNEL.
- Reduce whitespace disturbance in patch 1.

Thanks,
Nick


Nicholas Piggin (4):
  powerpc/kbuild: set default generic machine type for 32-bit compile
  powerpc/kbuild: remove CROSS32 defines from top level powerpc Makefile
  powerpc/kbuild: Use flags variables rather than overriding LD/CC/AS
  powerpc/kbuild: move -mprofile-kernel check to Kconfig

 arch/powerpc/Kconfig                          | 16 +------
 arch/powerpc/Makefile                         | 44 ++++++++-----------
 arch/powerpc/boot/Makefile                    | 16 ++++---
 arch/powerpc/include/asm/module.h             |  2 +-
 arch/powerpc/kernel/module_64.c               |  4 +-
 arch/powerpc/kernel/trace/ftrace.c            |  6 +--
 arch/powerpc/kernel/vdso32/Makefile           | 15 +++++--
 .../tools/gcc-check-mprofile-kernel.sh        | 13 +++---
 scripts/recordmcount.pl                       | 18 +++++++-
 9 files changed, 72 insertions(+), 62 deletions(-)

-- 
2.17.0
