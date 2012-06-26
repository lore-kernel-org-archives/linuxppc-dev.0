Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5FD90B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 05:54:48 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: benh@kernel.crashing.org
Subject: [PATCH 0/3] powerpc: delete WR sbc8560 board support.
Date: Tue, 26 Jun 2012 15:54:26 -0400
Message-Id: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <David.Woodhouse@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The support for this reference platform really no longer needs
to be carried in tree anymore, since the hardware has been EOL'd
for a while, and the age and configuration of the hardware doesn't
really make it desireable to use vs. say using the newer Wind River
sbc8548 board, which has had recent u-boot validation/updates, etc.

Removal lets us also get rid of a (now) unused MTD mapping, and
some quirk handling in the 8250 UART support.  These are grouped
together here, but since the commits are only functionally tied
to the sbc8560, we can have the mtd/uart changes go in via their
respective trees if desired, and not risk introducing any build
regressions by doing so.

Paul
---

Cc: David Woodhouse <David.Woodhouse@intel.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Paul Gortmaker (3):
  powerpc: remove Wind River SBC8560 support
  mtd: delete SBC82xx/SBC8560 MTD mapping support
  serial/8250: delete WR SBC850 UART quirk handling

 arch/powerpc/boot/Makefile                  |    1 -
 arch/powerpc/boot/dts/sbc8560.dts           |  406 ---------------------------
 arch/powerpc/configs/85xx/sbc8560_defconfig |   65 -----
 arch/powerpc/platforms/85xx/Kconfig         |    6 -
 arch/powerpc/platforms/85xx/Makefile        |    1 -
 arch/powerpc/platforms/85xx/sbc8560.c       |  254 -----------------
 drivers/mtd/maps/Kconfig                    |   12 -
 drivers/mtd/maps/wr_sbc82xx_flash.c         |  174 ------------
 drivers/tty/serial/8250/8250.h              |    7 -
 9 files changed, 0 insertions(+), 926 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/sbc8560.dts
 delete mode 100644 arch/powerpc/configs/85xx/sbc8560_defconfig
 delete mode 100644 arch/powerpc/platforms/85xx/sbc8560.c
 delete mode 100644 drivers/mtd/maps/wr_sbc82xx_flash.c

-- 
1.7.9.1
