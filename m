Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB3B52C0206
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 17:36:54 +1000 (EST)
Date: Wed, 7 Aug 2013 09:36:45 +0200
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Detlev Zundel <dzu@denx.de>
Subject: Re: [PATCH v4 00/31] add COMMON_CLK support for PowerPC MPC512x
Message-ID: <20130807073645.GT2580@book.gsilab.sittig.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <20130806213148.GS2580@book.gsilab.sittig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806213148.GS2580@book.gsilab.sittig.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ no change in content, but order shuffling for better application ]

On Tue, Aug 06, 2013 at 23:31 +0200, Gerhard Sittig wrote:
> 
> [ this is an overview on how to split the series if necessary ]
> 
> On Tue, Aug 06, 2013 at 22:43 +0200, Gerhard Sittig wrote:
> > 
> > this series
> > - fixes several drivers that are used in the MPC512x platform (UART,
> >   SPI, ethernet, PCI, USB, CAN, NAND flash, video capture) in how they
> >   handle clocks (appropriately acquire and setup them, hold references
> >   during use, release clocks after use)
> > - introduces support for the common clock framework (CCF, COMMON_CLK
> >   Kconfig option) in the PowerPC based MPC512x platform, which brings
> >   device tree based clock lookup as well
> > 
> > although the series does touch several subsystems -- tty (serial), spi,
> > net (can, fs_enet), mtd (nfc), usb, i2c, media (viu), and dts -- all of
> > the patches are strictly clock related or trivial
> > 
> > it appears most appropriate to take this series through either the clk
> > or the powerpc trees after it has passed review and other subsystem
> > maintainers ACKed the clock setup related driver modifications
> 
> It was suggested that the series may not be kept together when
> applying, i.e. that individual patches may need to take separate
> routes through individual subsystem trees.
> 
> Here is how the parts of the series interact:
> - parts 01-14 are apparent fixes and improvements to existing
>   drivers, they may immediately get applied via their respective
>   subsystems when they are considered acceptable in review
>   (number 13 already was taken into clk-next)
> - parts 15-16 are device tree improvements (providing previously
>   lacking information on the hardware, plus introducing support
>   for symbolic references in DT nodes), and can get applied
>   immediately via their respective subsystem
> - part 17 introduces the platform clock driver which provides
>   common clock support (uses shared drivers and common
>   infrastructure, is an OF clock provider) -- this patch
>   introduces _and_ enables the driver which strictly depends on
>   the device tree update from part 16, and when common clock
>   support gets enabled all peripheral drivers shall have received
>   their clock API use cleanup
> - part 18 introduces clock specs in the device tree which is used
>   for client side lookups (from within peripheral drivers), this
>   part must not get applied before the OF clock provider from
>   part 17
> - parts 19-21 and 23-28 further adjust peripheral drivers _after_
>   the common clock support and OF clock lookup have become
>   available, they strictly depend on parts 17 and 18, finally
>   bring peripheral drivers into the common clock world and remove
>   workarounds in the backend which support migration
> - parts 22 and 29-31 finally remove remaining compat and
>   migration stuff that has become obsolete after everything else
>   was adjusted (I'd happily re-spin the series to move 22 to the
>   end if eliminating this seemingly out-of-order item helps,
>   currently it's at that position since it finishes what patch 20
>   and 21 have prepared, while I did not dare to squash SPI and
>   UART related patches since they reside in different subsystems)
> 
> The above results in the following stages, when the series needs
> to get split:
> - parts 01-16 could be taken immediately and need not be kept in
>   any order, as they don't depend on each other
> - parts 17-18 could be taken after 01-16 all are in place (while
>   18 requires 17)
> - parts 19-28 (see the remark on 22) could be taken after 17 and
>   18 are in place (22 depends on 20 and 21 but may get moved to
>   any later position at will, all other parts don't depend on
>   each other and can get applied in any order)
> - parts 29-31 (and 22 if not applied so far) could be taken after
>   all parts up to 28 were applied

Here I erred.  The order of the patches within phase 3 appears to
actually matter.  I'm sorry for bothering you again.

While the _content_ of the patches (which manipulation gets done
to the source) is correct and independent from neighbour patches,
yet a patch in that third phase will change the _context_ of
subsequent patches.  The sum of all the patches applied will be
identical again, but changed order of application may cause
conflicts (regardless of how simple to resolve they may be).

