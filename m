Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbcjk0SjdzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:16:58 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id p62so5689884oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 08:16:57 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
Subject: [PATCH v2 0/5] Removing full paths from DT full_name
Date: Mon, 21 Aug 2017 10:16:46 -0500
Message-Id: <20170821151651.25096-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is the last steps to remove storing the full path for every
DT node. Instead, we can create full path strings dynamically as needed
with printf %pOF specifiers (commit ce4fecf1fe15). There are a number of
remaining direct users of full_name after this series. I don't believe
there should be any functional impact for those users with the change to
only the node name (+unit-address). The majority are for struct
resource.name. This should only affect /proc/iomem display.

Michael, Please apply patches 1-3 for 4.14. Patches 4 and 5 are intended for 
4.15. Testing of those in particular would be helpful.

Rob

Rob Herring (5):
  powerpc: Convert to using %pOF instead of full_name
  powerpc: pseries: vio: match parent nodes with of_find_node_by_path
  powerpc: pseries: remove dlpar_attach_node dependency on full path
  powerpc: pseries: only store the device node basename in full_name
  of/fdt: only store the device node basename in full_name

 arch/powerpc/kernel/btext.c                      |   2 +-
 arch/powerpc/kernel/cacheinfo.c                  |  34 ++++---
 arch/powerpc/kernel/io-workarounds.c             |   4 +-
 arch/powerpc/kernel/isa-bridge.c                 |  32 +++----
 arch/powerpc/kernel/legacy_serial.c              |  12 +--
 arch/powerpc/kernel/of_platform.c                |   2 +-
 arch/powerpc/kernel/pci-common.c                 |  15 ++-
 arch/powerpc/kernel/pci_32.c                     |   4 +-
 arch/powerpc/kernel/pci_64.c                     |   4 +-
 arch/powerpc/kernel/pci_of_scan.c                |  24 ++---
 arch/powerpc/kernel/setup-common.c               |   2 +-
 arch/powerpc/platforms/4xx/cpm.c                 |   8 +-
 arch/powerpc/platforms/4xx/gpio.c                |   3 +-
 arch/powerpc/platforms/4xx/msi.c                 |   3 +-
 arch/powerpc/platforms/4xx/pci.c                 | 116 ++++++++++-------------
 arch/powerpc/platforms/4xx/soc.c                 |   5 +-
 arch/powerpc/platforms/4xx/uic.c                 |  14 +--
 arch/powerpc/platforms/512x/mpc512x_shared.c     |  12 +--
 arch/powerpc/platforms/52xx/efika.c              |   8 +-
 arch/powerpc/platforms/52xx/media5200.c          |   2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c        |   4 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c        |   8 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c   |   3 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c        |   2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c           |   8 +-
 arch/powerpc/platforms/85xx/xes_mpc85xx.c        |   4 +-
 arch/powerpc/platforms/amigaone/setup.c          |   6 +-
 arch/powerpc/platforms/cell/axon_msi.c           |  36 +++----
 arch/powerpc/platforms/cell/interrupt.c          |   4 +-
 arch/powerpc/platforms/cell/iommu.c              |  24 ++---
 arch/powerpc/platforms/cell/ras.c                |   4 +-
 arch/powerpc/platforms/cell/spider-pci.c         |   4 +-
 arch/powerpc/platforms/cell/spider-pic.c         |   4 +-
 arch/powerpc/platforms/cell/spu_manage.c         |  26 ++---
 arch/powerpc/platforms/chrp/pci.c                |  18 ++--
 arch/powerpc/platforms/embedded6xx/linkstation.c |   6 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c    |   2 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c  |   2 +-
 arch/powerpc/platforms/maple/pci.c               |  10 +-
 arch/powerpc/platforms/pasemi/pci.c              |   2 +-
 arch/powerpc/platforms/powermac/feature.c        |  14 +--
 arch/powerpc/platforms/powermac/low_i2c.c        |  50 +++++-----
 arch/powerpc/platforms/powermac/pci.c            |   6 +-
 arch/powerpc/platforms/powermac/pfunc_base.c     |  24 ++---
 arch/powerpc/platforms/powermac/pfunc_core.c     |   6 +-
 arch/powerpc/platforms/powermac/pic.c            |   8 +-
 arch/powerpc/platforms/powermac/setup.c          |   2 +-
 arch/powerpc/platforms/powernv/opal-async.c      |   4 +-
 arch/powerpc/platforms/powernv/opal-xscom.c      |   8 +-
 arch/powerpc/platforms/powernv/pci-ioda.c        |  15 ++-
 arch/powerpc/platforms/powernv/rng.c             |   6 +-
 arch/powerpc/platforms/pseries/dlpar.c           |  39 ++------
 arch/powerpc/platforms/pseries/event_sources.c   |   6 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c     |   6 +-
 arch/powerpc/platforms/pseries/ibmebus.c         |   5 +-
 arch/powerpc/platforms/pseries/iommu.c           |  58 ++++++------
 arch/powerpc/platforms/pseries/mobility.c        |   2 +-
 arch/powerpc/platforms/pseries/msi.c             |  12 +--
 arch/powerpc/platforms/pseries/pci_dlpar.c       |   2 +-
 arch/powerpc/platforms/pseries/pseries.h         |   2 +-
 arch/powerpc/platforms/pseries/reconfig.c        |   2 +-
 arch/powerpc/platforms/pseries/vio.c             |  10 +-
 arch/powerpc/sysdev/axonram.c                    |   4 +-
 arch/powerpc/sysdev/dcr.c                        |   4 +-
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c        |  12 +--
 arch/powerpc/sysdev/fsl_gtm.c                    |  14 +--
 arch/powerpc/sysdev/fsl_msi.c                    |  16 ++--
 arch/powerpc/sysdev/fsl_pci.c                    |  47 +++++----
 arch/powerpc/sysdev/fsl_rio.c                    |  36 +++----
 arch/powerpc/sysdev/fsl_rmu.c                    |  12 +--
 arch/powerpc/sysdev/mpic.c                       |   4 +-
 arch/powerpc/sysdev/mpic_msgr.c                  |   2 +-
 arch/powerpc/sysdev/mpic_msi.c                   |   2 +-
 arch/powerpc/sysdev/mpic_timer.c                 |  19 ++--
 arch/powerpc/sysdev/msi_bitmap.c                 |   4 +-
 arch/powerpc/sysdev/mv64x60_dev.c                |  20 ++--
 arch/powerpc/sysdev/mv64x60_pci.c                |   4 +-
 arch/powerpc/sysdev/of_rtc.c                     |  12 +--
 arch/powerpc/sysdev/scom.c                       |   5 +-
 arch/powerpc/sysdev/simple_gpio.c                |   3 +-
 arch/powerpc/sysdev/tsi108_pci.c                 |   4 +-
 arch/powerpc/sysdev/xive/native.c                |   2 +-
 drivers/of/fdt.c                                 |  69 +++-----------
 83 files changed, 487 insertions(+), 578 deletions(-)

-- 
2.11.0
