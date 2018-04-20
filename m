Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S70P2ZS9zF22N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 17:34:28 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id i29so2169193pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 00:34:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling for
 powerpc
Date: Fri, 20 Apr 2018 17:34:10 +1000
Message-Id: <20180420073414.23169-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few people have been interested in this again. And I promised
if it remains dead code it should be removed, so I would like to
have another try.

I think I got snagged on the modules problem last time and did
not take the time to work it out, this time I just turned off the
compile options for modules (the linker option was never set anyway
so no loss).

This includes some linker script catches and ideas from others, I
didn't documnt them all, but thanks for looking.

I would be interested to help other archs get this working too, if
anybody needs some help.

Thanks,
Nick

Nicholas Piggin (4):
  kbuild: Fix asm-generic/vmlinux.lds.h for
    LD_DEAD_CODE_DATA_ELIMINATION
  kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
    -ffunction-sections/-fdata-sections for module build
  kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if
    enabled
  powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected

 Makefile                          |  4 +--
 arch/Kconfig                      | 15 ----------
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++-------
 include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
 init/Kconfig                      | 27 +++++++++++++++++
 6 files changed, 70 insertions(+), 48 deletions(-)

-- 
2.17.0
