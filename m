Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7037DB70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:12 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 00/33] My PS3-specific patches for 2.6.31
Date: Wed, 10 Jun 2009 16:38:35 +0200
Message-Id: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


	Hi Ben,

Here are my PS3-specific patches for 2.6.31:
  [01] ps3av: Set 16:9 aspect ratio for 720p video modes
  [02] ps3vram: Fix error path (return -EIO) for short read/write
  [03] ps3vram: Use proc_create_data() instead of proc_create()
  [04] ps3vram: Correct exchanged gotos in ps3vram_probe() error path
  [05] block: Add bio_list_peek()
  [06] ps3vram: Replace mutex by spinlock + bio_list
  [07] ps3fb: Remove useless debug checks in ps3fb_shutdown()
  [08] ps3fb: Inline functions in ps3fb_probe(), to ease cleanup in the
       error path
  [09] ps3fb: Correct handling of device opening in ps3fb_probe()
  [10] powerpc/cell: Extract duplicated IOPTE_* to <asm/iommu.h>
  [11] ps3fb: GPU memory mapping cleanup
  [12] ps3vram: GPU memory mapping cleanup
  [13] ps3fb/vram: Extract common GPU stuff into <asm/ps3gpu.h>
  [14] ps3fb: Tear down FB setup during cleanup
  [15] ps3vram: Remove no longer used ps3vram_priv.ddr_base
  [16] ps3vram: Make ps3vram_priv.reports a void *
  [17] block/ps3: remove driver_data direct access of struct device
  [18] ps3: ps3_system_bus_device - Use dev_[gs]et_drvdata() instead of
       direct access
  [19] ps3: shorten ps3_system_bus_[gs]et_driver_data to
       ps3_system_bus_[gs]et_drvdata
  [20] ps3: ps3flash - Use ps3_system_bus_[gs]et_drvdata() instead of direct
       access
  [21] ps3: ps3rom - Use ps3_system_bus_[gs]et_drvdata() instead of direct
       access
  [22] ps3: ps3fb - Use ps3_system_bus_[gs]et_drvdata() instead of direct
       access
  [23] net/ps3: gelic - Add missing annotations
  [24] usb/ps3: Add missing annotations
  [25] drivers/ps3: Add missing annotations
  [26] sound/ps3: Fix checkpatch issues
  [27] sound/ps3: Restructure driver source
  [28] sound/ps3: Correct existing and add missing annotations
  [29] ps3: Correct debug message in dma_ioc0_map_pages()
  [30] ps3: Switch ps3_os_area_[gs]et_rtc_diff to EXPORT_SYMBOL_GPL()
  [31] ps3: Replace direct file operations by callback
  [32] ps3flash: Cache the last accessed FLASH chunk
  [33] ps3flash: Always read chunks of 256 KiB, and cache them

About half of these have been submitted and reviewed before, with review
comments taken into account.

Patches 05 (in response to feedback on v1 of 06) and 18-33 are new.

Given the interactions between powerpc/ps3-specific code and the various
subsystems, I think the easiest way is to get everything in via the
powerpc tree?

Thanks!

arch/powerpc/include/asm/ps3.h            |   16 
arch/powerpc/include/asm/ps3gpu.h         |    8 
arch/powerpc/platforms/ps3/mm.c           |    6 
arch/powerpc/platforms/ps3/os-area.c      |  138 +++---
b/arch/powerpc/include/asm/iommu.h        |   10 
b/arch/powerpc/include/asm/ps3.h          |    3 
b/arch/powerpc/include/asm/ps3gpu.h       |   78 +++
b/arch/powerpc/platforms/cell/iommu.c     |   37 -
b/arch/powerpc/platforms/ps3/mm.c         |    7 
b/arch/powerpc/platforms/ps3/os-area.c    |    5 
b/arch/powerpc/platforms/ps3/platform.h   |   10 
b/arch/powerpc/platforms/ps3/setup.c      |    1 
b/arch/powerpc/platforms/ps3/system-bus.c |   16 
b/drivers/block/ps3disk.c                 |   23 -
b/drivers/block/ps3vram.c                 |    2 
b/drivers/char/ps3flash.c                 |   13 
b/drivers/net/ps3_gelic_net.c             |    8 
b/drivers/net/ps3_gelic_wireless.c        |    7 
b/drivers/ps3/ps3-sys-manager.c           |    2 
b/drivers/ps3/ps3av.c                     |    5 
b/drivers/ps3/ps3av_cmd.c                 |    3 
b/drivers/scsi/ps3rom.c                   |   11 
b/drivers/usb/host/ehci-ps3.c             |    7 
b/drivers/usb/host/ohci-ps3.c             |    8 
b/drivers/video/ps3fb.c                   |   15 
b/include/linux/bio.h                     |    6 
b/sound/ppc/snd_ps3.c                     |   33 -
drivers/block/ps3disk.c                   |   23 -
drivers/block/ps3vram.c                   |  228 +++++-----
drivers/char/ps3flash.c                   |  353 +++++++++-------
drivers/net/ps3_gelic_net.c               |   22 -
drivers/ps3/ps3av.c                       |    5 
drivers/usb/host/ehci-ps3.c               |    4 
drivers/usb/host/ohci-ps3.c               |    5 
drivers/video/ps3fb.c                     |  312 ++++++--------
sound/ppc/snd_ps3.c                       |  635 +++++++++++++-----------------
36 files changed, 1045 insertions(+), 1020 deletions(-)

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
