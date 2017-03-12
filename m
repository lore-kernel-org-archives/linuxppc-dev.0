Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vh6zC0XFwzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:13:42 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 67so16502614pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 10:13:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC][PATCH 0/2] reworking cause_ipi and adding global doorbell
 support
Date: Mon, 13 Mar 2017 03:13:25 +1000
Message-Id: <20170312171327.21088-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Just after the previous two fixes, I would like to propose changing
the way we do doorbell vs interrupt controller IPIs, and add support
for global doorbells supported by POWER9 in HV mode.

After this, the platform code knows about doorbells and interrupt
controller IPIs, rather than they know about each other.

Thanks,
Nick

Nicholas Piggin (2):
  powerpc/64s: change the doorbell IPI calling convention
  powerpc/64s: use global doorbell on POWER9 in HV mode

 arch/powerpc/include/asm/dbell.h       | 38 ++++++++++++++++++++++-----
 arch/powerpc/include/asm/smp.h         |  4 +--
 arch/powerpc/include/asm/xics.h        |  2 +-
 arch/powerpc/kernel/dbell.c            | 47 ++++++++++++++++++++++------------
 arch/powerpc/kernel/smp.c              | 27 ++++++++++---------
 arch/powerpc/platforms/85xx/smp.c      |  9 +------
 arch/powerpc/platforms/powermac/smp.c  |  2 +-
 arch/powerpc/platforms/powernv/smp.c   | 32 +++++++++++++++++------
 arch/powerpc/platforms/pseries/smp.c   | 28 ++++++++------------
 arch/powerpc/sysdev/xics/icp-hv.c      |  2 +-
 arch/powerpc/sysdev/xics/icp-native.c  | 12 +--------
 arch/powerpc/sysdev/xics/icp-opal.c    |  2 +-
 arch/powerpc/sysdev/xics/xics-common.c |  3 ---
 13 files changed, 118 insertions(+), 90 deletions(-)

-- 
2.11.0
