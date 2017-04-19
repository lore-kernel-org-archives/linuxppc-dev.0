Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x22d.google.com (mail-it0-x22d.google.com
 [IPv6:2607:f8b0:4001:c0b::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Mgw028KzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:06:03 +1000 (AEST)
Received: by mail-it0-x22d.google.com with SMTP id a140so13034086ita.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 06:06:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/9] idle fixes and changes for POWER8 and POWER9
Date: Wed, 19 Apr 2017 23:05:42 +1000
Message-Id: <20170419130551.32378-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last posting:

- accounted for some minor omments
- improved changelogs
- updated to powerpc next which includes Gautham's idle changes.
- Fixed CONFIG_RELOCATABLE build with the new patch 1.
- Also added the last patch which simplifies the DD1 workaround,
  which is possible with HSPRG0 wakeup differences removed.

Nicholas Piggin (9):
  powerpc/64s: Remove unnecessary relocation branch from idle handler
  powerpc/64s: move remaining system reset idle code into idle_book3s.S
  powerpc/64s: stop using bit in HSPRG0 to test winkle
  powerpc/64s: use alternative feature patching
  powerpc/64s: fix POWER9 machine check handler from stop state
  powerpc/64s: idle expand core idle state bits
  powerpc/64s: idle do not hold reservation longer than required
  powerpc/64s: idle POWER8 avoid full state loss recovery where possible
  powerpc/64s: Simplify POWER9 DD1 idle workaround code

 arch/powerpc/include/asm/cpuidle.h        |  32 +++-
 arch/powerpc/include/asm/exception-64s.h  |  21 +--
 arch/powerpc/include/asm/feature-fixups.h |   3 +
 arch/powerpc/include/asm/reg.h            |   1 +
 arch/powerpc/kernel/exceptions-64s.S      | 122 ++++++--------
 arch/powerpc/kernel/idle_book3s.S         | 260 ++++++++++++++++++++++--------
 arch/powerpc/platforms/powernv/idle.c     |  13 --
 7 files changed, 270 insertions(+), 182 deletions(-)

-- 
2.11.0
