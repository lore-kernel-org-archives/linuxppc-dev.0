Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kmxW0VDkzF3Gj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 13:52:45 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id w3-v6so4869226pgv.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 20:52:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v3 0/4] powerpc patches for new Kconfig language
Date: Mon, 14 May 2018 13:52:24 +1000
Message-Id: <20180514035228.21316-1-npiggin@gmail.com>
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
language that Yamada-san has proposed here:

https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/?h=kconfig-shell-v3

I have tested on top of that tree and powerpc now builds there.

I think patches 1-3 are improvements to the build system even before
kconfig-shell, so they could be merged ahead of it.

Patch 4 actually takes advatage of a new feature of the kconfig-shell
changes to improve powerpc kconfig, so that should rather be merged
with the kbuild tree with an ack from powerpc. Yamada-san are you
planning to merge kconfig-shell for 4.17?

Thanks,
Nick

Nicholas Piggin (4):
  powerpc/kbuild: set default generic machine type for 32-bit compile
  powerpc/kbuild: remove CROSS32 defines from top level powerpc Makefile
  powerpc/kbuild: Use flags variables rather than overriding LD/CC/AS
  powerpc/kbuild: move -mprofile-kernel check to Kconfig

 arch/powerpc/Kconfig                          | 16 +------
 arch/powerpc/Makefile                         | 45 ++++++++-----------
 arch/powerpc/boot/Makefile                    | 16 ++++---
 arch/powerpc/kernel/vdso32/Makefile           | 15 +++++--
 .../tools/gcc-check-mprofile-kernel.sh        |  4 +-
 scripts/recordmcount.pl                       |  7 +++
 6 files changed, 51 insertions(+), 52 deletions(-)

-- 
2.17.0
