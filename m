Return-Path: <richardcochran@gmail.com>
Date: Mon, 28 Feb 2011 08:57:03 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH V12 0/4] ptp: IEEE 1588 hardware clock support
Message-ID: <cover.1298878618.git.richard.cochran@omicron.at>
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

This really might be the last review of the PTP hardware clock patch
series. These patches apply on top of the timers/core branch in the
tip tree.

* Why all the CCs?
  - One driver is for PowerPC, and adds device tree stuff.
  - One driver is for the ARM Xscale IXP465.

* PHC Patch ChangeLog
** v12
*** gianfar_ptp
   - fixed up device tree
   - inlined the header file
   - use platform_ calls instead of deprecated of_ calls
   - removed static global single instance
   - removed John Stultz's ack from this patch

* Previous Discussions

  - [V11] http://lkml.org/lkml/2011/2/23/107
  - [V10] http://lkml.org/lkml/2011/1/27/71
  - [V9]  http://lkml.org/lkml/2011/1/13/65
  - [V8]  http://lkml.org/lkml/2010/12/31/128
  - [V7]  http://lkml.org/lkml/2010/12/16/195
  - [V6]  http://lkml.org/lkml/2010/9/23/310
  - [V5]  http://lkml.org/lkml/2010/8/16/90

  - Thomas Gleixner: Rework of the PTP support series core code
    http://lkml.org/lkml/2011/2/1/137

  - Dynamic clock devices [RFC]
    http://lkml.org/lkml/2010/11/4/290

  - POSIX clock tuning syscall with dynamic clock ids
    http://lkml.org/lkml/2010/9/3/119

  - POSIX clock tuning syscall with static clock ids
    http://lkml.org/lkml/2010/8/23/49

  - Versions 1-4 appeared on the netdev list.


Richard Cochran (4):
  ptp: Added a brand new class driver for ptp clocks.
  ptp: Added a clock that uses the eTSEC found on the MPC85xx.
  ptp: Added a clock driver for the IXP46x.
  ptp: Added a clock driver for the National Semiconductor PHYTER.

 Documentation/ABI/testing/sysfs-ptp                |   98 ++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |   54 +
 Documentation/ptp/ptp.txt                          |   89 ++
 Documentation/ptp/testptp.c                        |  352 +++++++
 Documentation/ptp/testptp.mk                       |   33 +
 arch/arm/mach-ixp4xx/include/mach/ixp46x_ts.h      |   78 ++
 arch/powerpc/boot/dts/mpc8313erdb.dts              |   13 +
 arch/powerpc/boot/dts/mpc8572ds.dts                |   13 +
 arch/powerpc/boot/dts/p2020ds.dts                  |   13 +
 arch/powerpc/boot/dts/p2020rdb.dts                 |   13 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/net/Makefile                               |    1 +
 drivers/net/arm/ixp4xx_eth.c                       |  192 ++++-
 drivers/net/gianfar_ptp.c                          |  579 +++++++++++
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
 28 files changed, 4238 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-ptp
 create mode 100644 Documentation/ptp/ptp.txt
 create mode 100644 Documentation/ptp/testptp.c
 create mode 100644 Documentation/ptp/testptp.mk
 create mode 100644 arch/arm/mach-ixp4xx/include/mach/ixp46x_ts.h
 create mode 100644 drivers/net/gianfar_ptp.c
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
