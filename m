Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-x233.google.com (mail-ob0-x233.google.com
 [IPv6:2607:f8b0:4003:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C42C1400AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 09:17:29 +1100 (EST)
Received: by mail-ob0-f179.google.com with SMTP id va2so2658716obc.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Apr 2014 15:17:26 -0700 (PDT)
From: Rob Herring <robherring2@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] FDT clean-ups and libfdt support
Date: Thu,  3 Apr 2014 17:16:43 -0500
Message-Id: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
Cc: linux-mips@linux-mips.org, Aurelien Jacquiot <a-jacquiot@ti.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linux@lists.openrisc.net,
 Jonas Bonn <jonas@southpole.se>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>,
 linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Herring <robh@kernel.org>

This is a series of clean-ups of architecture FDT code and converts the
core FDT code over to using libfdt functions. This is in preparation
to add FDT based address translation parsing functions for early
console support. 

The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
to be copied out of init section. Patches 2 and 3 should be applied to
3.15.

A branch is available here[1]. Please test! I've compiled on arm,
arm64, mips, microblaze, and powerpc and booted on arm and arm64.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git libfdt

Rob Herring (20):
  mips: octeon: convert to use unflatten_and_copy_device_tree
  mips: lantiq: copy built-in DTB out of init section
  mips: xlp: copy built-in DTB out of init section
  mips: ralink: convert to use unflatten_and_copy_device_tree
  ARM: dt: use default early_init_dt_alloc_memory_arch
  c6x: convert fdt pointers to opaque pointers
  mips: convert fdt pointers to opaque pointers
  of/fdt: consolidate built-in dtb section variables
  of/fdt: create common debugfs
  of/fdt: remove some unneeded includes
  of/fdt: remove unused of_scan_flat_dt_by_path
  of/fdt: update of_get_flat_dt_prop in prep for libfdt
  of/fdt: Convert FDT functions to use libfdt
  of/fdt: use libfdt accessors for header data
  of/fdt: move memreserve and dtb memory reservations into core
  build: add libfdt include path globally
  powerpc: use libfdt accessors for header data
  x86: use libfdt accessors for header data
  of/fdt: convert initial_boot_params to opaque pointer
  of: push struct boot_param_header and defines into powerpc

 Makefile                                    |   5 +
 arch/arc/include/asm/sections.h             |   1 -
 arch/arc/kernel/devtree.c                   |   2 +-
 arch/arm/include/asm/prom.h                 |   2 -
 arch/arm/kernel/devtree.c                   |  34 +--
 arch/arm/mach-exynos/exynos.c               |   2 +-
 arch/arm/mach-vexpress/platsmp.c            |   2 +-
 arch/arm/mm/init.c                          |   1 -
 arch/arm/plat-samsung/s5p-dev-mfc.c         |   4 +-
 arch/arm64/mm/init.c                        |  21 --
 arch/c6x/kernel/setup.c                     |   4 +-
 arch/metag/kernel/setup.c                   |   4 -
 arch/microblaze/kernel/prom.c               |  37 +--
 arch/mips/cavium-octeon/Makefile            |   3 -
 arch/mips/cavium-octeon/setup.c             |  18 +-
 arch/mips/include/asm/mips-boards/generic.h |   4 -
 arch/mips/include/asm/prom.h                |   6 +-
 arch/mips/kernel/prom.c                     |   2 +-
 arch/mips/lantiq/prom.c                     |  15 +-
 arch/mips/lantiq/prom.h                     |   2 -
 arch/mips/mti-sead3/Makefile                |   2 -
 arch/mips/mti-sead3/sead3-setup.c           |   8 +-
 arch/mips/netlogic/xlp/dt.c                 |  17 +-
 arch/mips/ralink/of.c                       |  29 +--
 arch/openrisc/kernel/vmlinux.h              |   2 -
 arch/powerpc/include/asm/prom.h             |  39 +++
 arch/powerpc/kernel/epapr_paravirt.c        |   2 +-
 arch/powerpc/kernel/fadump.c                |   4 +-
 arch/powerpc/kernel/prom.c                  |  77 ++----
 arch/powerpc/kernel/rtas.c                  |   2 +-
 arch/powerpc/mm/hash_utils_64.c             |  22 +-
 arch/powerpc/platforms/52xx/efika.c         |   4 +-
 arch/powerpc/platforms/chrp/setup.c         |   4 +-
 arch/powerpc/platforms/powernv/opal.c       |  12 +-
 arch/powerpc/platforms/pseries/setup.c      |   4 +-
 arch/x86/kernel/devicetree.c                |   7 +-
 arch/xtensa/kernel/setup.c                  |   3 +-
 drivers/of/Kconfig                          |   1 +
 drivers/of/fdt.c                            | 379 +++++++++-------------------
 drivers/of/of_reserved_mem.c                |   4 +-
 include/linux/of_fdt.h                      |  64 +----
 lib/Makefile                                |   2 -
 42 files changed, 261 insertions(+), 596 deletions(-)

-- 
1.8.3.2
