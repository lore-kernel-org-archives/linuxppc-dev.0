Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKf0x58RwzF0ZT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 14:27:11 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/6] Nintendo Wii GPIO driver
Date: Mon, 15 Jan 2018 04:13:55 +0100
Message-Id: <20180115031401.19577-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds a driver for the GPIO controller used in the Nintendo
Wii game console.

The driver itself, and the related devicetree work should be pretty
uncontroversial, but due to the system architecture of the Wii, I also
had to extend an old resource allocation hack to kernel/resource.c: On
the Wii, there are two separate RAM ranges, with MMIO right in the
middle, but AFAIK, Linux on PPC32 doesn't support discontiguous memory
properly. So the hack is to allocate one big RAM range with a hole
(marked as reserved memory) for MMIO in the middle.

Because this series touches different subsystems (GPIO, DT, core
resource management), I guess it should be picked up patch-by-patch by
the different maintainers.

Jonathan Neuschäfer (6):
  resource: Extend the PPC32 reserved memory hack
  powerpc: wii: Explicitly configure GPIO owner for poweroff pin
  gpio: Add GPIO driver for Nintendo Wii
  dt-bindings: gpio: Add binding for Wii GPIO controller
  powerpc: wii.dts: Add ngpios property
  powerpc: wii.dts: Add GPIO line names

 .../bindings/gpio/nintendo,hollywood-gpio.txt      |  27 +++
 .../devicetree/bindings/powerpc/nintendo/wii.txt   |   9 +-
 arch/powerpc/boot/dts/wii.dts                      |   9 +
 arch/powerpc/platforms/embedded6xx/wii.c           |   7 +
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-hlwd.c                           | 183 +++++++++++++++++++++
 kernel/resource.c                                  |  21 ++-
 8 files changed, 256 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
 create mode 100644 drivers/gpio/gpio-hlwd.c

-- 
2.15.1
