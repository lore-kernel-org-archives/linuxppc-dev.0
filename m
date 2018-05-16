Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mGfm19WszDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 00:15:11 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id v24-v6so514235plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 07:15:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v4 0/4] powerpc patches for new Kconfig language
Date: Thu, 17 May 2018 00:14:54 +1000
Message-Id: <20180516141458.18996-1-npiggin@gmail.com>
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
kconfig-shell, so they could be merged ahead of it in the powerpc
tree.

Patch 4 takes advatage of a new feature of the kconfig-shell work to
improve powerpc kconfig, so that should instead be merged with the
kbuild tree with an ack from powerpc, after patches 1-3 are merged.

v4 just brings some build fixes to patch 3 (including a change from
patch 4 that belonged in patch 3), and improvemets to changelogs.

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
 .../tools/gcc-check-mprofile-kernel.sh        | 12 +++--
 scripts/recordmcount.pl                       | 18 +++++++-
 6 files changed, 67 insertions(+), 55 deletions(-)

-- 
2.17.0
