Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9AFC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:26:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AF420656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AF420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dy3D1MwzzDqYM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:26:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyC1zBmzDqX3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:26 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 8680929E62; Mon, 14 Jan 2019 23:22:23 -0500 (EST)
Message-Id: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 00/22] Re-use nvram module
Date: Tue, 15 Jan 2019 15:18:56 +1100
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Joshua Thompson <funaho@jurai.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-fbdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The "generic" NVRAM module, drivers/char/generic_nvram.c, implements a
/dev/nvram misc device. This module is used only by 32-bit PowerPC
platforms.

The RTC "CMOS" NVRAM module, drivers/char/nvram.c, also implements a
/dev/nvram misc device. This module is now used only by x86 and m68k
thanks to commit 3ba9faedc180 ("char: nvram: disable on ARM").

The "generic" module cannot be used by x86 or m68k platforms because it
cannot co-exist with the "CMOS" module. One reason for that is the
CONFIG_GENERIC_NVRAM kludge in drivers/char/Makefile. Another reason is
that automatically loading the appropriate module would be impossible
because only one module can provide the char-major-10-144 alias.

A multi-platform kernel binary needs a single, generic module. With this
patch series, drivers/char/nvram.c becomes more generic and some of the
arch-specific code gets moved under arch/. The nvram module is then
usable by all m68k, powerpc and x86 platforms.

This allows for removal of drivers/char/generic_nvram.c as well as a
duplicate in arch/powerpc/kernel/nvram_64.c. By reducing the number of
/dev/nvram char misc device implementations, the number of bugs and
inconsistencies is also reduced.

This approach reduces inconsistencies between PPC32 and PPC64 and also
between PPC_PMAC and MAC. A uniform API has benefits for userspace.

For example, some error codes for some ioctl calls become consistent
across PowerPC platforms. The uniform API can potentially benefit any
bootloader that works across the various platforms having XPRAM
(e.g. Emile).

This patch series was tested on Atari, Mac, PowerMac (both 32-bit and
64-bit) and ThinkPad hardware. AFAIK, it has not yet been tested on
pSeries or CHRP.

I think there are two possible merge strategies for this patch series.
The char misc maintainer could take the entire series. Alternatively,
the m68k maintainer could take patches 1 thru 16 (though some of these
have nothing to do with m68k) and after those patches reach mainline
the powerpc maintainer could take 17 thru 22.

Changed since v8:
 - Replaced defined(CONFIG_NVRAM) with IS_REACHABLE(CONFIG_NVRAM) as
suggested by James Bottomley.
 - Changed #ifdef to if as suggested by Christophe Leroy.
 - Expanded the fbdev patch to include controlfb.c and platinumfb.c.
 - Added kernel-doc comment to describe struct nvram_ops.
 - Moved the HAVE_ARCH_NVRAM_OPS symbol to common code as suggested
by Christoph Hellwig.
 - Abandoned conversion of powerpc drivers to arch_nvram_ops, as discussed
with Arnd Bergmann.
 - Dropped patch 6 ("x86/thinkpad_acpi: Use arch_nvram_ops methods").
 - Dropped patch 17 ("powerpc: Implement arch_nvram_ops.get_size() ...").
 - Dropped patch 20 ("powerpc, fbdev: Use arch_nvram_ops methods ...").
 - Dropped patch 25 ("powerpc: Remove pmac_xpram_{read,write} functions").
 - Added portable static functions to nvram.h which wrap both arch_nvram_ops
and ppc_md method calls.
 - Re-ordered and revised patches to resolve conflicts with existing extern
definitions in nvram.h and elsewhere.
 - Rebased on v5.0-rc2.
 - Added patch 14 ("macintosh/via-cuda: Don't rely on Cuda to end a transfer").

Changed since v7:
 - Rebased.
 - Dropped patch 9/26, "char/nvram: Use generic fixed_size_llseek()"
because generic_file_llseek_size() was adopted in commit b808b1d632f6.
 - Reordered the m68k and powerpc patches to simplify the merge strategy.
 - Addressed some trivial checkpatch.pl complaints.
 - Improved some commit log entries.
 - Changed the CONFIG_NVRAM default to better approximate the present code.
In particular, the CONFIG_GENERIC_NVRAM default and use of "select NVRAM".
 - Added more tested-by tags.

