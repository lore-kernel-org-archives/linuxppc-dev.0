Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17880.55566.982060.486544@cargo.ozlabs.ibm.com>
Date: Mon, 19 Feb 2007 09:54:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org,
    linuxppc-dev@ozlabs.org
Subject: Re: Please pull powerpc.git master branch
In-Reply-To: <17878.61905.316569.773889@cargo.ozlabs.ibm.com>
References: <17878.61905.316569.773889@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

I wrote:

> Please do:
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> 
> The commits there are mostly minor bug fixes and cleanups.

I just pulled a set of embedded powerpc updates from Kumar Gala and
pushed them to my tree, so when you do the pull you'll also see the
commits below (assuming the mirroring has caught up :).

Thanks,
Paul.

 arch/powerpc/boot/dts/mpc8313erdb.dts      |   62 ++++-----
 arch/powerpc/boot/dts/mpc832x_mds.dts      |  119 ++++++++---------
 arch/powerpc/boot/dts/mpc8349emitx.dts     |   60 ++++-----
 arch/powerpc/boot/dts/mpc8349emitxgp.dts   |   39 +++---
 arch/powerpc/boot/dts/mpc834x_mds.dts      |  164 ++++++++++++------------
 arch/powerpc/boot/dts/mpc836x_mds.dts      |  123 ++++++++----------
 arch/powerpc/boot/dts/mpc8540ads.dts       |  142 ++++++++++-----------
 arch/powerpc/boot/dts/mpc8541cds.dts       |  108 +++++++---------
 arch/powerpc/boot/dts/mpc8548cds.dts       |  129 ++++++++-----------
 arch/powerpc/boot/dts/mpc8555cds.dts       |  108 +++++++---------
 arch/powerpc/boot/dts/mpc8560ads.dts       |  157 ++++++++++-------------
 arch/powerpc/boot/dts/mpc8568mds.dts       |   96 ++++++--------
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  193 ++++++++++++----------------
 arch/powerpc/configs/mpc832x_mds_defconfig |    0 
 arch/powerpc/configs/mpc836x_mds_defconfig |   29 +++-
 arch/powerpc/configs/mpc8568mds_defconfig  |   32 ++++-
 arch/powerpc/platforms/83xx/Kconfig        |    8 +
 arch/powerpc/platforms/83xx/Makefile       |    2 
 arch/powerpc/platforms/83xx/mpc8313_rdb.c  |   11 --
 arch/powerpc/platforms/83xx/mpc832x_mds.c  |   65 ++-------
 arch/powerpc/platforms/83xx/mpc834x_itx.c  |   23 ---
 arch/powerpc/platforms/83xx/mpc834x_mds.c  |   27 +---
 arch/powerpc/platforms/83xx/mpc836x_mds.c  |   97 +++++---------
 arch/powerpc/platforms/85xx/Kconfig        |    8 +
 arch/powerpc/platforms/85xx/Makefile       |    2 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |   14 --
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   15 --
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   46 ++-----
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    9 -
 arch/powerpc/sysdev/qe_lib/ucc_fast.c      |  163 +++++++++---------------
 arch/powerpc/sysdev/qe_lib/ucc_slow.c      |  137 ++++++++------------
 include/asm-powerpc/ucc_slow.h             |    8 +
 32 files changed, 944 insertions(+), 1252 deletions(-)
 rename arch/powerpc/boot/dts/{mpc8323emds.dts => mpc832x_mds.dts} (78%)
 rename arch/powerpc/boot/dts/{mpc8360emds.dts => mpc836x_mds.dts} (79%)
 rename arch/powerpc/configs/{mpc832xemds_defconfig => mpc832x_mds_defconfig} (100%)
 rename arch/powerpc/configs/{mpc8360emds_defconfig => mpc836x_mds_defconfig} (97%)
 rename arch/powerpc/platforms/83xx/{mpc8360e_pb.c => mpc836x_mds.c} (67%)
 rename arch/powerpc/platforms/85xx/{mpc8568_mds.c => mpc85xx_mds.c} (85%)

Jon Loeliger (2):
      [POWERPC] 8[56]xx: Remove obsolete setting of ROOT_DEV for 85xx and 86xx platforms.
      [POWERPC] 86xx: Add missing of_node_put() in mpc86xx_hpcn_init_irq().

Kumar Gala (11):
      [POWERPC] 83xx: Cleaned up 83xx platform dts files
      [POWERPC] 83xx: Cleaning up machine probing and board initcalls
      [POWERPC] 83xx: Remove obsolete setting of ROOT_DEV.
      [POWERPC] 83xx: use default value of loops_per_jiffy
      [POWERPC] 83xx: Use of_platform_bus_probe to setup QE devices
      [POWERPC] 83xx: Updated and renamed MPC8360PB to MPC836x MDS
      [POWERPC] 83xx: Renamed MPC8323 MDS dts and defconfig to match other boards
      [POWERPC] 85xx: Cleaned up platform dts files
      [POWERPC] 85xx: Cleaning up machine probing
      [POWERPC] 85xx: Renamed MPC8568 MDS board code to match other boards
      [POWERPC] 86xx: Cleaned up platform dts files

Timur Tabi (1):
      [POWERPC] QE: clean up ucc_slow.c and ucc_fast.c
