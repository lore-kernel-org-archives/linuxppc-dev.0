Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17476.55180.340464.351828@cargo.ozlabs.ibm.com>
Date: Tue, 18 Apr 2006 22:11:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
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

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

to get the following powerpc bug-fixes.

Thanks,
Paul.

Anton Blanchard:
      powerpc: Ensure runlatch is off in the idle loop
      powerpc: Avoid __initcall warnings

Jordi Caubet:
      spufs: fix context-switch decrementer code

Linas Vepstas:
      powerpc/pseries: bugfix: balance calls to pci_device_put

Michael Ellerman:
      powerpc: Fix machine detection in prom_init.c

Olaf Hering:
      powerpc32: Set cpu explicitly in kernel compiles

Paul Mackerras:
      powerpc: Fix CHRP booting - needs a define_machine call
      powerpc: Use correct sequence for putting CPU into nap mode

Stephen Rothwell:
      powerpc: iSeries has only 256 IRQs

Vitaly Bordug:
      ppc32: Fix string comparing in platform_notify_map

 arch/powerpc/Kconfig                       |    6 +++
 arch/powerpc/Makefile                      |    4 ++
 arch/powerpc/kernel/Makefile               |    2 -
 arch/powerpc/kernel/asm-offsets.c          |    1 
 arch/powerpc/kernel/entry_32.S             |   35 +++++++--------
 arch/powerpc/kernel/head_64.S              |   49 +++++++++++++++++++++
 arch/powerpc/kernel/idle.c                 |    4 +-
 arch/powerpc/kernel/idle_6xx.S             |   65 +++++++++-------------------
 arch/powerpc/kernel/idle_power4.S          |   10 +++-
 arch/powerpc/kernel/irq.c                  |   36 +++++++++-------
 arch/powerpc/kernel/prom_init.c            |    5 +-
 arch/powerpc/kernel/rtas-proc.c            |    4 +-
 arch/powerpc/platforms/cell/spufs/switch.c |    2 -
 arch/powerpc/platforms/chrp/chrp.h         |    1 
 arch/powerpc/platforms/chrp/pci.c          |    6 ++-
 arch/powerpc/platforms/chrp/setup.c        |   48 +++++++++------------
 arch/powerpc/platforms/iseries/setup.c     |    7 +++
 arch/powerpc/platforms/pseries/eeh.c       |    6 ++-
 arch/powerpc/platforms/pseries/rtasd.c     |    2 -
 arch/ppc/syslib/ppc_sys.c                  |    9 ++--
 include/asm-powerpc/irq.h                  |    7 +++
 include/asm-powerpc/thread_info.h          |    8 +++
 22 files changed, 194 insertions(+), 123 deletions(-)
