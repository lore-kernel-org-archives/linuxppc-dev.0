Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hM0m6SFkzF2SQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 15:17:12 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id o76-v6so492393pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 22:17:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/5] kbuild and powerpc patches for new Kconfig language
Date: Thu, 10 May 2018 15:16:54 +1000
Message-Id: <20180510051659.15356-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I came back to these patches and I think I have solved the remaining
problems -- it now builds with 64-bit big and little endian (using a
le toolchain), and also 32-bit big using 64le toolchain. There might
be some build failures still left, but it seems to be in much better
shape now.

Reviews would be welcome. I don't quite know how it should be merged,
maybe via the kbuild tree after acks from powerpc maintainer. We can
decide that after it gets more testing and review.

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/kbuild: set default generic machine type for 32-bit compile
  powerpc/kbuild: remove CROSS32 defines from top level powerpc Makefile
  kbuild: call cc-option with the current set of KBUILD_CFLAGS
  powerpc/kbuild: Use flags variables rather than overriding LD/CC/AS
  powerpc/kbuild: move -mprofile-kernel check to Kconfig

 arch/powerpc/Kconfig                          | 16 +------
 arch/powerpc/Makefile                         | 46 +++++++------------
 arch/powerpc/boot/Makefile                    | 16 +++++--
 arch/powerpc/kernel/vdso32/Makefile           | 15 ++++--
 .../tools/gcc-check-mprofile-kernel.sh        |  4 +-
 scripts/Kbuild.include                        |  8 ++--
 scripts/recordmcount.pl                       |  8 ++++
 7 files changed, 54 insertions(+), 59 deletions(-)

-- 
2.17.0
