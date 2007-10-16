Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id E9CFEDDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 09:22:58 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2736174wag
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:22:57 -0700 (PDT)
Message-ID: <fa686aa40710161622v50484122s6ddbf6c4dc4b1e3f@mail.gmail.com>
Date: Tue, 16 Oct 2007 17:22:56 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull linux-2.6-mpc52xx.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Here is the addition of the bestcomm driver.  I think this is ready to go in.

There are remaining outstanding comments; but my opinion is that they
should be addressed in subsequent patches (performance optimization
for mp5200b boards and making the sram management code a generic
interface usable by other SoC support code).

If you agree; please pull into your tree.

The following changes since commit 65a6ec0d72a07f16719e9b7a96e1c4bae044b591:
  Linus Torvalds (1):
        Merge branch 'devel' of master.kernel.org:/home/rmk/linux-2.6-arm

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.24

Domen Puncer (1):
      [POWERPC] mpc52xx: device tree changes for FEC and MDIO

Sylvain Munaut (7):
      [POWERPC] exports rheap symbol to modules
      [POWERPC] rheap: Changes config mechanism
      [POWERPC] mpc52xx: Update mpc52xx_psc structure with B revision changes
      [POWERPC] bestcomm: core bestcomm support for Freescale MPC5200
      [POWERPC] bestcomm: ATA task support
      [POWERPC] bestcomm: FEC task support
      [POWERPC] bestcomm: GenBD task support

 arch/powerpc/Kconfig                               |    4 +
 arch/powerpc/boot/dts/lite5200b.dts                |   18 +-
 arch/powerpc/lib/Makefile                          |    5 +-
 arch/powerpc/lib/rheap.c                           |   15 +
 arch/powerpc/platforms/Kconfig                     |    4 +
 arch/powerpc/platforms/Kconfig.cputype             |    1 +
 arch/powerpc/sysdev/Makefile                       |    1 +
 arch/powerpc/sysdev/bestcomm/Kconfig               |   39 ++
 arch/powerpc/sysdev/bestcomm/Makefile              |   14 +
 arch/powerpc/sysdev/bestcomm/ata.c                 |  154 ++++++
 arch/powerpc/sysdev/bestcomm/ata.h                 |   37 ++
 arch/powerpc/sysdev/bestcomm/bcom_ata_task.c       |   67 +++
 arch/powerpc/sysdev/bestcomm/bcom_fec_rx_task.c    |   78 +++
 arch/powerpc/sysdev/bestcomm/bcom_fec_tx_task.c    |   91 ++++
 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c |   63 +++
 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c |   69 +++
 arch/powerpc/sysdev/bestcomm/bestcomm.c            |  528 ++++++++++++++++++++
 arch/powerpc/sysdev/bestcomm/bestcomm.h            |  190 +++++++
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h       |  334 +++++++++++++
 arch/powerpc/sysdev/bestcomm/fec.c                 |  270 ++++++++++
 arch/powerpc/sysdev/bestcomm/fec.h                 |   61 +++
 arch/powerpc/sysdev/bestcomm/gen_bd.c              |  260 ++++++++++
 arch/powerpc/sysdev/bestcomm/gen_bd.h              |   48 ++
 arch/powerpc/sysdev/bestcomm/sram.c                |  177 +++++++
 arch/powerpc/sysdev/bestcomm/sram.h                |   54 ++
 arch/ppc/Kconfig                                   |    6 +
 include/asm-ppc/mpc52xx_psc.h                      |   10 +-
 27 files changed, 2591 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/sysdev/bestcomm/Kconfig
 create mode 100644 arch/powerpc/sysdev/bestcomm/Makefile
 create mode 100644 arch/powerpc/sysdev/bestcomm/ata.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/ata.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_ata_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_fec_rx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_fec_tx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/fec.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/fec.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/gen_bd.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/gen_bd.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/sram.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/sram.h


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
