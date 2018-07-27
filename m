Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cl2x1VYjzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 09:06:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org,
	diana.craciun@nxp.com
Cc: oss@buserror.net,
	leoyang.li@nxp.com,
	bharat.bhushan@nxp.com
Subject: [PATCH v5 0/8] powerpc/fsl: Speculation barrier for NXP PowerPC Book3E
Date: Sat, 28 Jul 2018 09:06:31 +1000
Message-Id: <20180727230639.25413-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement barrier_nospec for NXP PowerPC Book3E processors.

Hi Diana,

This series interacts with another series of mine, so I wanted to rework it
slightly. Let me know if this looks OK to you.

cheers

Diana Craciun (6):
  powerpc/64: Disable the speculation barrier from the command line
  powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
  powerpc/64: Make meltdown reporting Book3S 64 specific
  powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E
  powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit
    platforms
  Documentation: Add nospectre_v1 parameter

Michael Ellerman (2):
  powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
  powerpc/64: Call setup_barrier_nospec() from setup_arch()

 Documentation/admin-guide/kernel-parameters.txt |  4 +++
 arch/powerpc/Kconfig                            |  7 ++++-
 arch/powerpc/include/asm/barrier.h              | 12 ++++++---
 arch/powerpc/include/asm/setup.h                |  6 ++++-
 arch/powerpc/kernel/Makefile                    |  3 ++-
 arch/powerpc/kernel/entry_32.S                  | 10 +++++++
 arch/powerpc/kernel/module.c                    |  4 ++-
 arch/powerpc/kernel/security.c                  | 17 +++++++++++-
 arch/powerpc/kernel/setup-common.c              |  2 ++
 arch/powerpc/kernel/vmlinux.lds.S               |  4 ++-
 arch/powerpc/lib/feature-fixups.c               | 35 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/setup.c          |  1 -
 arch/powerpc/platforms/pseries/setup.c          |  1 -
 13 files changed, 94 insertions(+), 12 deletions(-)

-- 
2.14.1
