Return-Path: <albert_herranz@yahoo.es>
Received: from smtp136.mail.ukl.yahoo.com (smtp136.mail.ukl.yahoo.com
	[77.238.184.67]) by ozlabs.org (Postfix) with SMTP id BA72CB7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 09:47:38 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 0/6] powerpc: nintendo wii support
Date: Thu,  3 Dec 2009 23:47:21 +0100
Message-Id: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patches add the base support for the Nintendo Wii
video game console on the powerpc arch.

The following is included:
- a device tree source
- bootwrapper support
- recognition of the Broadway processor
- native interrupt controller support
- platform support
- default configuration

With these patches the video game console can fully boot up to the
root filesystem mount phase.

Note that at this stage the video game console will _only_ use the
first contiguous memory range (MEM1, 24MB) as RAM.
Changes needed to support the second memory range (MEM2, 64MB) will
be posted separately to simplify the review and possible merging.

Albert Herranz (6):
  powerpc: wii: device tree
  powerpc: wii: bootwrapper bits
  powerpc: broadway processor support
  powerpc: wii: hollywood interrupt controller support
  powerpc: wii: platform support
  powerpc: wii: default config

 .../powerpc/dts-bindings/nintendo/wii.txt          |  184 +++
 arch/powerpc/boot/Makefile                         |    3 +-
 arch/powerpc/boot/dts/wii.dts                      |  218 +++
 arch/powerpc/boot/wii-head.S                       |  142 ++
 arch/powerpc/boot/wii.c                            |   46 +
 arch/powerpc/boot/wrapper                          |    2 +-
 arch/powerpc/configs/wii_defconfig                 | 1406 ++++++++++++++++++++
 arch/powerpc/kernel/cputable.c                     |    6 +-
 arch/powerpc/platforms/embedded6xx/Kconfig         |    8 +
 arch/powerpc/platforms/embedded6xx/Makefile        |    1 +
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |  241 ++++
 arch/powerpc/platforms/embedded6xx/hlwd-pic.h      |   22 +
 arch/powerpc/platforms/embedded6xx/wii.c           |  195 +++
 13 files changed, 2469 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/nintendo/wii.txt
 create mode 100644 arch/powerpc/boot/dts/wii.dts
 create mode 100644 arch/powerpc/boot/wii-head.S
 create mode 100644 arch/powerpc/boot/wii.c
 create mode 100644 arch/powerpc/configs/wii_defconfig
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/wii.c
