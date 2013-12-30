Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 028E02C0172
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Dec 2013 15:37:56 +1100 (EST)
Message-ID: <1388378259.4373.30.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Dec 2013 15:37:39 +1100
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

Here are a few more powerpc fixes for 3.13. A bit more endian
problems found during testing of 3.13 and a few other simple fixes
and regressions fixes.

Cheers,
Ben.

The following changes since commit 803c2d2f84da9dc2619449994af34d27148ab20d:

  powerpc/powernv: Fix OPAL LPC access in Little Endian (2013-12-13 15:55:15 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to f991db1cf1bdca43675b5d2df0af991719727029:

  Merge remote-tracking branch 'agust/merge' into merge (2013-12-30 14:48:27 +1100)

----------------------------------------------------------------

Anton Blanchard (1):
      powerpc: Align p_end

Brian W Hart (2):
      powernv/eeh: Fix possible buffer overrun in ioda_eeh_phb_diag()
      powernv/eeh: Add buffer for P7IOC hub error data

Gerhard Sittig (1):
      powerpc/512x: dts: remove misplaced IRQ spec from 'soc' node (5125)

Matteo Facchinetti (1):
      powerpc/512x: dts: disable MPC5125 usb module

Michael Neuling (1):
      powerpc: Fix bad stack check in exception entry

Olof Johansson (1):
      powerpc: Fix alignment of secondary cpu spin vars

Paul E. McKenney (1):
      powerpc: Make 64-bit non-VMX __copy_tofrom_user bi-endian

Rajesh B Prathipati (1):
      powerpc: Make unaligned accesses endian-safe for powerpc

 arch/powerpc/boot/dts/mpc5125twr.dts      |  6 +++-
 arch/powerpc/include/asm/exception-64s.h  |  2 +-
 arch/powerpc/include/asm/unaligned.h      |  7 +++-
 arch/powerpc/kernel/head_64.S             |  2 ++
 arch/powerpc/lib/copyuser_64.S            | 53 ++++++++++++++++++++++---------
 arch/powerpc/platforms/powernv/eeh-ioda.c | 20 +++---------
 arch/powerpc/platforms/powernv/pci.h      |  4 ++-
 7 files changed, 60 insertions(+), 34 deletions(-)
