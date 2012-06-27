Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA98E1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 09:49:01 +1000 (EST)
Date: Wed, 27 Jun 2012 18:48:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt platform
Message-ID: <20120627234851.GA9071@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 Jia Hongtao <B38951@freescale.com>
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

Scott Wood (3):
  powerpc/fsl-pci: get PCI init out of board files
  powerpc/e500: add paravirt QEMU platform
  powerpc/mpc85xx_ds: convert to unified PCI init

 arch/powerpc/platforms/85xx/Kconfig      |   16 +++++
 arch/powerpc/platforms/85xx/Makefile     |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   97 +++++++++---------------------
 arch/powerpc/platforms/85xx/qemu_e500.c  |   66 ++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype   |    4 +
 arch/powerpc/sysdev/fsl_pci.c            |   66 ++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h            |    8 +++
 7 files changed, 190 insertions(+), 68 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/qemu_e500.c

-- 
1.7.5.4
