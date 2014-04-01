Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2163F1400E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 10:38:10 +1100 (EST)
Message-ID: <1396395482.19762.32.camel@pasglop>
Subject: [git pull] Please pull powerpc.git powernv-cpuidle branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 02 Apr 2014 10:38:02 +1100
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

This is the branch I mentioned in my other pull request which contains
our improved cpuidle support for the "powernv" platform
(non-virtualized). It adds support for the "fast sleep" feature of the
processor which provides higher power savings than our usual "nap" mode
but at the cost of losing the timers while asleep, and thus exploits the
new timer broadcast framework to work around that limitation.

It's based on a tip timer tree that you seem to have already merged

Cheers,
Ben.

The following changes since commit 849401b66d305f3feb75b6db7459b95ad190552a:

  tick: Fixup more fallout from hrtimer broadcast mode (2014-02-09 15:11:47 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git powernv-cpuidle

for you to fetch changes up to 0888839c5b62c44a55ac9d28acc273ba663c65ea:

  cpuidle/powernv: Parse device tree to setup idle states (2014-03-05 15:57:08 +1100)

----------------------------------------------------------------
Preeti U Murthy (3):
      powerpc: Split timer_interrupt() into timer handling and interrupt handling routines
      cpuidle/powernv: Add "Fast-Sleep" CPU idle state
      cpuidle/powernv: Parse device tree to setup idle states

Srivatsa S. Bhat (2):
      powerpc: Free up the slot of PPC_MSG_CALL_FUNC_SINGLE IPI message
      powerpc: Implement tick broadcast IPI as a fixed IPI message

Vaidyanathan Srinivasan (2):
      powerpc/powernv: Add context management for Fast Sleep
      powerpc/powernv: Add OPAL call to resync timebase on wakeup

 arch/powerpc/Kconfig                           |   2 +
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/include/asm/processor.h           |   1 +
 arch/powerpc/include/asm/smp.h                 |   2 +-
 arch/powerpc/include/asm/time.h                |   1 +
 arch/powerpc/kernel/exceptions-64s.S           |  10 ++-
 arch/powerpc/kernel/idle_power7.S              |  90 +++++++++++++++++-----
 arch/powerpc/kernel/smp.c                      |  25 ++++--
 arch/powerpc/kernel/time.c                     |  90 +++++++++++++---------
 arch/powerpc/platforms/cell/interrupt.c        |   2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/ps3/smp.c               |   2 +-
 drivers/cpuidle/cpuidle-powernv.c              | 102 ++++++++++++++++++++++---
 13 files changed, 253 insertions(+), 77 deletions(-)
