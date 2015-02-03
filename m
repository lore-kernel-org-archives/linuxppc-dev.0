Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 583A81A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 16:36:01 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 agraf@suse.de
Subject: [PATCH 0/5] powerpc: Get rid of redundant arch specific swab functions
Date: Tue,  3 Feb 2015 16:36:20 +1100
Message-Id: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mdroth@us.ibm.com, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/include/asm/swab.h includes some powerpc specific
byteswapping functions, which are implemented in terms of powerpc's
built in byte reversed load/store instructions.  There are two problems with this:

1) They're not necessary - gcc is perfectly capable of generating the
   byte-reversed load and store instructions when using the normal,
   generic byteswapping functions (tested with gcc (GCC) 4.8.3
   20140911 (Red Hat 4.8.3-9))

2) They've become poorly named.  The ld_le*() and st_le*() functions
   in fact *always* byteswap, even in a little-endian powerpc kernel
   build, in which case they'll actually be performing BE accesses.

This series removes the existing users of these arch-specific
functions, replacing them with calls to the generic byteswappers.  5/5
then removes the function definitions.

I've compile tested this series with pmac32_defconfig,
mpc512x_defconfig and ppc64_defconfig, and also those configs tweaked
to explicitly enable the BT8XX and MXC MMC drivers where possible.

I've tested the KVM patch (4/5) with both BE and LE guests, however I
don't have hardware to do any real testing of the drivers affected in
1..3/5.

David Gibson (5):
  powerpc: Move Power Macintosh drivers to generic byteswappers
  powerpc: Remove powerpc specific byteswap from bt8xx DVB driver
  powerpc: Remove arch specific byteswappers from the MXC MMC driver
  powerpc: Cleanup KVM emulated load/store endian handling
  powerpc: Remove unused st_le*() and ld_le* functions

 arch/powerpc/include/asm/dbdma.h    | 12 ++++----
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/powerpc/include/asm/swab.h     | 26 -----------------
 arch/powerpc/include/asm/vga.h      |  4 +--
 arch/powerpc/kvm/powerpc.c          | 38 ++++++++++++------------
 drivers/ata/pata_macio.c            | 10 +++----
 drivers/block/swim3.c               | 12 ++++----
 drivers/ide/pmac.c                  | 10 +++----
 drivers/macintosh/rack-meter.c      | 30 +++++++++----------
 drivers/media/pci/bt8xx/bt878.h     |  4 +--
 drivers/mmc/host/mxcmmc.c           |  2 +-
 drivers/net/ethernet/apple/bmac.c   | 30 +++++++++----------
 drivers/net/ethernet/apple/mace.c   | 44 ++++++++++++++--------------
 drivers/scsi/mac53c94.c             | 10 +++----
 drivers/scsi/mesh.c                 | 14 ++++-----
 drivers/video/fbdev/controlfb.c     |  2 +-
 drivers/video/fbdev/platinumfb.c    |  2 +-
 sound/ppc/pmac.c                    | 58 ++++++++++++++++++-------------------
 18 files changed, 141 insertions(+), 169 deletions(-)

-- 
2.1.0
