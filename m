Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id CECADDDE30
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Apr 2007 17:28:01 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Rick Moleres <Rick.Moleres@xilinx.com>, Paul Mackerras <paulus@samba.org>
Subject: Patchset to establish sanity in Xilinx Virtex support
Date: Sun, 15 Apr 2007 01:27:37 -0600
Message-Id: <1176622062492-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The Virtex support in Linus' tree is a mess.  When I ported the common
devices over to using the platform bus I tried the use the ppc_sys
infrastructure.  ppc_sys is intended for SoCs that have a fixed set of
devices.  It is the *wrong* approach for FPGA support, and I made a
royal mess of things.  This patch set fixes that problem and makes
a number of other changes that make supporting Virtex boards easier.

I do know that changes to arch/ppc are frowned upon at the moment.  However,
4xx support in arch/powerpc is not merged yet, and Virtex support needs
additional work beyond that.  I suspect that arch/ppc support for the
4xx parts is going to need to stay alive for the next 2-3 kernel releases
anyway while arch/powerpc support stablizes.  Getting these patches in
will make it easier to support the Virtex ports while I hack on getting
arch/powerpc stuff figured out.

 arch/ppc/boot/common/misc-common.c    |   15 ++-
 arch/ppc/boot/simple/Makefile         |    1 +
 arch/ppc/boot/simple/uartlite_tty.c   |   37 ++++++
 arch/ppc/platforms/4xx/Kconfig        |   13 +-
 arch/ppc/platforms/4xx/Makefile       |    1 -
 arch/ppc/platforms/4xx/virtex.c       |   56 ---------
 arch/ppc/platforms/4xx/virtex.h       |   47 +++++---
 arch/ppc/platforms/4xx/xilinx_ml300.c |   65 +----------
 arch/ppc/platforms/4xx/xilinx_ml300.h |   45 -------
 arch/ppc/platforms/4xx/xilinx_ml403.c |   66 +----------
 arch/ppc/platforms/4xx/xilinx_ml403.h |   49 --------
 arch/ppc/syslib/Makefile              |    3 +-
 arch/ppc/syslib/virtex_devices.c      |  209 +++++++++++++++++++++++++++++++++
 arch/ppc/syslib/virtex_devices.h      |   27 +++++
 include/asm-ppc/ibm4xx.h              |    8 +-
 include/asm-ppc/ppc_sys.h             |    2 -
 16 files changed, 335 insertions(+), 309 deletions(-)
