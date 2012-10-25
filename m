Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E1B2C2C00A4
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2012 07:41:33 +1100 (EST)
Date: Thu, 25 Oct 2012 22:41:13 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'merge' branch of 5xxx tree
Message-ID: <20121025224113.5a67a77d@wker>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

please pull three mpc5200 fixes for 3.7:

Patch for pcm030 device tree fixing the probe() in pcm030-audio-fabric
driver. Changes to this driver have been merged in 3.7-rc1 via ASoC
tree, but this required device tree patch was submitted separately to
the linux-ppc list and is still missing in mainline. Without this patch
the probe() in pcm030-audio-fabric driver wrongly returns -ENODEV.

A patch from Wolfram fixing wrong invalid critical irq warnings for
all mpc5200 boards.

Another patch for all mpc5200 device trees fixing wrong L1 cell in
the LPB FIFO interrupt property and moving the LPB FIFO node to the
common mpc5200b.dtsi file so that this common node will be present
in all mpc5200 device trees.

All these patches have been in linux-next for a while.

Thanks,
Anatolij

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git merge

Anatolij Gustschin (1):
      powerpc/mpc5200: move lpbfifo node and fix its interrupt property

Eric Millbrandt (1):
      powerpc/pcm030: add pcm030-audio-fabric to dts

Wolfram Sang (1):
      powerpc: 52xx: nop out unsupported critical IRQs

 arch/powerpc/boot/dts/mpc5200b.dtsi       |    6 ++++++
 arch/powerpc/boot/dts/o2d.dtsi            |    6 ------
 arch/powerpc/boot/dts/pcm030.dts          |    7 ++++++-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    9 +++++----
 4 files changed, 17 insertions(+), 11 deletions(-)
