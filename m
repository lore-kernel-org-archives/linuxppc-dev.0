Return-Path: <albert_herranz@yahoo.es>
Received: from smtp141.mail.ukl.yahoo.com (smtp141.mail.ukl.yahoo.com
	[77.238.184.72]) by ozlabs.org (Postfix) with SMTP id D2AF1B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Nov 2009 07:44:07 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 00/11] powerpc: nintendo gamecube support
Date: Sat, 28 Nov 2009 21:43:46 +0100
Message-Id: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patches add the base support for the Nintendo GameCube
video game console on the powerpc arch.

The following is included:
- a device tree source
- bootwrapper support
- udbg console option
- early udbg console option
- interrupt controller support
- platform support

With these patches the video game console can fully boot up to the
root filesystem mount phase.

These patches are a pre-requisite for the patchset supporting the
Nintendo Wii video game console, which will be posted separately
to simplify the review and possible merging.

Albert Herranz (11):
  powerpc: gamecube/wii: usbgecko bootwrapper console support
  powerpc: gamecube: device tree
  powerpc: gamecube: bootwrapper bits
  powerpc: gamecube/wii: introduce GAMECUBE_COMMON
  powerpc: gamecube/wii: declare as non-coherent platforms
  powerpc: gamecube/wii: do not include PCI support
  powerpc: gamecube/wii: udbg support for usbgecko
  powerpc: gamecube/wii: early debugging using usbgecko
  powerpc: gamecube/wii: flipper interrupt controller support
  powerpc: gamecube: platform support
  powerpc: gamecube: default config

 .../powerpc/dts-bindings/nintendo/gamecube.txt     |  109 ++
 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/Kconfig.debug                         |    8 +
 arch/powerpc/boot/Makefile                         |    6 +-
 arch/powerpc/boot/dts/gamecube.dts                 |  114 +++
 arch/powerpc/boot/gamecube-head.S                  |  111 ++
 arch/powerpc/boot/gamecube.c                       |   35 +
 arch/powerpc/boot/ugecon.c                         |  147 +++
 arch/powerpc/boot/ugecon.h                         |   24 +
 arch/powerpc/boot/wrapper                          |    4 +
 arch/powerpc/configs/gamecube_defconfig            | 1061 ++++++++++++++++++++
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/head_32.S                      |   21 +
 arch/powerpc/kernel/udbg.c                         |    2 +
 arch/powerpc/platforms/Kconfig.cputype             |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig         |   25 +
 arch/powerpc/platforms/embedded6xx/Makefile        |    3 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |  263 +++++
 arch/powerpc/platforms/embedded6xx/flipper-pic.h   |   25 +
 arch/powerpc/platforms/embedded6xx/gamecube.c      |  118 +++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |  325 ++++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |   32 +
 22 files changed, 2434 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/nintendo/gamecube.txt
 create mode 100644 arch/powerpc/boot/dts/gamecube.dts
 create mode 100644 arch/powerpc/boot/gamecube-head.S
 create mode 100644 arch/powerpc/boot/gamecube.c
 create mode 100644 arch/powerpc/boot/ugecon.c
 create mode 100644 arch/powerpc/boot/ugecon.h
 create mode 100644 arch/powerpc/configs/gamecube_defconfig
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
