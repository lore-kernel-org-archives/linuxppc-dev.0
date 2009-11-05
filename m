Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 87A00B7BBB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 17:10:42 +1100 (EST)
Received: by yxe8 with SMTP id 8so8046395yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Nov 2009 22:10:41 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 4 Nov 2009 23:10:21 -0700
Message-ID: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
Subject: 2.6.33 -next tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, Stephen.

I just prepared my next branch for 2.6.33:
git://git.secretlab.ca/git/linux-2.6 next

Steven, can you please add this tree to your linux-next pull list?
This is the branch where I put stuff that gets fed up to Ben.  This is
separate from the branch that I'm using to collect OF related changes
and that you are already pulling in.

Ben, can you please pull this branch into your -next tree for 2.6.33?

Andrew & David, you'll notice that I've also got some SPI and MMC
changes in this branch (PPC and OF related stuff) since there is no
current MMC maintainer, and some of these SPI patches have been
hanging around for a while now.  Let me know if you object to me
pushing these changes personally instead of going through another
maintainer.

Thanks,
g.

The following changes since commit b419148e567728f6af0c3b01965c1cc141e3e13a=
:
  Linus Torvalds (1):
        Linux 2.6.32-rc6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next

Albrecht Dre=DF (1):
      powerpc: tiny memcpy_(to|from)io optimisation

Grant Likely (4):
      spi/mpc5200: Register SPI devices described in device tree
      powerpc/5200: Add mpc5200-spi (non-PSC) device driver
      powerpc/5200: add general purpose timer API for the MPC5200
      mmc: fix missing module license declaration in of_mmc_spi.c

John Bonesio (1):
      powerpc/5200: add LocalPlus bus FIFO device driver

John Linn (1):
      Xilinx: SPI: Fix bits_per_word for transfers

Wolfram Sang (2):
      spi/mpc52xx-psc-spi: check for valid PSC
      spi/mpc52xx: replace printk with dev_err

 arch/powerpc/include/asm/mpc52xx.h            |   46 ++
 arch/powerpc/kernel/io.c                      |    4 +-
 arch/powerpc/platforms/52xx/Kconfig           |    5 +
 arch/powerpc/platforms/52xx/Makefile          |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |  133 ++++++-
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |  560 +++++++++++++++++++++=
++++
 drivers/mmc/host/of_mmc_spi.c                 |    2 +
 drivers/spi/Kconfig                           |    8 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/mpc52xx_psc_spi.c                 |   25 +-
 drivers/spi/mpc52xx_spi.c                     |  520 +++++++++++++++++++++=
++
 drivers/spi/xilinx_spi.c                      |    3 +-
 include/linux/spi/mpc52xx_spi.h               |   10 +
 13 files changed, 1297 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
 create mode 100644 drivers/spi/mpc52xx_spi.c
 create mode 100644 include/linux/spi/mpc52xx_spi.h


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
