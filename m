Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 881021007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:03 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 00/19] powerpc: nintendo gamecube and wii support
Date: Sun, 22 Nov 2009 23:01:31 +0100
Message-Id: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
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
and Wii video game consoles on the powerpc arch.

For each video game console, the following is included:
- a device tree source
- bootwrapper support
- udbg console option
- early udbg console option
- interrupt controller support
- platform support

The Nintendo Wii patches also include support for:
- recognition of the broadway processor
- ipc communication with the open source 'mini' firmware replacement

With these patches both video game consoles can fully boot up to the
root filesystem mount phase.

Albert Herranz (19):
  powerpc: gamecube/wii: usbgecko bootwrapper console support
  powerpc: gamecube: device tree
  powerpc: gamecube: bootwrapper bits
  powerpc: wii: device tree
  powerpc: wii: bootwrapper bits
  powerpc: gamecube/wii: introduce GAMECUBE_COMMON
  powerpc: gamecube/wii: declare as non-coherent platforms
  powerpc: gamecube/wii: do not include PCI support
  powerpc: gamecube/wii: udbg support for usbgecko
  powerpc: gamecube/wii: early debugging using usbgecko
  powerpc: gamecube/wii: flipper interrupt controller support
  powerpc: gamecube: platform support
  powerpc: gamecube: default config
  powerpc: allow ioremap within reserved fake ram regions
  powerpc: broadway processor support
  powerpc: wii: hollywood interrupt controller support
  powerpc: wii: bootmii starlet 'mini' firmware support
  powerpc: wii: platform support
  powerpc: wii: default config

 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/Kconfig.debug                         |    8 +
 arch/powerpc/boot/Makefile                         |    7 +-
 arch/powerpc/boot/dts/gamecube.dts                 |  135 ++
 arch/powerpc/boot/dts/wii.dts                      |  244 ++++
 arch/powerpc/boot/gamecube.c                       |   78 ++
 arch/powerpc/boot/ugecon.c                         |  128 ++
 arch/powerpc/boot/ugecon.h                         |   25 +
 arch/powerpc/boot/wii.c                            |  173 +++
 arch/powerpc/boot/wrapper                          |    3 +
 arch/powerpc/configs/gamecube_defconfig            | 1061 +++++++++++++++
 arch/powerpc/configs/wii_defconfig                 | 1406 ++++++++++++++++++++
 arch/powerpc/include/asm/starlet-mini.h            |  175 +++
 arch/powerpc/include/asm/starlet.h                 |   26 +
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/cputable.c                     |   28 +-
 arch/powerpc/kernel/head_32.S                      |   21 +
 arch/powerpc/kernel/udbg.c                         |    2 +
 arch/powerpc/mm/pgtable_32.c                       |   19 +-
 arch/powerpc/platforms/Kconfig.cputype             |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig         |   57 +
 arch/powerpc/platforms/embedded6xx/Makefile        |    6 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |  247 ++++
 arch/powerpc/platforms/embedded6xx/flipper-pic.h   |   25 +
 arch/powerpc/platforms/embedded6xx/gamecube.c      |  112 ++
 arch/powerpc/platforms/embedded6xx/gamecube_dev.c  |   34 +
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |  238 ++++
 arch/powerpc/platforms/embedded6xx/hlwd-pic.h      |   22 +
 arch/powerpc/platforms/embedded6xx/starlet-mipc.c  | 1053 +++++++++++++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |  318 +++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |   36 +
 arch/powerpc/platforms/embedded6xx/wii.c           |  270 ++++
 arch/powerpc/platforms/embedded6xx/wii_dev.c       |   47 +
 33 files changed, 5988 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/gamecube.dts
 create mode 100644 arch/powerpc/boot/dts/wii.dts
 create mode 100644 arch/powerpc/boot/gamecube.c
 create mode 100644 arch/powerpc/boot/ugecon.c
 create mode 100644 arch/powerpc/boot/ugecon.h
 create mode 100644 arch/powerpc/boot/wii.c
 create mode 100644 arch/powerpc/configs/gamecube_defconfig
 create mode 100644 arch/powerpc/configs/wii_defconfig
 create mode 100644 arch/powerpc/include/asm/starlet-mini.h
 create mode 100644 arch/powerpc/include/asm/starlet.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube_dev.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/starlet-mipc.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/wii.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/wii_dev.c