Build and run tests and the organization of v4 (immediate removal
upon driver adjustment) have shown that removing a migration
workaround in the very moment where driver adjustment obsoletes
it keeps the system operational.  I consider this a very positive
feature, and would only rearrange the order if the series'
content was ACKed in complete.

Moving removal of the workarounds to a later point in time won't
affect operation (just leaves the workaround in place a little
longer, while it does not harm), and will eliminate potential for
conflicts.  This I would do when accepting the series was
decided, to not lose the precious test feature during
development.

A byproduct of this rearrangement is that patches in phase 3
won't any longer touch a peripheral driver _and_ the clock driver
within a single patch, for whatever that may be worth.


So I suggest the following:

I can move parts 19 and 22 (completely) and the "workaround
removal" aspect of parts 20-21 and 23-28 to a later point in the
sequence, maybe squash them with part 31 (cleanup after migration
has completed).

This allows for even better (conflict free) application of the
series through individual and most appropriate trees.  All of
this of course assumes that the series passes review, and that
you agree on the outlined application in four phases if the
series cannot be kept together:
- clock API use cleanup for peripheral drivers, and device tree
  update to provide previously missing hardware information
- introduction of the platform clock driver and OF clock lookup
- adjustment of peripheral drivers after common clock support has
  become available
- removal of migration support and compat workarounds after
  migration has completed


