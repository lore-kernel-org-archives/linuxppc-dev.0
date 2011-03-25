Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B217510092F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:19 +1100 (EST)
Message-Id: <20110325164049.138289403@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:12 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 00/14] powerpc: Final irq bits for .39
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

the following series cleans up the remaining odds and ends of the
powerpc irq code. It further contains a coccinelle scripted conversion of
the irq functions to the new naming convention irq_*.

The last patch which makes power switch to the generic
show_interrupts() code selects GENERIC_IRQ_SHOW_LEVEL which has not
yet hit Linus tree, but should tonight.

Thanks,

	tglx

 Kconfig                              |    2 
 kernel/irq.c                         |   84 +++++------------------------------
 kernel/machine_kexec.c               |    2 
 kernel/pci-common.c                  |    2 
 platforms/512x/mpc5121_ads_cpld.c    |    6 +-
 platforms/52xx/media5200.c           |   17 ++-----
 platforms/52xx/mpc52xx_gpt.c         |   10 ++--
 platforms/52xx/mpc52xx_pic.c         |    6 +-
 platforms/82xx/pq2ads-pci-pic.c      |   16 +++---
 platforms/85xx/ksi8560.c             |    4 -
 platforms/85xx/mpc85xx_ads.c         |    4 -
 platforms/85xx/mpc85xx_cds.c         |    2 
 platforms/85xx/mpc85xx_ds.c          |    4 -
 platforms/85xx/sbc8560.c             |    4 -
 platforms/85xx/socrates_fpga_pic.c   |   12 ++---
 platforms/85xx/stx_gp3.c             |    4 -
 platforms/85xx/tqm85xx.c             |    4 -
 platforms/86xx/gef_pic.c             |    8 +--
 platforms/86xx/pic.c                 |    4 -
 platforms/8xx/m8xx_setup.c           |    6 +-
 platforms/cell/axon_msi.c            |   14 ++---
 platforms/cell/beat_interrupt.c      |    5 --
 platforms/cell/interrupt.c           |   16 +++---
 platforms/cell/setup.c               |    8 +--
 platforms/cell/spider-pic.c          |   21 ++------
 platforms/chrp/setup.c               |    4 -
 platforms/embedded6xx/flipper-pic.c  |   10 ++--
 platforms/embedded6xx/hlwd-pic.c     |   18 +++----
 platforms/embedded6xx/holly.c        |    4 -
 platforms/embedded6xx/mpc7448_hpc2.c |    4 -
 platforms/iseries/irq.c              |    4 -
 platforms/maple/pci.c                |    2 
 platforms/pasemi/setup.c             |    2 
 platforms/powermac/pci.c             |    2 
 platforms/powermac/pic.c             |   17 +++----
 platforms/ps3/interrupt.c            |   14 ++---
 platforms/pseries/msi.c              |    4 -
 platforms/pseries/setup.c            |    4 -
 platforms/pseries/xics.c             |    8 +--
 sysdev/cpm1.c                        |    4 -
 sysdev/cpm2_pic.c                    |   51 +++++++++------------
 sysdev/fsl_msi.c                     |   24 +++++-----
 sysdev/i8259.c                       |    8 +--
 sysdev/ipic.c                        |   22 ++++-----
 sysdev/mpc8xx_pic.c                  |   11 ----
 sysdev/mpc8xxx_gpio.c                |   12 ++---
 sysdev/mpic.c                        |   43 +++++++----------
 sysdev/mpic_pasemi_msi.c             |    8 +--
 sysdev/mpic_u3msi.c                  |    8 +--
 sysdev/mv64x60_pic.c                 |    5 +-
 sysdev/qe_lib/qe_ic.c                |   16 +++---
 sysdev/tsi108_pci.c                  |    6 +-
 sysdev/uic.c                         |   39 ++++++----------
 sysdev/xilinx_intc.c                 |   20 ++------
 54 files changed, 268 insertions(+), 371 deletions(-)
