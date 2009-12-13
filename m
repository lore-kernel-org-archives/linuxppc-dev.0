Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 437F5B7B64
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Dec 2009 18:18:27 +1100 (EST)
Received: by gxk28 with SMTP id 28so306895gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Dec 2009 23:18:25 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 13 Dec 2009 00:18:04 -0700
Message-ID: <fa686aa40912122318s4681c001j359e180a45ece078@mail.gmail.com>
Subject: Please pull nintendo wii/gamecube support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

I've picked up the Nintendo Gamecube & Wii support patch series and
compile tested it.  Looks all good to me.  Please pull.

Cheers,
g.

The following changes since commit 22763c5cf3690a681551162c15d34d935308c8d7:
  Linus Torvalds (1):
        Linux 2.6.32

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next

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


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