> Please consider that I'm not trying to be pushy :)  but that I
> want to provide all the possible help and information on how the
> series might get applied, assuming that it will pass review.  So
> far there has not been objection, all feedback got addressed,
> while explicit ACKs still are pending.
> 
> For your reference here is the stats and the (numbered) list of
> files again:
> 
> 0000-cover-letter.patch
> 0001-spi-mpc512x-cleanup-clock-API-use.patch
> 0002-serial-mpc512x-cleanup-clock-API-use.patch
> 0003-USB-fsl-mph-dr-of-cleanup-clock-API-use.patch
> 0004-mtd-mpc5121_nfc-cleanup-clock-API-use.patch
> 0005-media-fsl-viu-cleanup-clock-API-use.patch
> 0006-i2c-mpc-cleanup-clock-API-use.patch
> 0007-fs_enet-silence-a-build-warning-unused-variable.patch
> 0008-fs_enet-cleanup-clock-API-use.patch
> 0009-powerpc-fsl-pci-improve-clock-API-use.patch
> 0010-net-can-mscan-add-a-comment-on-reg-to-idx-mapping.patch
> 0011-net-can-mscan-improve-clock-API-use.patch
> 0012-powerpc-mpc512x-array-decl-for-MCLK-registers-in-CCM.patch
> 0013-clk-wrap-I-O-access-for-improved-portability.patch
> 0014-dts-mpc512x-prepare-for-preprocessor-support.patch
> 0015-dts-mpc512x-introduce-dt-bindings-clock-header.patch
> 0016-dts-mpc512x-add-clock-related-device-tree-specs.patch
> 0017-clk-mpc512x-introduce-COMMON_CLK-for-MPC512x.patch
> 0018-dts-mpc512x-add-clock-specs-for-client-lookups.patch
> 0019-clk-mpc512x-don-t-pre-enable-FEC-and-I2C-clocks.patch
> 0020-spi-mpc512x-switch-to-CCF-names-in-clock-lookup.patch
> 0021-serial-mpc512x-switch-to-CCF-names-in-clock-lookup.patch
> 0022-clk-mpc512x-remove-PSC-UART-SPI-compat-workarounds.patch
> 0023-serial-mpc512x-setup-the-PSC-FIFO-clock-as-well.patch
> 0024-USB-fsl-mph-dr-of-remove-now-obsolete-clock-lookup-n.patch
> 0025-mtd-mpc5121_nfc-remove-now-obsolete-clock-lookup-nam.patch
> 0026-media-fsl-viu-remove-now-obsolete-clock-lookup-name.patch
> 0027-net-can-mscan-add-common-clock-support-for-mpc512x.patch
> 0028-powerpc-mpc512x-improve-DIU-related-clock-setup.patch
> 0029-clk-mpc512x-switch-to-COMMON_CLK-remove-PPC_CLOCK.patch
> 0030-net-can-mscan-remove-non-CCF-code-for-MPC512x.patch
> 0031-clk-mpc512x-remove-remaining-migration-workarounds.patch
> 
> > Gerhard Sittig (31):
> >   spi: mpc512x: cleanup clock API use
> >   serial: mpc512x: cleanup clock API use
> >   USB: fsl-mph-dr-of: cleanup clock API use
> >   mtd: mpc5121_nfc: cleanup clock API use
> >   [media] fsl-viu: cleanup clock API use
> >   i2c: mpc: cleanup clock API use
> >   fs_enet: silence a build warning (unused variable)
> >   fs_enet: cleanup clock API use
> >   powerpc/fsl-pci: improve clock API use
> >   net: can: mscan: add a comment on reg to idx mapping
> >   net: can: mscan: improve clock API use
> >   powerpc: mpc512x: array decl for MCLK registers in CCM
> >   clk: wrap I/O access for improved portability
> >   dts: mpc512x: prepare for preprocessor support
> >   dts: mpc512x: introduce dt-bindings/clock/ header
> >   dts: mpc512x: add clock related device tree specs
> >   clk: mpc512x: introduce COMMON_CLK for MPC512x
> >   dts: mpc512x: add clock specs for client lookups
> >   clk: mpc512x: don't pre-enable FEC and I2C clocks
> >   spi: mpc512x: switch to CCF names in clock lookup
> >   serial: mpc512x: switch to CCF names in clock lookup
> >   clk: mpc512x: remove PSC (UART, SPI) compat workarounds
> >   serial: mpc512x: setup the PSC FIFO clock as well
> >   USB: fsl-mph-dr-of: remove now obsolete clock lookup name
> >   mtd: mpc5121_nfc: remove now obsolete clock lookup name
> >   [media] fsl-viu: remove now obsolete clock lookup name
> >   net: can: mscan: add common clock support for mpc512x
> >   powerpc/mpc512x: improve DIU related clock setup
> >   clk: mpc512x: switch to COMMON_CLK, remove PPC_CLOCK
> >   net: can: mscan: remove non-CCF code for MPC512x
> >   clk: mpc512x: remove remaining migration workarounds
> > 
> >  arch/powerpc/boot/dts/ac14xx.dts                   |    9 +-
> >  arch/powerpc/boot/dts/include/dt-bindings          |    1 +
> >  arch/powerpc/boot/dts/mpc5121.dtsi                 |  110 ++-
> >  arch/powerpc/boot/dts/mpc5121ads.dts               |    2 +-
> >  arch/powerpc/boot/dts/pdm360ng.dts                 |    2 +-
> >  arch/powerpc/include/asm/mpc5121.h                 |   18 +-
> >  arch/powerpc/platforms/512x/Kconfig                |    2 +-
> >  arch/powerpc/platforms/512x/Makefile               |    3 +-
> >  arch/powerpc/platforms/512x/clock-commonclk.c      |  716 +++++++++++++++++++
> >  arch/powerpc/platforms/512x/clock.c                |  753 --------------------
> >  arch/powerpc/platforms/512x/mpc512x_shared.c       |  165 +++--
> >  arch/powerpc/sysdev/fsl_pci.c                      |   22 +
> >  drivers/clk/clk-divider.c                          |    6 +-
> >  drivers/clk/clk-gate.c                             |    6 +-
> >  drivers/clk/clk-mux.c                              |    6 +-
> >  drivers/i2c/busses/i2c-mpc.c                       |   24 +
> >  drivers/media/platform/fsl-viu.c                   |   23 +-
> >  drivers/mtd/nand/mpc5121_nfc.c                     |   21 +-
> >  drivers/net/can/mscan/mpc5xxx_can.c                |  281 +++++---
> >  drivers/net/can/mscan/mscan.c                      |   27 +-
> >  drivers/net/can/mscan/mscan.h                      |    3 +
> >  .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |   21 +-
> >  drivers/spi/spi-mpc512x-psc.c                      |   60 +-
> >  drivers/tty/serial/mpc52xx_uart.c                  |  179 ++++-
> >  drivers/usb/host/fsl-mph-dr-of.c                   |   27 +-
> >  include/dt-bindings/clock/mpc512x-clock.h          |   69 ++
> >  include/linux/clk-provider.h                       |   33 +
> >  include/linux/fs_enet_pd.h                         |    3 +
> >  28 files changed, 1534 insertions(+), 1058 deletions(-)
> >  create mode 120000 arch/powerpc/boot/dts/include/dt-bindings
> >  create mode 100644 arch/powerpc/platforms/512x/clock-commonclk.c
> >  delete mode 100644 arch/powerpc/platforms/512x/clock.c
> >  create mode 100644 include/dt-bindings/clock/mpc512x-clock.h


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
