Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqmNP0GfXzDqZd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 01:42:29 +1000 (AEST)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:19])
 by newton.telenet-ops.be (Postfix) with ESMTP id 3qqm8j6rPjzMs2rK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:32:21 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Vinod Koul <vinod.koul@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/14] DT: Fix spelling of standard properties
Date: Wed, 20 Apr 2016 17:32:05 +0200
Message-Id: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hi all,

This patch series fixes misspellings of various standard DT properties
in DT binding documentation, DTS files, and error messages.
While most of these are harmless, some of them may cause hard-to-debug
failures.

Please apply where appropriate.

Thanks!

P.S. I used the following to detect misspellings:

    words="(address|clock|cooling|dma|gpio|index|interrupt|mbox|msi|nvmem|phy|phys|power-domain|pwm|reset|size|sleep|sound-dai|thermal-sensor)"

    git grep -Ew "${words}s-names"
    git grep -E "[^-]\<${words}-name\>[^-]"
    git grep -Ew "#${words}s-cells"		# false positive phys-cells
    git grep -E "#${words}-cell\>[^-]"

    git grep -w adress-cells
    git grep -Ew "interrupts-(map|parent)"

How can we prevent adding more of these?

One simple option is to add the offenders to scripts/spelling.txt.
Alternatively, we may want to do something smarter and more DT specific?

Geert Uytterhoeven (14):
  ARM: dts: STiH407: DT spelling s/interrupts-names/interrupt-names/
  ARM: dts: omap5-board-common: DT spelling
    s/interrupt-name/interrupt-names/
  ARM: dts: omap5-cm-t54: DT spelling s/interrupt-name/interrupt-names/
  ARM: dts: OMAP36xx: : DT spelling s/#address-cell/#address-cells/
  arm64: dts: lg1312: DT spelling s/#interrupts-cells/#interrupt-cells/
  dmaengine: bcm2835: DT spelling s/interrupts-names/interrupt-names/
  dt: booting-without-of: DT spelling
    s/#interrupt-cell/#interrupt-cells/
  powerpc: dts: acadia: DT spelling
    s/#interrupts-parent/#interrupt-parent/
  Input: touchscreen: Broadcom iProc: DT spelling
    s/clock-name/clock-names/
  misc: sram: DT spelling s/#adress-cells/#address-cells/
  PCI: hisi: DT spelling s/interrupts-*/interrupt-*/
  phy: phy-stih41x-usb: DT spelling s/#phy-cell/#phy-cells/
  rtc: rtc-sa1100: DT spelling s/interrupt-name/interrupt-names/
  regulator: ti-abb: DT spelling
    s/#{address,size}-cell/#{address,size}-cells/

 .../bindings/input/touchscreen/brcm,iproc-touchscreen.txt    |  2 +-
 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt     | 12 ++++++------
 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt    |  2 +-
 .../devicetree/bindings/regulator/ti-abb-regulator.txt       | 10 +++++-----
 Documentation/devicetree/bindings/rtc/sa1100-rtc.txt         |  2 +-
 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt    |  2 +-
 Documentation/devicetree/bindings/sram/sram.txt              |  2 +-
 Documentation/devicetree/booting-without-of.txt              |  2 +-
 arch/arm/boot/dts/omap36xx.dtsi                              |  2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi                    |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                           |  2 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi                       |  2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                           |  2 +-
 arch/powerpc/boot/dts/acadia.dts                             |  2 +-
 drivers/dma/bcm2835-dma.c                                    |  2 +-
 15 files changed, 24 insertions(+), 24 deletions(-)

-- 
1.9.1
