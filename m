Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id C1A5DDDDF6
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 10:09:57 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so290537anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 15:09:56 -0800 (PST)
Message-ID: <fa686aa40801261509o2f6fd195h2f2662e67c022ec@mail.gmail.com>
Date: Sat, 26 Jan 2008 16:09:55 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Patches added to for-2.6.25/master branches of powerpc.git
In-Reply-To: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul, please pull the following mpc52xx changes.

Also, I'd like to have the following patch picked up, but I'm a bit
nervous about it.  Kumar has said it looks good, but I'm still not
100% sure about eliminating the KBUILD_IMAGE and BOOTIMAGE variables.
I *think* it's safe, but I'm not a build system expert.

http://patchwork.ozlabs.org/linuxppc/patch?person=486&id=16264

Cheers,
g.

The following changes since commit 55852bed57a97b08ab56028f1054d48d45de3aec:
  Paul Mackerras (1):
        Revert "[POWERPC] Fake NUMA emulation for PowerPC"

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.25

Grant Likely (6):
      [POWERPC] mpc52xx: clean up Kconfig
      [POWERPC] mpc5200: normalize compatible property bindings
      [POWERPC] mpc5200: make dts files conform to generic names
recommended practice
      [POWERPC] Efika: prune fixups and make them more carefull
      [POWERPC] Add common clock setting routine mpc52xx_psc_set_clkdiv()
      [POWERPC] mpc52xx_psc_spi device driver must not touch port_config and cdm

Paul Gortmaker (1):
      [POWERPC] mpc5200: add #address-cells and #size-cells to soc node.

 arch/powerpc/boot/dts/cm5200.dts             |   60 +++++------
 arch/powerpc/boot/dts/lite5200.dts           |   96 +++++++----------
 arch/powerpc/boot/dts/lite5200b.dts          |   93 +++++++---------
 arch/powerpc/boot/dts/motionpro.dts          |   68 +++++-------
 arch/powerpc/boot/dts/tqm5200.dts            |   45 ++++-----
 arch/powerpc/boot/serial.c                   |    2 +-
 arch/powerpc/kernel/prom_init.c              |  149 ++++++++++++++------------
 arch/powerpc/platforms/52xx/Kconfig          |   41 +++-----
 arch/powerpc/platforms/52xx/efika.c          |    3 +
 arch/powerpc/platforms/52xx/lite5200.c       |   28 ++++--
 arch/powerpc/platforms/52xx/lite5200_pm.c    |    9 ++-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    6 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c |  117 ++++++++++++++++-----
 arch/powerpc/platforms/52xx/mpc52xx_pci.c    |   10 ++-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |   16 +++-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    9 ++-
 arch/powerpc/sysdev/bestcomm/bestcomm.c      |   16 ++-
 arch/ppc/syslib/mpc52xx_setup.c              |   36 ++++++
 drivers/ata/pata_mpc52xx.c                   |    6 +-
 drivers/net/fec_mpc52xx.c                    |    6 +-
 drivers/net/fec_mpc52xx_phy.c                |    8 +-
 drivers/serial/mpc52xx_uart.c                |    4 +-
 drivers/spi/mpc52xx_psc_spi.c                |   82 +-------------
 drivers/usb/host/ohci-ppc-of.c               |    2 +
 include/asm-powerpc/mpc52xx.h                |    9 +-
 25 files changed, 478 insertions(+), 443 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
