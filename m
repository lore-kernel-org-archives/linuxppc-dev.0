Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F5CFB70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:02 +1100 (EST)
Date: Tue, 8 Mar 2011 00:58:56 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH,v2 00/28] powerpc: irq_data conversion.
Message-ID: <20110307235856.GE16649@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch converts powerpc over to the new irq_data based irq_chip
functions, as was done earlier for ARM and most other architectures.

struct irq_data is described here:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ff7dcd44dd446db2c3e13bdedf2d52b8e0127f16

The new irq_chip functions are described here:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8822657e799b02c55556c99a601261e207a299d


This patch set is also available from:

	git://git.kernel.org/pub/scm/linux/kernel/git/buytenh/powerpc_irq_data.git
	http://git.kernel.org/?p=linux/kernel/git/buytenh/powerpc_irq_data.git


v2: fixes build failures (build-tested on all powerpc (32/64b)
defconfigs), and has been split into a patch series.  It has still
had only limited run-time testing.


Lennert Buytenhek (28):
  powerpc: mpic irq_data conversion.
  powerpc: platforms/512x irq_data conversion.
  powerpc: platforms/52xx irq_data conversion.
  powerpc: platforms/82xx irq_data conversion.
  powerpc: platforms/85xx irq_data conversion.
  powerpc: platforms/86xx irq_data conversion.
  powerpc: platforms/8xx irq_data conversion.
  powerpc: platforms/cell irq_data conversion.
  powerpc: platforms/chrp irq_data conversion.
  powerpc: platforms/embedded6xx irq_data conversion.
  powerpc: platforms/iseries irq_data conversion.
  powerpc: platforms/powermac irq_data conversion.
  powerpc: platforms/ps3 irq_data conversion.
  powerpc: platforms/pseries irq_data conversion.
  powerpc: sysdev/cpm1 irq_data conversion.
  powerpc: sysdev/cpm2_pic irq_data conversion.
  powerpc: sysdev/fsl_msi irq_data conversion.
  powerpc: sysdev/i8259 irq_data conversion.
  powerpc: sysdev/ipic irq_data conversion.
  powerpc: sysdev/mpc8xx_pic irq_data conversion.
  powerpc: sysdev/mpc8xxx_gpio irq_data conversion.
  powerpc: sysdev/mv64x60_pic irq_data conversion.
  powerpc: sysdev/qe_lib/qe_ic irq_data conversion.
  powerpc: sysdev/tsi108_pci irq_data conversion.
  powerpc: sysdev/uic irq_data conversion.
  powerpc: sysdev/xilinx_intc irq_data conversion.
  powerpc: core irq_data conversion.
  powerpc: Enable GENERIC_HARDIRQS_NO_DEPRECATED.

 arch/powerpc/Kconfig                             |    1 +
 arch/powerpc/include/asm/mpic.h                  |    6 +-
 arch/powerpc/include/asm/qe_ic.h                 |   19 ++--
 arch/powerpc/kernel/irq.c                        |   23 +++-
 arch/powerpc/kernel/machine_kexec.c              |   21 ++--
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |   14 +-
 arch/powerpc/platforms/52xx/media5200.c          |   21 ++--
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c        |   26 ++--
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        |   80 +++++++-------
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |   27 ++---
 arch/powerpc/platforms/85xx/ksi8560.c            |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c        |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c         |    3 +-
 arch/powerpc/platforms/85xx/sbc8560.c            |    3 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c  |   40 ++++----
 arch/powerpc/platforms/85xx/stx_gp3.c            |    3 +-
 arch/powerpc/platforms/85xx/tqm85xx.c            |    3 +-
 arch/powerpc/platforms/86xx/gef_pic.c            |   22 ++--
 arch/powerpc/platforms/86xx/pic.c                |    5 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c          |    9 +-
 arch/powerpc/platforms/cell/axon_msi.c           |    3 +-
 arch/powerpc/platforms/cell/beat_interrupt.c     |   36 +++---
 arch/powerpc/platforms/cell/interrupt.c          |   30 +++--
 arch/powerpc/platforms/cell/setup.c              |    6 +-
 arch/powerpc/platforms/cell/spider-pic.c         |   43 ++++----
 arch/powerpc/platforms/chrp/setup.c              |    5 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |   32 +++---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |   41 ++++----
 arch/powerpc/platforms/iseries/irq.c             |   43 ++++---
 arch/powerpc/platforms/pasemi/setup.c            |    4 +-
 arch/powerpc/platforms/powermac/pic.c            |   48 ++++----
 arch/powerpc/platforms/ps3/interrupt.c           |   40 ++++----
 arch/powerpc/platforms/pseries/setup.c           |    5 +-
 arch/powerpc/platforms/pseries/xics.c            |   89 ++++++++-------
 arch/powerpc/sysdev/cpm1.c                       |   18 ++--
 arch/powerpc/sysdev/cpm2_pic.c                   |   32 +++---
 arch/powerpc/sysdev/fsl_msi.c                    |   19 ++--
 arch/powerpc/sysdev/i8259.c                      |   42 ++++----
 arch/powerpc/sysdev/ipic.c                       |   54 +++++-----
 arch/powerpc/sysdev/mpc8xx_pic.c                 |   32 +++---
 arch/powerpc/sysdev/mpc8xxx_gpio.c               |   42 ++++----
 arch/powerpc/sysdev/mpic.c                       |  131 +++++++++++-----------
 arch/powerpc/sysdev/mpic.h                       |    5 +-
 arch/powerpc/sysdev/mpic_pasemi_msi.c            |   18 ++--
 arch/powerpc/sysdev/mpic_u3msi.c                 |   18 ++--
 arch/powerpc/sysdev/mv64x60_pic.c                |   46 ++++----
 arch/powerpc/sysdev/qe_lib/qe_ic.c               |   20 ++--
 arch/powerpc/sysdev/tsi108_pci.c                 |   41 +++----
 arch/powerpc/sysdev/uic.c                        |   59 +++++-----
 arch/powerpc/sysdev/xilinx_intc.c                |   48 ++++----
 50 files changed, 722 insertions(+), 660 deletions(-)

-- 
1.7.4
