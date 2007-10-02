Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DEE01DDE01
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 22:54:29 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l92Bk0JA028505
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 07:46:00 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l92CsMmo498056
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 06:54:22 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l92CsMQD025184
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 06:54:22 -0600
Date: Tue, 2 Oct 2007 07:54:20 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20071002075420.0182bb7c@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24

to pick up a handful of new items for 2.6.24.  Initial Virtex support
from Grant, some cpu setup functions for 4xx from Valentine, a compile
fix for the Walnut wrapper, and a small number of arch/ppc fixes for
Xilinx boards.

Grant Likely (15):
      [POWERPC] Virtex: Add uartlite bootwrapper driver
      [POWERPC] Virtex: Add Kconfig macros for Xilinx Virtex board support
      [POWERPC] Virtex: add xilinx interrupt controller driver
      [POWERPC] Virtex: Add generic Xilinx Virtex board support
      [POWERPC] Add PowerPC Xilinx Virtex entry to maintainers
      [POWERPC] Uartlite: Fix reg io to access documented register size
      [POWERPC] Uartlite: change name of ports to ulite_ports
      [POWERPC] Uartlite: Add macro for uartlite device name
      [POWERPC] Uartlite: Separate the bus binding from the driver proper
      [POWERPC] Uartlite: Comment block tidy
      [POWERPC] Uartlite: Add of-platform-bus binding
      [POWERPC] Uartlite: Let the console be initialized earlier
      [POWERPC] Uartlite: Flush RX fifo in bootwrapper
      [POWERPC] XilinxFB: Move xilinxfb_platform_data definition to a shared hea
      [POWERPC] Setup default eth addr in embed_config for Xilinx Virtex platfor

Josh Boyer (2):
      [POWERPC] 4xx: Fix Walnut wrapper compile errors
      [POWERPC] Add treeImage to .gitignore

Valentine Barshak (3):
      [POWERPC] 4xx: Introduce cpu_setup functionality to 44x platform
      [POWERPC] 4xx: Move 440EP(x) FPU setup from head_44x to cpu_setup_4xx
      [POWERPC] 4xx: 440EPx/GRx incorrect write to DDR SDRAM errata workaround

 MAINTAINERS                          |    7 +
 arch/powerpc/boot/.gitignore         |    1 +
 arch/powerpc/boot/Makefile           |    3 +-
 arch/powerpc/boot/ops.h              |    1 +
 arch/powerpc/boot/serial.c           |    2 +
 arch/powerpc/boot/uartlite.c         |   64 +++++++
 arch/powerpc/kernel/Makefile         |    1 +
 arch/powerpc/kernel/cpu_setup_44x.S  |   56 ++++++
 arch/powerpc/kernel/cputable.c       |   22 ++-
 arch/powerpc/kernel/head_44x.S       |   10 -
 arch/powerpc/platforms/40x/Kconfig   |   38 +++--
 arch/powerpc/platforms/40x/Makefile  |    1 +
 arch/powerpc/platforms/40x/virtex.c  |   50 ++++++
 arch/powerpc/sysdev/Makefile         |    1 +
 arch/powerpc/sysdev/xilinx_intc.c    |  151 ++++++++++++++++
 arch/ppc/boot/simple/embed_config.c  |    8 +
 arch/ppc/boot/simple/misc-embedded.c |    4 +-
 arch/ppc/boot/simple/uartlite_tty.c  |    8 +
 arch/ppc/syslib/virtex_devices.c     |    2 +-
 arch/ppc/syslib/virtex_devices.h     |    8 +-
 drivers/serial/uartlite.c            |  318 +++++++++++++++++++++++++++-------
 drivers/video/xilinxfb.c             |    2 +-
 include/asm-powerpc/xilinx_intc.h    |   20 ++
 include/linux/xilinxfb.h             |   23 +++
 24 files changed, 698 insertions(+), 103 deletions(-)
 create mode 100644 arch/powerpc/boot/uartlite.c
 create mode 100644 arch/powerpc/kernel/cpu_setup_44x.S
 create mode 100644 arch/powerpc/platforms/40x/virtex.c
 create mode 100644 arch/powerpc/sysdev/xilinx_intc.c
 create mode 100644 include/asm-powerpc/xilinx_intc.h
 create mode 100644 include/linux/xilinxfb.h