For older change logs, please refer to,
https://lore.kernel.org/lkml/20151101104202.301856132@telegraphics.com.au/


Finn Thain (22):
  scsi/atari_scsi: Don't select CONFIG_NVRAM
  m68k/atari: Move Atari-specific code out of drivers/char/nvram.c
  char/nvram: Re-order functions to remove forward declarations and
    #ifdefs
  nvram: Replace nvram_* function exports with static functions
  m68k/atari: Implement arch_nvram_ops struct
  powerpc: Replace nvram_* extern declarations with standard header
  char/nvram: Adopt arch_nvram_ops
  char/nvram: Allow the set_checksum and initialize ioctls to be omitted
  char/nvram: Implement NVRAM read/write methods
  m68k/atari: Implement arch_nvram_ops methods and enable
    CONFIG_HAVE_ARCH_NVRAM_OPS
  m68k/mac: Adopt naming and calling conventions for PRAM routines
  m68k/mac: Use macros for RTC accesses not magic numbers
  m68k/mac: Fix PRAM accessors
  macintosh/via-cuda: Don't rely on Cuda to end a transfer
  m68k: Dispatch nvram_ops calls to Atari or Mac functions
  char/nvram: Add "devname:nvram" module alias
  powerpc: Define missing ppc_md.nvram_size for CHRP and PowerMac
  powerpc: Implement nvram ioctls
  powerpc, fbdev: Use NV_CMODE and NV_VMODE only when CONFIG_PPC32 &&
    CONFIG_PPC_PMAC && CONFIG_NVRAM
  powerpc: Enable HAVE_ARCH_NVRAM_OPS and disable GENERIC_NVRAM
  char/generic_nvram: Remove as unused
  powerpc: Adopt nvram module for PPC64

 arch/Kconfig                               |   3 +
 arch/m68k/Kconfig.machine                  |   2 +
 arch/m68k/atari/Makefile                   |   2 +
 arch/m68k/atari/nvram.c                    | 272 +++++++++
 arch/m68k/include/asm/atarihw.h            |   6 +
 arch/m68k/include/asm/macintosh.h          |   4 +
 arch/m68k/kernel/setup_mm.c                |  82 ++-
 arch/m68k/mac/misc.c                       | 174 ++++--
 arch/powerpc/Kconfig                       |   6 +-
 arch/powerpc/include/asm/nvram.h           |   9 -
 arch/powerpc/kernel/nvram_64.c             | 158 +----
 arch/powerpc/kernel/setup_32.c             |  36 +-
 arch/powerpc/platforms/chrp/Makefile       |   2 +-
 arch/powerpc/platforms/chrp/nvram.c        |  14 +-
 arch/powerpc/platforms/chrp/setup.c        |   2 +-
 arch/powerpc/platforms/powermac/Makefile   |   2 -
 arch/powerpc/platforms/powermac/nvram.c    |   9 +
 arch/powerpc/platforms/powermac/setup.c    |   3 +-
 arch/powerpc/platforms/powermac/time.c     |   2 +-
 arch/powerpc/platforms/pseries/nvram.c     |   2 -
 drivers/char/Kconfig                       |  19 +-
 drivers/char/Makefile                      |   6 +-
 drivers/char/generic_nvram.c               | 159 -----
 drivers/char/nvram.c                       | 673 ++++++++-------------
 drivers/macintosh/via-cuda.c               |   8 +-
 drivers/scsi/Kconfig                       |   6 +-
 drivers/scsi/atari_scsi.c                  |  10 +-
 drivers/video/fbdev/Kconfig                |   2 +-
 drivers/video/fbdev/controlfb.c            |  42 +-
 drivers/video/fbdev/imsttfb.c              |  23 +-
 drivers/video/fbdev/matrox/matroxfb_base.c |   7 +-
 drivers/video/fbdev/platinumfb.c           |  21 +-
 drivers/video/fbdev/valkyriefb.c           |  30 +-
 include/linux/nvram.h                      | 133 +++-
 include/uapi/linux/pmu.h                   |   2 +
 35 files changed, 966 insertions(+), 965 deletions(-)
 create mode 100644 arch/m68k/atari/nvram.c
 delete mode 100644 drivers/char/generic_nvram.c

-- 
2.19.2

