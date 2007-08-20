Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18121.9805.851389.330298@cargo.ozlabs.ibm.com>
Date: Mon, 20 Aug 2007 15:27:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull Kumar's fixes-2.6.23 branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do a pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git fixes-2.6.23

to get four commits from Kumar that fix some bugs in the platform
support for Freescale PowerPC platforms.

One of the commits looks rather large, but that is because rather than
fix the same bugs in two places, Kumar moved a chunk of almost
identical code for two platforms into a single file that is used for
both platforms, and fixed the bugs in one place.  Also, the affected
files are only used on some Freescale embedded platforms, so the
number of users that could be affected by this is small.

Thanks,
Paul.

 arch/powerpc/boot/dts/mpc8544ds.dts        |   88 ++++------
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  114 +++----------
 arch/powerpc/kernel/traps.c                |    4 
 arch/powerpc/platforms/85xx/Kconfig        |    1 
 arch/powerpc/platforms/85xx/mpc8544_ds.c   |  214 ++---------------------
 arch/powerpc/platforms/86xx/Kconfig        |    1 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  224 ++-----------------------
 arch/powerpc/platforms/Kconfig             |    8 +
 arch/powerpc/platforms/Makefile            |    3 
 arch/powerpc/platforms/fsl_uli1575.c       |  255 ++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.c              |    1 
 arch/powerpc/sysdev/rtc_cmos_setup.c       |   17 +-
 include/asm-powerpc/reg_booke.h            |   12 +
 13 files changed, 389 insertions(+), 553 deletions(-)
 create mode 100644 arch/powerpc/platforms/fsl_uli1575.c

commit 0af666fa6cf4bc639fb6170600b5fb0d8b6504b9
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Fri Aug 17 08:23:06 2007 -0500

    [POWERPC] Fix 8xx compile failure
    
      CC      arch/powerpc/sysdev/commproc.o
    arch/powerpc/sysdev/fsl_soc.c: In function fsl_pcmcia_of_init:
    arch/powerpc/sysdev/fsl_soc.c:1109: error: implicit declaration of function of_platform_device_create
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 86d7a9a9c4775f864e6bc5f5da66ef9ea3715734
Author: Becky Bruce <becky.bruce@freescale.com>
Date:   Thu Aug 2 15:37:15 2007 -0500

    [POWERPC] Fix FSL BookE machine check reporting
    
    Reserved MCSR bits on FSL BookE parts may have spurious values
    when mcheck occurs.  Mask these off when printing the MCSR to
    avoid confusion.  Also, get rid of the MCSR_GL_CI bit defined
    for e500 - this bit doesn't actually have any meaning.
    
    Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit b66510cb9992d204f216049e9c01d432c7635f6c
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Thu Aug 16 23:55:55 2007 -0500

    [POWERPC] Fix interrupt routing and setup of ULI M1575 on FSL boards
    
    The interrupt routing in the device trees for the ULI M1575 was
    inproperly using the interrupt line field as pci function.  Fixed
    up the device tree's to actual conform for to specification and
    changed the interrupt mapping code so it just uses a static mapping
    setup as follows:
    
    PIRQA - IRQ9
    PIRQB - IRQ10
    PIRQC - IRQ11
    PIRQD - IRQ12
    USB 1.1 OCHI (1c.0) - IRQ12
    USB 1.1 OCHI (1c.1) - IRQ9
    USB 1.1 OCHI (1c.2) - IRQ10
    USB 1.1 ECHI (1c.3) - IRQ11
    LAN (1b.0) - IRQ6
    AC97 (1d.0) - IRQ6
    Modem (1d.1) - IRQ6
    HD Audio (1d.2) - IRQ6
    SATA (1f.1) - IRQ5
    SMB (1e.1) - IRQ7
    PMU (1e.2) - IRQ7
    PATA (1f.0) - IRQ14/15
    
    Took the oppurtunity to refactor the code into a single file so we
    don't have to duplicate these fixes on the two current boards in the
    tree and several forth coming boards that will also need the code.
    
    Fixed RTC support that requires a dummy memory read on the P2P bridge
    to unlock the RTC and setup the default of the RTC alarm registers to
    match with a basic x86 style CMOS RTC.
    
    Moved code that poked ISA registers to a FIXUP_FINAL quirk to ensure
    the PCI IO space has been setup properly before we start poking ISA
    registers at random locations.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit ada3ea6fcde45abc55e2af0e564455fd7f943a79
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Thu Aug 16 23:44:00 2007 -0500

    [POWERPC] Add interrupt resource for RTC CMOS driver
    
    The RTC CMOS driver expects the interrupt to be a resource of the platform
    device.  Use a fixed interrupt value of 8 since on PPC if we are using this
    its off an i8259 which we ensure has interrupt numbers 0..15.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
