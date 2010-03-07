Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id B2BF9B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Mar 2010 23:11:59 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 00/11] wii: add usb 2.0 support
Date: Sun,  7 Mar 2010 13:11:41 +0100
Message-Id: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
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

v2 -> v3
- use per-device dma coherent support to allocate coherent MEM2 memory
- add support for SWIOTLB on NOT_COHERENT_CACHE PowerPC platforms
- use SWIOTLB instead of dmabounce to implement Wii MEM2 dma ops
- use v4 of the USB HCD_NO_COHERENT_MEM patch

Albert Herranz (11):
  powerpc: add per-device dma coherent support
  powerpc: add min_direct_dma_addr
  swiotbl: add back swiotlb_alloc_boot()
  swiotlb: support NOT_COHERENT_CACHE PowerPC platforms
  swiotlb: add swiotlb_set_default_size()
  USB: refactor unmap_urb_for_dma/map_urb_for_dma
  USB: add HCD_NO_COHERENT_MEM host controller driver flag
  wii: have generic dma coherent
  wii: add mem2 dma mapping ops
  wii: enable swiotlb
  wii: hollywood ehci controller support

 arch/ia64/include/asm/swiotlb.h              |   10 +
 arch/powerpc/boot/wii.c                      |   34 ++++
 arch/powerpc/include/asm/device.h            |    1 +
 arch/powerpc/include/asm/dma-mapping.h       |    3 +
 arch/powerpc/include/asm/swiotlb.h           |    3 +
 arch/powerpc/include/asm/wii.h               |   25 +++
 arch/powerpc/kernel/dma.c                    |    5 +
 arch/powerpc/platforms/embedded6xx/Kconfig   |    3 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  255 ++++++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/wii.c     |    2 +
 arch/x86/include/asm/swiotlb.h               |   10 +
 drivers/usb/core/buffer.c                    |   29 +++-
 drivers/usb/core/hcd.c                       |  233 ++++++++++++++++--------
 drivers/usb/core/hcd.h                       |   13 +-
 drivers/usb/host/Kconfig                     |    8 +
 drivers/usb/host/ehci-hcd.c                  |    5 +
 drivers/usb/host/ehci-hlwd.c                 |  233 +++++++++++++++++++++++
 drivers/usb/host/ehci.h                      |   23 +++
 include/linux/swiotlb.h                      |    4 +
 include/linux/usb.h                          |    5 +
 lib/swiotlb.c                                |   67 ++++++-
 22 files changed, 878 insertions(+), 95 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c
 create mode 100644 drivers/usb/host/ehci-hlwd.c
