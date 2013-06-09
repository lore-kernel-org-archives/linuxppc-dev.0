Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1E8082C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 17:57:15 +1000 (EST)
Message-ID: <1370764616.14883.28.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 09 Jun 2013 17:56:56 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

Here are a few more powerpc changes for 3.10. I've merged your
tree in at some point (which I generally avoid) in order to get
the compat network fixes as soon as possible.

Mostly regressions, and stuff I judged could/should still go in at
this stage.

I'm still waiting on some more fixes to the signal handling
vs. transactional memory (this is really ugly btw) which are
hopefully coming next week.

Cheers,
Ben.

The following changes since commit 1612e111e4e565422242727efb59499cce8738e4:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2013-06-06 18:09:05 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 227331303afdca06e44dcda41d27b72015153827:

  powerpc: Print instruction when logging unhandled exceptions (2013-06-09 17:29:16 +1000)

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc: Print instruction when logging unhandled exceptions

Benjamin Herrenschmidt (1):
      Merge remote-tracking branch 'origin/master' into merge

Gavin Shan (1):
      powerpc/eeh: Don't check RTAS token to get PE addr

Kevin Hao (1):
      powerpc/pci: Check the bus address instead of resource address in pcibios_fixup_resources

Michael Ellerman (3):
      powerpc: Rename PMU interrupts from CNT to PMI
      powerpc/perf: Fix deadlock caused by calling printk() in PMU exception
      powerpc: Partial revert of "Context switch more PMU related SPRs"

Michael Neuling (4):
      powerpc/power8: Fix oprofile and perf
      powerpc/pseries: Simplify denormalization handler
      powerpc/power8: Update denormalization handler
      powerpc/hw_breakpoints: Add DABRX cpu feature to fix 32-bit regression

 arch/powerpc/include/asm/cputable.h          |   17 +++--
 arch/powerpc/kernel/cputable.c               |    8 +--
 arch/powerpc/kernel/entry_64.S               |   28 --------
 arch/powerpc/kernel/exceptions-64s.S         |   90 ++++++++------------------
 arch/powerpc/kernel/irq.c                    |    2 +-
 arch/powerpc/kernel/pci-common.c             |    4 +-
 arch/powerpc/kernel/process.c                |    3 +-
 arch/powerpc/kernel/traps.c                  |   11 +++-
 arch/powerpc/perf/core-book3s.c              |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   12 ++--
 10 files changed, 60 insertions(+), 117 deletions(-)
