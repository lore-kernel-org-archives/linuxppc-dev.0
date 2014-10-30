Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB3111A04F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 00:37:02 +1100 (AEDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 1/3] QE: move qe code from arch/powerpc to drivers/soc
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1414654264-2596-1-git-send-email-B45475@freescale.com>
Date: Thu, 30 Oct 2014 08:36:52 -0500
Message-Id: <845EBC7E-52A3-48D6-826D-886FC18B0B88@kernel.crashing.org>
References: <1414654264-2596-1-git-send-email-B45475@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 30, 2014, at 2:31 AM, Zhao Qiang <B45475@freescale.com> wrote:

> LS1 is arm cpu and it has qe ip block.
> move qe code from platform directory to public directory.
>=20
> QE is an IP block integrates several comunications peripheral
> controllers. It can implement a variety of applications, such
> as uart, usb and tdm and so on.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- move code to driver/soc
> Changes for v3:
> 	- change drivers/soc/qe to drivers/soc/fsl-qe
>=20
> arch/powerpc/Kconfig                               |  2 -
> arch/powerpc/platforms/83xx/km83xx.c               |  4 +-
> arch/powerpc/platforms/83xx/misc.c                 |  2 +-
> arch/powerpc/platforms/83xx/mpc832x_mds.c          |  4 +-
> arch/powerpc/platforms/83xx/mpc832x_rdb.c          |  4 +-
> arch/powerpc/platforms/83xx/mpc836x_mds.c          |  4 +-
> arch/powerpc/platforms/83xx/mpc836x_rdk.c          |  4 +-
> arch/powerpc/platforms/85xx/common.c               |  2 +-
> arch/powerpc/platforms/85xx/corenet_generic.c      |  2 +-
> arch/powerpc/platforms/85xx/mpc85xx_mds.c          |  4 +-
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  4 +-
> arch/powerpc/platforms/85xx/twr_p102x.c            |  4 +-
> arch/powerpc/platforms/Kconfig                     | 19 ---------
> arch/powerpc/sysdev/Makefile                       |  1 -
> arch/powerpc/sysdev/qe_lib/Kconfig                 | 27 -------------
> drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  2 +-
> drivers/net/ethernet/freescale/ucc_geth.c          |  8 ++--
> drivers/net/ethernet/freescale/ucc_geth.h          |  8 ++--
> drivers/soc/Kconfig                                |  2 +
> drivers/soc/Makefile                               |  1 +
> drivers/soc/fsl-qe/Kconfig                         | 45 =
++++++++++++++++++++++
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/Makefile  |  0
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/gpio.c    |  2 +-
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe.c      |  4 +-
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe_ic.c   |  2 +-
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe_ic.h   |  2 +-
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe_io.c   |  2 +-
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/ucc.c     |  6 +--
> .../qe_lib =3D> drivers/soc/fsl-qe}/ucc_fast.c       |  8 ++--
> .../qe_lib =3D> drivers/soc/fsl-qe}/ucc_slow.c       |  8 ++--
> .../sysdev/qe_lib =3D> drivers/soc/fsl-qe}/usb.c     |  4 +-
> drivers/spi/spi-fsl-cpm.c                          |  2 +-
> drivers/tty/serial/ucc_uart.c                      |  2 +-
> drivers/usb/gadget/fsl_qe_udc.c                    |  2 +-
> drivers/usb/host/fhci-hcd.c                        |  2 +-
> drivers/usb/host/fhci-hub.c                        |  2 +-
> drivers/usb/host/fhci-sched.c                      |  2 +-
> drivers/usb/host/fhci.h                            |  4 +-
> .../include/asm =3D> include/linux/fsl}/immap_qe.h   |  0
> .../powerpc/include/asm =3D> include/linux/fsl}/qe.h |  2 +-
> .../include/asm =3D> include/linux/fsl}/qe_ic.h      |  0
> .../include/asm =3D> include/linux/fsl}/ucc.h        |  4 +-
> .../include/asm =3D> include/linux/fsl}/ucc_fast.h   |  6 +--
> .../include/asm =3D> include/linux/fsl}/ucc_slow.h   |  6 +--
> 44 files changed, 112 insertions(+), 113 deletions(-)
> delete mode 100644 arch/powerpc/sysdev/qe_lib/Kconfig
> create mode 100644 drivers/soc/fsl-qe/Kconfig
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/Makefile =
(100%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/gpio.c =
(99%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe.c (99%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe_ic.c =
(99%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe_ic.h =
(98%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/qe_io.c =
(99%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/ucc.c =
(98%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/ucc_fast.c =
(98%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/ucc_slow.c =
(98%)
> rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl-qe}/usb.c =
(96%)
> rename {arch/powerpc/include/asm =3D> include/linux/fsl}/immap_qe.h =
(100%)
> rename {arch/powerpc/include/asm =3D> include/linux/fsl}/qe.h (99%)
> rename {arch/powerpc/include/asm =3D> include/linux/fsl}/qe_ic.h =
(100%)
> rename {arch/powerpc/include/asm =3D> include/linux/fsl}/ucc.h (96%)
> rename {arch/powerpc/include/asm =3D> include/linux/fsl}/ucc_fast.h =
(98%)
> rename {arch/powerpc/include/asm =3D> include/linux/fsl}/ucc_slow.h =
(99%)


So you should be moving things to drivers/soc/fsl/qe/ not =
drivers/soc/fsl-qe/

The headers should be in include/soc/fsl, not include/linux/fsl

In addition before this move is accepted, other changes need to be made =
to convert to using standard frameworks for various functionality in QE =
lib.

1. gpio.c -> needs to be converted to GPIO framework and placed in =
drivers/gpio
2. qe_ic* should probably move into drivers/irqchip
3. qe_io.c should be converted over to pinmux and put in drivers/pinctrl
4. Some of the clock could should be looked to be converted to use the =
clk framework

These changes need to be addressed before any of the qe_lib code can get =
moved into drivers/soc

- k
