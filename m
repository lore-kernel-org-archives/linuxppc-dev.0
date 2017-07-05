Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2S1d51HtzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:04:37 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z6so33065772pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 21:04:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 0/4] machine check handling improvements
Date: Wed,  5 Jul 2017 14:04:18 +1000
Message-Id: <20170705040422.20933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are some improvements to recoverability and debugability
of machine check handling. Patch 2 depends on patch 1, but they
are otherwise independent.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc/powernv: handle the platform error reboot in ppc_md.restart
  powerpc/powernv: machine check use kernel crash path
  powernv/pseries: machine check use kernel crash path
  powerpc: machine check interrupt is a non-maskable interrupt

 arch/powerpc/include/asm/opal.h           |  2 +-
 arch/powerpc/kernel/traps.c               |  9 +++--
 arch/powerpc/platforms/powernv/opal-hmi.c | 20 ++---------
 arch/powerpc/platforms/powernv/opal.c     | 57 ++++++++-----------------------
 arch/powerpc/platforms/powernv/powernv.h  |  2 ++
 arch/powerpc/platforms/powernv/setup.c    | 31 +++++++++++++++++
 arch/powerpc/platforms/pseries/ras.c      | 22 ++++++------
 7 files changed, 69 insertions(+), 74 deletions(-)

-- 
2.11.0
