Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA5E92C0099
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Feb 2014 19:45:40 +1100 (EST)
Message-ID: <1393577130.22449.8.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Feb 2014 19:45:30 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a few more powerpc fixes for 3.14. Most of these are also
CC'ed to stable and fix bugs in new functionality introduced in
the last 2 or 3 versions.

The following changes since commit 66f9af83e56bfa12964d251df9d60fb571579913:

  powerpc/eeh: Disable EEH on reboot (2014-02-17 11:19:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to e0cf957614976896111e676e5134ac98ee227d3d:

  powerpc/powernv: Fix indirect XSCOM unmangling (2014-02-28 19:15:49 +1100)

----------------------------------------------------------------
Benjamin Herrenschmidt (2):
      powerpc/powernv: Fix opal_xscom_{read,write} prototype
      powerpc/powernv: Fix indirect XSCOM unmangling

Gavin Shan (2):
      powerpc/powernv: Dump PHB diag-data immediately
      powerpc/powernv: Refactor PHB diag-data dump

Laurent Dufour (1):
      powerpc/crashdump : Fix page frame number check in copy_oldmem_page

Liu Ping Fan (1):
      powerpc/ftrace: bugfix for test_24bit_addr

Paul Mackerras (1):
      powerpc: Increase stack redzone for 64-bit userspace to 512 bytes

Tony Breeds (1):
      powerpc/le: Ensure that the 'stop-self' RTAS token is handled correctly

 arch/powerpc/include/asm/compat.h            |   5 +-
 arch/powerpc/include/asm/opal.h              |   4 +-
 arch/powerpc/include/asm/ptrace.h            |  16 +-
 arch/powerpc/kernel/crash_dump.c             |   8 +-
 arch/powerpc/kernel/ftrace.c                 |   1 +
 arch/powerpc/kernel/signal_64.c              |   4 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c    |  96 ++++++------
 arch/powerpc/platforms/powernv/opal-xscom.c  |  21 +--
 arch/powerpc/platforms/powernv/pci.c         | 220 +++++++++++++++------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  22 +--
 10 files changed, 219 insertions(+), 178 deletions(-)
