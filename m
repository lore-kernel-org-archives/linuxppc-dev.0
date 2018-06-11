Return-Path: <diana.craciun@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414Ccd5hf4zF3bX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 22:53:36 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v2 0/3] powerpc/fsl: Speculation barrier for NXP PowerPC Book3E
Date: Mon, 11 Jun 2018 15:53:25 +0300
Message-Id: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement barrier_nospec for NXP PowerPC Book3E processors. 

Diana Craciun (3):
  Disable the speculation barrier from the command line
  Add barrier_nospec implementation for NXP PowerPC Book3E
  Implement cpu_show_spectre_v1/v2 for NXP PowerPC Book3E

 arch/powerpc/Kconfig               |  2 +-
 arch/powerpc/include/asm/barrier.h | 10 +++++++++
 arch/powerpc/include/asm/setup.h   |  2 +-
 arch/powerpc/kernel/Makefile       |  2 +-
 arch/powerpc/kernel/module.c       |  5 +++--
 arch/powerpc/kernel/security.c     | 42 +++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/setup_32.c     |  5 +++++
 arch/powerpc/kernel/setup_64.c     |  6 ++++++
 arch/powerpc/kernel/vmlinux.lds.S  |  4 +++-
 arch/powerpc/lib/feature-fixups.c  | 35 ++++++++++++++++++++++++++++++-
 10 files changed, 105 insertions(+), 8 deletions(-)

--
History:

v1 --> v2
- added implementation for cpu_show_spectre_x functions
- the mitigation is no longer enabled through device tree options
2.5.5
