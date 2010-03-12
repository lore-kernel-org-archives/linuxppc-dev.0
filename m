Return-Path: <albert_herranz@yahoo.es>
Received: from smtp123.mail.ukl.yahoo.com (smtp123.mail.ukl.yahoo.com
	[77.238.184.54]) by ozlabs.org (Postfix) with SMTP id 1326BB7D22
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Mar 2010 06:12:55 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 00/11] wii: add usb 2.0 support
Date: Fri, 12 Mar 2010 20:12:35 +0100
Message-Id: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>
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

The first iterations (v1 to v3) of this patchset were submitted as RFC PATCH.
The patchset is now sent as PATCH targetted for mainline inclusion.

v3 -> v4
- Set the default IO TLB size via io_tlb_nslabs.
  Suggestion by Konrad Rzeszutek Wilk.
- Use kernel command line instead of device tree to tell the kernel about
  the location and size of the mem2_dma region.
  Suggestion by Segher Boessenkool.
- Keeps using v4 of the USB HCD_NO_COHERENT_MEM patch

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
 arch/powerpc/boot/wii.c                      |   44 +++++
 arch/powerpc/include/asm/device.h            |    1 +
 arch/powerpc/include/asm/dma-mapping.h       |    3 +
 arch/powerpc/include/asm/swiotlb.h           |    3 +
 arch/powerpc/include/asm/wii.h               |   25 +++
 arch/powerpc/kernel/dma.c                    |    5 +
 arch/powerpc/platforms/embedded6xx/Kconfig   |    3 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  265 ++++++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/wii.c     |    2 +
 arch/x86/include/asm/swiotlb.h               |   10 +
 drivers/usb/core/buffer.c                    |   29 +++-
 drivers/usb/core/hcd.c                       |  233 ++++++++++++++++-------
 drivers/usb/core/hcd.h                       |   13 +-
 drivers/usb/host/Kconfig                     |    8 +
 drivers/usb/host/ehci-hcd.c                  |    5 +
 drivers/usb/host/ehci-hlwd.c                 |  233 ++++++++++++++++++++++
 drivers/usb/host/ehci.h                      |   23 +++
 include/linux/swiotlb.h                      |    4 +
 include/linux/usb.h                          |    5 +
 lib/swiotlb.c                                |   60 +++++-
 22 files changed, 892 insertions(+), 94 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c
 create mode 100644 drivers/usb/host/ehci-hlwd.c
