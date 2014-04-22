Return-Path: <prvs=0189afdd1f=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7FC61140111
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 19:30:42 +1000 (EST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/3] Support of the kmcoge4 board
Date: Tue, 22 Apr 2014 11:30:28 +0200
Message-Id: <1398159031-10110-1-git-send-email-valentin.longchamp@keymile.com>
Cc: devicetree@vger.kernel.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for Keymile's COGE4 board, called kmcoge4. This
board is the reference design for further designs at Keymile around the
P2040/P2041 SoCs from Freescale. This reference design is internally
called kmp204x.

Changes in v4:
- remove the addition of the KEYMILE vendor-prefix as it is already
  picked by Rob
- Take Scott's and Rob's comments regarding the bindings for the
  interrupt-cells into account
- remove the partition layout for the NAND Flash as well as it was
  forgotten
- Rebased on top of v3.15-rc1

Changes in v3:
- add a patch with the bindings for the KEYMILE FPGAs
- add the compatible strings for the localbus nodes
- remove the IRQ part of the board-control node as it is currently being
  reworked

Changes in v2:
- add a patch so that the Zarlink vendor prefix is defined
- add some nodes on the localbus CS when possible
- only use the corenet_generic machine and add kmcoge4 to the supported
  boards instead of defining a new kmp204x machine
- set better and more precise device nodes for the spi devices
- remove the partion layout for the spi_flash@0

Valentin Longchamp (3):
  devicetree: bindings: add Zarlink to the vendor prefixes
  devcietree: bindings: add some MFD Keymile FPGAs
  powerpc/mpc85xx: add support for Keymile's kmcoge4 board

 Documentation/devicetree/bindings/mfd/bfticu.txt   |  25 +++
 Documentation/devicetree/bindings/mfd/qriox.txt    |  17 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/powerpc/boot/dts/kmcoge4.dts                  | 152 ++++++++++++++
 arch/powerpc/configs/85xx/kmp204x_defconfig        | 225 +++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig                |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |   3 +-
 7 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/bfticu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qriox.txt
 create mode 100644 arch/powerpc/boot/dts/kmcoge4.dts
 create mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig

-- 
1.8.0.1
