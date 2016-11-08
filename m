Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCrZn0tqGzDsxJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 01:01:37 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so19627056pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 06:01:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 0/3][RFC] powerpc: NMI IPIs
Date: Wed,  9 Nov 2016 01:01:22 +1100
Message-Id: <20161108140125.21455-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a significant reworking of earlier patches, it should be
getting closer to the right shape now, but I'm always open to
change anything.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc: add NMI IPI infrastructure
  powerpc: add struct smp_ops_t.cause_nmi_ipi operation
  powerpc/pseries: implement nmi ipi with H_SIGNAL_SYS_RESET

 arch/powerpc/include/asm/smp.h            |   7 +-
 arch/powerpc/kernel/smp.c                 | 282 +++++++++++++++++++++++++-----
 arch/powerpc/kernel/traps.c               |   7 +-
 arch/powerpc/platforms/85xx/smp.c         |   1 +
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |   1 +
 arch/powerpc/platforms/cell/interrupt.c   |   2 +-
 arch/powerpc/platforms/chrp/smp.c         |   1 +
 arch/powerpc/platforms/powermac/smp.c     |   1 +
 arch/powerpc/platforms/powernv/smp.c      |   1 +
 arch/powerpc/platforms/ps3/smp.c          |   4 +-
 arch/powerpc/platforms/pseries/ras.c      |   4 +
 arch/powerpc/platforms/pseries/smp.c      |  11 ++
 12 files changed, 268 insertions(+), 54 deletions(-)

-- 
2.10.2
