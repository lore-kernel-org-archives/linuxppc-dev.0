Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 83FC22C00B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 16:17:58 +1100 (EST)
Message-ID: <1363583869.21545.2.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Mar 2013 06:17:49 +0100
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

Here's a few powerpc fixes for 3.9, mostly regressions (though not all
from 3.9 merge window) that we've been hammering into shape over the
last couple of weeks. They fix booting on Cell and G5 among other
things (yes, we've been a bit sloppy with older machines this time
around).

Cheers,
Ben.

The following changes since commit 7c6baa304b841673d3a55ea4fcf9a5cbf7a1674b:

  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-03-11 07:54:29 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to af81d7878c641629f2693ae3fdaf74b4af14dfca:

  powerpc: Rename USER_ESID_BITS* to ESID_BITS* (2013-03-17 12:45:44 +1100)

----------------------------------------------------------------
Aneesh Kumar K.V (3):
      powerpc: Make VSID_BITS* dependency explicit
      powerpc: Update kernel VSID range
      powerpc: Rename USER_ESID_BITS* to ESID_BITS*

Anton Blanchard (1):
      powerpc: Fix -mcmodel=medium breakage in prom_init.c

Benjamin Herrenschmidt (2):
      powerpc: Fix STAB initialization
      powerpc: Fix cputable entry for 970MP rev 1.0

Michael Neuling (1):
      powerpc/ptrace: Fix brk.len used uninitialised

Paul Bolle (1):
      powerpc: Remove last traces of POWER4_ONLY

Stephen Rothwell (1):
      powerpc: Make sure that we alays include CONFIG_BINFMT_ELF

 arch/powerpc/Kconfig                   |    1 +
 arch/powerpc/include/asm/mmu-hash64.h  |  128 ++++++++++++++++----------------
 arch/powerpc/kernel/cputable.c         |    2 +-
 arch/powerpc/kernel/exceptions-64s.S   |   34 ++++++---
 arch/powerpc/kernel/prom_init.c        |   14 ++--
 arch/powerpc/kernel/ptrace.c           |    1 +
 arch/powerpc/kvm/book3s_64_mmu_host.c  |    4 +-
 arch/powerpc/mm/hash_utils_64.c        |   22 ++++--
 arch/powerpc/mm/mmu_context_hash64.c   |   11 +--
 arch/powerpc/mm/pgtable_64.c           |    2 +-
 arch/powerpc/mm/slb_low.S              |   50 ++++++-------
 arch/powerpc/mm/tlb_hash64.c           |    2 +-
 arch/powerpc/platforms/Kconfig.cputype |    6 +-
 13 files changed, 150 insertions(+), 127 deletions(-)
