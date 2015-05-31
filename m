Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 663ED1A0C98
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010132.289674310@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:32 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC 00/24] Re-use nvram module
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The generic NVRAM module, drivers/char/generic_nvram, implements a
/dev/nvram misc device. It is used only by 32-bit PowerPC platforms and
isn't generic enough to be more widely used.

The RTC NVRAM module, drivers/char/nvram, also implements a /dev/nvram
misc device. It is used by x86, ARM and m68k.

The former module cannot be used on x86, ARM or m68k because it
cannot co-exist with the latter module, partly due to the Kconfig logic.

It is possible to modify the modules so that one kernel binary could
have either, neither or both. However, automatically loading the
appropriate module is then impossible; if both provide the
char-major-10-144 alias then the wrong module will end up being loaded.
Hence a multi-platform kernel binary needs a single generic nvram module
with alias char-major-10-144.

Therefore, drivers/char/nvram.c should be made more generic and the
arch-specific code therein should be moved to a more appropriate
place under arch/. Also, drivers/char/generic_nvram.c should be removed
to reduce code duplication.

In this patch series, Atari-specific code is moved from the nvram module
to arch/m68k/atari. More arch-specific code in the nvram module could
be moved, probably to arch/x86, but it is difficult to determine just
what code is relevant to ARM platforms and what code is x86-only.

In addressing code duplication, this patch series removes three
inconsistent /dev/nvram misc device implementations. One of these,
drivers/macintosh/nvram.c is entirely unused already. The other two,
drivers/char/generic_nvram.c and the misc device implementation in
arch/powerpc/kernel/nvram_64.c, are replaced by drivers/char/nvram.c.

A benefit of this work is better consistency -- between PPC32 and PPC64
as well as between PPC_PMAC and MAC. This new uniformity does have
implications for userspace, that is, some error codes for some ioctl calls
become consistent on all PowerPC platforms.

The drivers/char/nvram module becomes sufficiently generic to be useful
to other platforms and architectures, besides those with "CMOS" RTC. At the
end of this patch series the module is adopted by the m68k Mac port, which
already has PRAM access functions but lacks the /dev/nvram misc device.

This patch series has been compile-tested for arm, m68k, powerpc and x86.
The nvram and thinkpad_acpi modules were regression tested on a ThinkPad T43.
The /dev/nvram functionality was also regression tested on a G3 PowerMac.
The nvram module was also tested on a PowerBook 520 and Quadra 650.
Note that my testing doesn't cover PPC64 or Atari.

---
 arch/m68k/Kconfig                          |    3 
 arch/m68k/atari/Makefile                   |    2 
 arch/m68k/atari/nvram.c                    |  304 ++++++++++++
 arch/m68k/include/asm/atarihw.h            |    6 
 arch/m68k/include/asm/macintosh.h          |    4 
 arch/m68k/kernel/setup_mm.c                |   89 +++
 arch/m68k/mac/misc.c                       |  157 ++++--
 arch/powerpc/Kconfig                       |    5 
 arch/powerpc/include/asm/nvram.h           |    9 
 arch/powerpc/kernel/nvram_64.c             |  203 +-------
 arch/powerpc/kernel/setup_32.c             |   27 -
 arch/powerpc/platforms/chrp/Makefile       |    2 
 arch/powerpc/platforms/chrp/nvram.c        |   14 
 arch/powerpc/platforms/chrp/setup.c        |    2 
 arch/powerpc/platforms/powermac/Makefile   |    5 
 arch/powerpc/platforms/powermac/nvram.c    |   11 
 arch/powerpc/platforms/powermac/setup.c    |    3 
 drivers/char/Kconfig                       |   13 
 drivers/char/Makefile                      |    6 
 drivers/char/generic_nvram.c               |  174 ------
 drivers/char/nvram.c                       |  731 ++++++++++++-----------------
 drivers/macintosh/nvram.c                  |  130 -----
 drivers/platform/x86/thinkpad_acpi.c       |   20 
 drivers/scsi/Kconfig                       |    6 
 drivers/scsi/atari_scsi.c                  |   16 
 drivers/video/fbdev/controlfb.c            |    4 
 drivers/video/fbdev/imsttfb.c              |    7 
 drivers/video/fbdev/matrox/matroxfb_base.c |    4 
 drivers/video/fbdev/platinumfb.c           |    4 
 drivers/video/fbdev/valkyriefb.c           |    4 
 include/linux/nvram.h                      |   23 
 include/uapi/linux/pmu.h                   |    2 
 32 files changed, 950 insertions(+), 1040 deletions(-)
