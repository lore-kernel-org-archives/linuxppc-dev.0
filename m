Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D5292C01FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:26:59 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt platform
Date: Tue, 10 Jul 2012 19:26:46 -0500
Message-ID: <1341966409-22660-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The QEMU stuff is related to the PCI refactoring because currently
we have a hard time selecting a primary bus under QEMU, and also because
the generic qemu e500 platform wants a full list of FSL PCI compatibles
to check.

Patchset rebased on Kumar's next branch.

Scott Wood (3):
  powerpc/fsl-pci: get PCI init out of board files
  powerpc/e500: add paravirt QEMU platform
  powerpc/mpc85xx_ds: convert to unified PCI init

 arch/powerpc/platforms/85xx/Kconfig      |   16 +++++
 arch/powerpc/platforms/85xx/Makefile     |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   97 +++++++++---------------------
 arch/powerpc/platforms/85xx/qemu_e500.c  |   72 ++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype   |    4 +
 arch/powerpc/sysdev/fsl_pci.c            |   71 +++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_pci.h            |    8 +++
 7 files changed, 200 insertions(+), 69 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/qemu_e500.c

-- 
1.7.5.4
