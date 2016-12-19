Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8c36R8wzDwKh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:27 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i88so7844102pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 00/10] Improving debugging with NMIs
Date: Tue, 20 Dec 2016 04:30:01 +1000
Message-Id: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

These patches have been posted a few times before. Since then
I've split them up and tried to simplify the NMI IPI stuff as
much as possible.

I've been testing using David Gibson's QEMU branch ppc-for-2.9,
which implements the required hcall.

Thanks,
Nick

Nicholas Piggin (10):
  powerpc/64s: add exception macro that does not enable RI
  powerpc/64s: exception macro for stack frame and initial register save
  powerpc/64s: fix system reset vs general interrupt reentrancy
  powerpc/64s: disallow system reset vs system reset reentrancy
  powerpc/64s: dedicated system reset interrupt stack
  powerpc: nmi_enter for system reset
  powerpc: add NMI IPI infrastructure
  powerpc: add struct smp_ops_t.cause_nmi_ipi operation
  powerpc/pseries: implement NMI IPI with H_SIGNAL_SYS_RESET
  powerpc: xmon wait for secondaries before sending IPI

 arch/powerpc/Kconfig                      |   5 +
 arch/powerpc/include/asm/exception-64s.h  |  69 +++++++--
 arch/powerpc/include/asm/paca.h           |  14 +-
 arch/powerpc/include/asm/smp.h            |  15 +-
 arch/powerpc/kernel/asm-offsets.c         |   5 +-
 arch/powerpc/kernel/exceptions-64s.S      |  72 +++++----
 arch/powerpc/kernel/setup_64.c            |   5 +
 arch/powerpc/kernel/smp.c                 | 250 +++++++++++++++++++++++++-----
 arch/powerpc/kernel/traps.c               |  19 ++-
 arch/powerpc/platforms/85xx/smp.c         |   1 +
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |   1 +
 arch/powerpc/platforms/cell/interrupt.c   |   2 +-
 arch/powerpc/platforms/chrp/smp.c         |   1 +
 arch/powerpc/platforms/powermac/smp.c     |   1 +
 arch/powerpc/platforms/powernv/smp.c      |   1 +
 arch/powerpc/platforms/ps3/smp.c          |   4 +-
 arch/powerpc/platforms/pseries/ras.c      |   4 +
 arch/powerpc/platforms/pseries/smp.c      |  22 +++
 arch/powerpc/xmon/xmon.c                  |  15 +-
 19 files changed, 418 insertions(+), 88 deletions(-)

-- 
2.11.0
