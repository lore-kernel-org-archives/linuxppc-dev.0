Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B4F761007D7
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 09:37:01 +1100 (EST)
Message-ID: <1329518214.3980.7.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Feb 2012 09:36:54 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a few more fixes for powerpc. Some are regressions, the rest is
simple/obvious/nasty enough that I deemed it good to go now.

Here's also step one of deprecating legacy iSeries support: we are
removing it from the main defconfig.

Nobody seems to be using it anymore and the code is nasty to maintain,
(involves horrible hacks in various low level areas of the kernel) so we
plan to actually rip it out at some point. For now let's just avoid
building it by default. Stephen will proceed to do the actual removal
later (probably 3.4 or 3.5).

Cheers,
Ben.

The following changes since commit 778a785f02ad846446e91dab49331bd7d853c514:

  powerpc/pseries/eeh: Fix crash when error happens during device probe (2012-02-14 15:01:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 9a45a9407c69d068500923480884661e2b9cc421:

  powerpc/perf: power_pmu_start restores incorrect values, breaking frequency events (2012-02-16 16:24:35 +1100)

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc/perf: power_pmu_start restores incorrect values, breaking frequency events

Benjamin Herrenschmidt (2):
      powerpc/fsl/pci: Fix PCIe fixup regression
      powerpc: Disable interrupts early in Program Check

Ira Snyder (1):
      powerpc: Fix kernel log of oops/panic instruction dump

Stephen Rothwell (1):
      powerpc: Remove legacy iSeries from ppc64_defconfig

majianpeng (1):
      powerpc/adb: Use set_current_state()

 arch/powerpc/configs/ppc64_defconfig |    5 ---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 arch/powerpc/kernel/perf_event.c     |    8 +++++-
 arch/powerpc/kernel/process.c        |    6 ++--
 arch/powerpc/sysdev/fsl_pci.c        |   48 ++++++++++++++++++++-------------
 drivers/macintosh/adb.c              |    4 +-
 6 files changed, 42 insertions(+), 31 deletions(-)
