Return-Path: <richardcochran@gmail.com>
Date: Wed, 23 Feb 2011 11:37:32 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH V11 0/4] ptp: IEEE 1588 hardware clock support
Message-ID: <cover.1298447722.git.richard.cochran@omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>,
	Paul Mackerras <paulus@samba.org>, John Stultz <john.stultz@linaro.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This just might be the last round of review of the PTP hardware clock
patch series. These patches apply on top of the timers/core branch in
the tip tree. Patches 1 and 4 have changed since the last version.

* Why all the CCs?
  - One driver is for PowerPC, and adds device tree stuff.
  - One driver is for the ARM Xscale IXP465.

* Patch ChangeLog
** v11
   - added more padding to the structures in the user space ABI
   - tweaked Kconfig to make dependencies more clear
   - fixed locking on time stamp event queue
   - added John Stultz's acks on patches 2 and 3.
   - now the phyter driver handles multiple PHYs


Richard Cochran (4):
  ptp: Added a brand new class driver for ptp clocks.
  ptp: Added a clock that uses the eTSEC found on the MPC85xx.
  ptp: Added a clock driver for the IXP46x.
  ptp: Added a clock driver for the National Semiconductor PHYTER.

 Documentation/ABI/testing/sysfs-ptp                |   98 ++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |   57 ++
 Documentation/ptp/ptp.txt                          |   89 ++
 Documentation/ptp/testptp.c                        |  352 +++++++
 Documentation/ptp/testptp.mk                       |   33 +
 arch/arm/mach-ixp4xx/include/mach/ixp46x_ts.h      |   78 ++
 arch/powerpc/boot/dts/mpc8313erdb.dts              |   14 +
 arch/powerpc/boot/dts/mpc8572ds.dts                |   14 +
 arch/powerpc/boot/dts/p2020ds.dts                  |   14 +
 arch/powerpc/boot/dts/p2020rdb.dts                 |   14 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/net/Makefile                               |    1 +
 drivers/net/arm/ixp4xx_eth.c                       |  192 ++++-
 drivers/net/gianfar_ptp.c                          |  448 +++++++++
 drivers/net/gianfar_ptp_reg.h                      |  113 +++
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/dp83640.c                          | 1012 ++++++++++++++++++++
 drivers/net/phy/dp83640_reg.h                      |  267 +++++
 drivers/ptp/Kconfig                                |   75 ++
 drivers/ptp/Makefile                               |    7 +
 drivers/ptp/ptp_chardev.c                          |  156 +++
 drivers/ptp/ptp_clock.c                            |  320 ++++++
 drivers/ptp/ptp_ixp46x.c                           |  332 +++++++
 drivers/ptp/ptp_private.h                          |   86 ++
 drivers/ptp/ptp_sysfs.c                            |  230 +++++
 include/linux/Kbuild                               |    1 +
 include/linux/ptp_clock.h                          |   84 ++
 include/linux/ptp_clock_kernel.h                   |  139 +++
 29 files changed, 4227 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-ptp
 create mode 100644 Documentation/ptp/ptp.txt
 create mode 100644 Documentation/ptp/testptp.c
 create mode 100644 Documentation/ptp/testptp.mk
 create mode 100644 arch/arm/mach-ixp4xx/include/mach/ixp46x_ts.h
 create mode 100644 drivers/net/gianfar_ptp.c
 create mode 100644 drivers/net/gianfar_ptp_reg.h
 create mode 100644 drivers/net/phy/dp83640.c
 create mode 100644 drivers/net/phy/dp83640_reg.h
 create mode 100644 drivers/ptp/Kconfig
 create mode 100644 drivers/ptp/Makefile
 create mode 100644 drivers/ptp/ptp_chardev.c
 create mode 100644 drivers/ptp/ptp_clock.c
 create mode 100644 drivers/ptp/ptp_ixp46x.c
 create mode 100644 drivers/ptp/ptp_private.h
 create mode 100644 drivers/ptp/ptp_sysfs.c
 create mode 100644 include/linux/ptp_clock.h
 create mode 100644 include/linux/ptp_clock_kernel.h
