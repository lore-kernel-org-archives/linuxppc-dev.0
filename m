Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C43B42C009D
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 11:57:20 +1100 (EST)
Message-ID: <1387155428.15730.179.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Dec 2013 11:57:08 +1100
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

Here are some more powerpc fixes for 3.13.

Uli's patch fixes a regression in ptrace caused by a mis-merge of
a previous LE patch. The rest are all more endian fixes, all fairly
trivial, found during testing of 3.13-rc's.

Cheers,
Ben.

The following changes since commit e641eb03ab2b0f065fa5e64b4202fb5b0441b427:

  powerpc: Fix up the kdump base cap to 128M (2013-12-10 11:28:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 803c2d2f84da9dc2619449994af34d27148ab20d:

  powerpc/powernv: Fix OPAL LPC access in Little Endian (2013-12-13 15:55:15 +1100)

----------------------------------------------------------------
Anton Blanchard (8):
      powerpc: Fix endian issue in setup-common.c
      powerpc: Fix topology core_id endian issue on LE builds
      powerpc/pseries: Fix endian issues in /proc/ppc64/lparcfg
      powerpc/pseries: Fix endian issues in nvram code
      powerpc/pseries: Fix PCIE link speed endian issue
      powerpc/pseries: Fix endian issues in MSI code
      powerpc: Fix endian issues in crash dump code
      powerpc/powernv: Fix endian issue in opal_xscom_read

Benjamin Herrenschmidt (1):
      powerpc/powernv: Fix OPAL LPC access in Little Endian

Ulrich Weigand (1):
      powerpc: PTRACE_PEEKUSR always returns FPR0

 arch/powerpc/include/asm/opal.h             |  4 +--
 arch/powerpc/kernel/crash_dump.c            |  6 ++--
 arch/powerpc/kernel/ptrace.c                |  4 +--
 arch/powerpc/kernel/setup-common.c          |  4 +--
 arch/powerpc/kernel/smp.c                   |  4 +--
 arch/powerpc/platforms/powernv/opal-lpc.c   | 12 ++++----
 arch/powerpc/platforms/powernv/opal-xscom.c |  4 ++-
 arch/powerpc/platforms/pseries/lparcfg.c    | 12 ++++----
 arch/powerpc/platforms/pseries/msi.c        | 28 ++++++++++--------
 arch/powerpc/platforms/pseries/nvram.c      | 46 ++++++++++++++---------------
 arch/powerpc/platforms/pseries/pci.c        |  8 ++---
 11 files changed, 68 insertions(+), 64 deletions(-)
