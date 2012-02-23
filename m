Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3E395B6FBC
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2012 15:58:09 +1100 (EST)
Message-ID: <1329973080.20389.23.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Feb 2012 15:58:00 +1100
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

Here are a few more powerpc bits for you. A stupid regression I
introduced with my previous commit to "fix" program check exceptions
(brown paper bag for me), fix the cpuidle default, a bug fix for
something that isn't strictly speaking a regression but some
upstream changes causes it to show in lockdep now while it didn't
before, and finally a trivial one for rusty to make his life
easier later on removing the old cpumask cruft.

Cheers,
Ben.

The following changes since commit 27e74da9800289e69ba907777df1e2085231eff7:

  i387: export 'fpu_owner_task' per-cpu variable (2012-02-20 19:34:10 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 18b246fa60dd4bfc71c78d669e2ffaa5df454d6a:

  powerpc: Fix various issues with return to userspace (2012-02-22 16:48:53 +1100)

----------------------------------------------------------------
Benjamin Herrenschmidt (2):
      cpuidle: Default y on powerpc pSeries
      powerpc: Fix various issues with return to userspace

Michael Ellerman (1):
      powerpc: Fix program check handling when lockdep is enabled

Rusty Russell (1):
      powerpc: Remove references to cpu_*_map

 arch/powerpc/kernel/entry_32.S       |    2 +-
 arch/powerpc/kernel/entry_64.S       |    6 +++++-
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 arch/powerpc/kernel/signal.c         |   12 ++++++++----
 arch/powerpc/kernel/signal.h         |    2 +-
 arch/powerpc/platforms/wsp/smp.c     |    2 +-
 drivers/cpuidle/Kconfig              |    2 +-
 7 files changed, 18 insertions(+), 10 deletions(-)
