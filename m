Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3cCC3v8LzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:16:39 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id o126so9988628pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 03:16:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4 v2] doorbell patches for POWER9
Date: Thu, 13 Apr 2017 20:16:20 +1000
Message-Id: <20170413101624.26628-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last:
- Ported up to powerpc next (thanks mpe)
- Dropped darn workaround from DD1 for now.
- Dropped the guest doorbell hack. It's not an immediate problem and
  will be tackled in other ways.

Nicholas Piggin (4):
  powerpc: change the doorbell IPI calling convention
  powerpc: Introduce msgsnd/doorbell barrier primitives
  powerpc/64s: avoid branch for ppc_msgsnd
  powerpc/powernv: POWER9 support for msgsnd/doorbell IPI

 arch/powerpc/include/asm/dbell.h          | 40 +++++++++++++++------
 arch/powerpc/include/asm/feature-fixups.h | 20 +++++++++++
 arch/powerpc/include/asm/ppc-opcode.h     |  2 ++
 arch/powerpc/include/asm/ppc_asm.h        |  8 +++++
 arch/powerpc/include/asm/smp.h            |  4 +--
 arch/powerpc/include/asm/xics.h           |  2 +-
 arch/powerpc/kernel/dbell.c               | 58 +++++++++++++++++++++++++++----
 arch/powerpc/kernel/smp.c                 | 27 +++++++-------
 arch/powerpc/platforms/85xx/smp.c         | 11 ++----
 arch/powerpc/platforms/powermac/smp.c     |  2 +-
 arch/powerpc/platforms/powernv/smp.c      | 47 +++++++++++++++++++++----
 arch/powerpc/platforms/pseries/smp.c      | 27 ++++++--------
 arch/powerpc/sysdev/xics/icp-hv.c         |  2 +-
 arch/powerpc/sysdev/xics/icp-native.c     | 12 +------
 arch/powerpc/sysdev/xics/icp-opal.c       |  2 +-
 arch/powerpc/sysdev/xics/xics-common.c    |  3 --
 arch/powerpc/sysdev/xive/common.c         |  6 ++--
 17 files changed, 186 insertions(+), 87 deletions(-)

-- 
2.11.0
