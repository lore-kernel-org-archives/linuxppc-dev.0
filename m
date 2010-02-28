Return-Path: <albert_herranz@yahoo.es>
Received: from smtp138.mail.ukl.yahoo.com (smtp138.mail.ukl.yahoo.com
	[77.238.184.69]) by ozlabs.org (Postfix) with SMTP id 7E386B7D2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:08:22 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 0/9] wii: add usb 2.0 support
Date: Sun, 28 Feb 2010 15:07:53 +0100
Message-Id: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch series adds USB 2.0 support for the Wii PowerPC
platform via the EHCI controller present in the "Hollywood" chipset
of the video game console.

v1 -> v2
- enable per-device DMA coherent support on the Wii
- add a generic dmabounce based on ARM dmabounce
- make PowerPC and ARM use the generic dmabounce support
  (ARM just compile-tested)
- do not bounce buffers at the USB layer
- handle bounce buffers on the Wii at the platform support layer via the
  DMA API
- introduce a flag HCD_NO_COHERENT_MEM to avoid using coherent memory for
  USB buffers
- make the "Hollywood" EHCI controller use HCD_NO_COHERENT_MEM and honor
  MEM2 DMA constraints to solve the platform restrictions accessing
  coherent memory.

Albert Herranz (9):
  powerpc: add per-device dma coherent support
  wii: have generic dma coherent
  dma-coherent: fix bitmap access races
  add generic dmabounce support
  arm: use generic dmabounce support
  powerpc: add optional per-device dmabounce support
  wii: add mem2 dma mapping ops
  USB: add HCD_NO_COHERENT_MEM host controller driver flag
  wii: hollywood ehci controller support

 arch/Kconfig                                 |    3 +
 arch/arm/Kconfig                             |    4 +-
 arch/arm/common/Kconfig                      |    6 +-
 arch/arm/common/dmabounce.c                  |  376 +++--------------
 arch/arm/include/asm/device.h                |    2 +-
 arch/powerpc/boot/wii.c                      |   34 ++
 arch/powerpc/include/asm/device.h            |    3 +
 arch/powerpc/include/asm/dma-mapping.h       |    1 +
 arch/powerpc/include/asm/wii.h               |   25 ++
 arch/powerpc/kernel/dma.c                    |    5 +
 arch/powerpc/platforms/embedded6xx/Kconfig   |    3 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  557 ++++++++++++++++++++++++++
 drivers/base/dma-coherent.c                  |   11 +
 drivers/usb/core/buffer.c                    |   15 +-
 drivers/usb/core/hcd.c                       |   50 ++-
 drivers/usb/core/hcd.h                       |   13 +-
 drivers/usb/host/Kconfig                     |    8 +
 drivers/usb/host/ehci-hcd.c                  |    5 +
 drivers/usb/host/ehci-hlwd.c                 |  233 +++++++++++
 drivers/usb/host/ehci.h                      |   23 +
 include/linux/dmabounce.h                    |   71 ++++
 lib/Kconfig                                  |   10 +
 lib/Makefile                                 |    2 +
 lib/dmabounce.c                              |  389 ++++++++++++++++++
 25 files changed, 1512 insertions(+), 339 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c
 create mode 100644 drivers/usb/host/ehci-hlwd.c
 create mode 100644 include/linux/dmabounce.h
 create mode 100644 lib/dmabounce.c
