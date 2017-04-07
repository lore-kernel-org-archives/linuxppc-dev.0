Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w00281rrFzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 22:56:16 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so15456495pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 05:56:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/5] doorbell patches for POWER9
Date: Fri,  7 Apr 2017 22:55:57 +1000
Message-Id: <20170407125602.31146-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is what I'd like to do for POWER9 doorbells, which reworks
the existing code a bit. I guess it won't work on DD1 with OPAL
until darn is fixed (only tested on POWER9 using mambo).

Nicholas Piggin (5):
  powerpc/pseries: do not use msgsndp doorbells on POWER9 guests
  powerpc: change the doorbell IPI calling convention
  powerpc: Introduce msgsnd/doorbell barrier primitives
  powerpc/64s: avoid branch for ppc_msgsnd
  powerpc/powernv: POWER9 support for msgsnd/doorbell IPI

 arch/powerpc/include/asm/dbell.h          | 45 ++++++++++++++++++------
 arch/powerpc/include/asm/feature-fixups.h | 20 +++++++++++
 arch/powerpc/include/asm/ppc-opcode.h     |  6 ++++
 arch/powerpc/include/asm/ppc_asm.h        | 15 ++++++++
 arch/powerpc/include/asm/smp.h            |  4 +--
 arch/powerpc/include/asm/xics.h           |  2 +-
 arch/powerpc/kernel/dbell.c               | 58 +++++++++++++++++++++++++++----
 arch/powerpc/kernel/smp.c                 | 27 +++++++-------
 arch/powerpc/platforms/85xx/smp.c         | 11 ++----
 arch/powerpc/platforms/powermac/smp.c     |  2 +-
 arch/powerpc/platforms/powernv/smp.c      | 33 +++++++++++++-----
 arch/powerpc/platforms/pseries/smp.c      | 33 ++++++++----------
 arch/powerpc/sysdev/xics/icp-hv.c         |  2 +-
 arch/powerpc/sysdev/xics/icp-native.c     | 12 +------
 arch/powerpc/sysdev/xics/icp-opal.c       |  2 +-
 arch/powerpc/sysdev/xics/xics-common.c    |  3 --
 16 files changed, 189 insertions(+), 86 deletions(-)

-- 
2.11.0
