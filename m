Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id 7CCBFB7D84
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 05:33:00 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v5 00/10] wii: add usb 2.0 support
Date: Fri, 19 Mar 2010 19:32:16 +0100
Message-Id: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, stern@rowland.harvard.edu,
	konrad.wilk@oracle.com
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

v4 -> v5
- Set the default IO TLB size via the kernel command line.
  This is now possible on PowerPC thanks to a recent patch by Fujita Tomonori.
- swiotlb support for the Wii is now based on top of the swiotlb-0.6
  patches from Konrad Rzeszutek Wilk.
- Keeps using v4 of the USB HCD_NO_COHERENT_MEM patch

Alan: I think you are also working in a patchset to make {un}map_urb_for_dma
remember how the urb was mapped, right?

Albert Herranz (10):
  swiotbl: add back swiotlb_alloc_boot()
  swiotlb: make swiotlb_bounce() __weak
  powerpc: add per-device dma coherent support
  powerpc: add min_direct_dma_addr
  USB: refactor unmap_urb_for_dma/map_urb_for_dma
  USB: add HCD_NO_COHERENT_MEM host controller driver flag
  wii: have generic dma coherent
  wii: add mem2 dma mapping ops
  wii: enable swiotlb
  wii: hollywood ehci controller support

 arch/powerpc/boot/dts/wii.dts                |    2 +-
 arch/powerpc/boot/wii.c                      |   44 +++
 arch/powerpc/include/asm/device.h            |    1 +
 arch/powerpc/include/asm/dma-mapping.h       |    3 +
 arch/powerpc/include/asm/wii.h               |   25 ++
 arch/powerpc/kernel/dma.c                    |    5 +
 arch/powerpc/platforms/embedded6xx/Kconfig   |    3 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  475 ++++++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/wii.c     |    1 +
 drivers/usb/core/buffer.c                    |   29 ++-
 drivers/usb/core/hcd.c                       |  233 +++++++++----
 drivers/usb/core/hcd.h                       |   13 +-
 drivers/usb/host/Kconfig                     |    8 +
 drivers/usb/host/ehci-hcd.c                  |    5 +
 drivers/usb/host/ehci-hlwd.c                 |  233 +++++++++++++
 drivers/usb/host/ehci.h                      |   23 ++
 include/linux/swiotlb.h                      |    1 +
 include/linux/usb.h                          |    5 +
 lib/swiotlb.c                                |   12 +-
 20 files changed, 1033 insertions(+), 90 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c
 create mode 100644 drivers/usb/host/ehci-hlwd.c
