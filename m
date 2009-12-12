Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id 36046B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 03:32:04 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/22] powerpc: nintendo gamecube and wii support
Date: Sat, 12 Dec 2009 17:31:33 +0100
Message-Id: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
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
- workarounds to enable the use of the second discontiguous RAM block

With these patches both video game consoles can fully boot up to the
root filesystem mount phase.

Albert Herranz (22):
  powerpc: gamecube/wii: usbgecko bootwrapper console support
  powerpc: gamecube: device tree
  powerpc: gamecube: bootwrapper bits
  powerpc: gamecube/wii: introduce GAMECUBE_COMMON
  powerpc: gamecube/wii: declare as non-coherent platforms
  powerpc: gamecube/wii: do not include PCI support
  powerpc: gamecube/wii: udbg support for usbgecko
  powerpc: gamecube/wii: flipper interrupt controller support
  powerpc: gamecube: platform support
  powerpc: gamecube: default config
  powerpc: wii: device tree
  powerpc: wii: bootwrapper bits
  powerpc: broadway processor support
  powerpc: wii: hollywood interrupt controller support
  powerpc: wii: platform support
  powerpc: wii: default config
  powerpc: reserve fixmap entries for early debug
  powerpc: gamecube/wii: early debugging using usbgecko
  wii: bootwrapper: add fixup to calc useable mem2
  wii: use both mem1 and mem2 as ram
  powerpc: allow ioremap within reserved memory regions
  powerpc: wii: allow ioremap within the memory hole

 .../powerpc/dts-bindings/nintendo/gamecube.txt     |  109 ++
 .../powerpc/dts-bindings/nintendo/wii.txt          |  184 +++
 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/Kconfig.debug                         |    8 +
 arch/powerpc/boot/Makefile                         |    7 +-
 arch/powerpc/boot/dts/gamecube.dts                 |  114 ++
 arch/powerpc/boot/dts/wii.dts                      |  218 +++
 arch/powerpc/boot/gamecube-head.S                  |  111 ++
 arch/powerpc/boot/gamecube.c                       |   35 +
 arch/powerpc/boot/ugecon.c                         |  147 ++
 arch/powerpc/boot/ugecon.h                         |   24 +
 arch/powerpc/boot/wii-head.S                       |  142 ++
 arch/powerpc/boot/wii.c                            |  158 +++
 arch/powerpc/boot/wrapper                          |    4 +
 arch/powerpc/configs/gamecube_defconfig            | 1061 +++++++++++++++
 arch/powerpc/configs/wii_defconfig                 | 1406 ++++++++++++++++++++
 arch/powerpc/include/asm/fixmap.h                  |    3 +
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/cputable.c                     |    6 +-
 arch/powerpc/kernel/head_32.S                      |   25 +
 arch/powerpc/kernel/udbg.c                         |    2 +
 arch/powerpc/mm/init_32.c                          |    9 +
 arch/powerpc/mm/mmu_decl.h                         |   11 +-
 arch/powerpc/mm/pgtable_32.c                       |   36 +-
 arch/powerpc/mm/ppc_mmu_32.c                       |    4 +-
 arch/powerpc/platforms/Kconfig.cputype             |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig         |   33 +
 arch/powerpc/platforms/embedded6xx/Makefile        |    4 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |  263 ++++
 arch/powerpc/platforms/embedded6xx/flipper-pic.h   |   25 +
 arch/powerpc/platforms/embedded6xx/gamecube.c      |  118 ++
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |  241 ++++
 arch/powerpc/platforms/embedded6xx/hlwd-pic.h      |   22 +
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |  328 +++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |   32 +
 arch/powerpc/platforms/embedded6xx/wii.c           |  268 ++++
 include/linux/lmb.h                                |    1 +
 lib/lmb.c                                          |    7 +-
 38 files changed, 5155 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/nintendo/gamecube.txt
 create mode 100644 Documentation/powerpc/dts-bindings/nintendo/wii.txt
 create mode 100644 arch/powerpc/boot/dts/gamecube.dts
 create mode 100644 arch/powerpc/boot/dts/wii.dts
 create mode 100644 arch/powerpc/boot/gamecube-head.S
 create mode 100644 arch/powerpc/boot/gamecube.c
 create mode 100644 arch/powerpc/boot/ugecon.c
 create mode 100644 arch/powerpc/boot/ugecon.h
 create mode 100644 arch/powerpc/boot/wii-head.S
 create mode 100644 arch/powerpc/boot/wii.c
 create mode 100644 arch/powerpc/configs/gamecube_defconfig
 create mode 100644 arch/powerpc/configs/wii_defconfig
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/wii.c
