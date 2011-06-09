Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06811B6FFB
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jun 2011 06:45:38 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Jun 2011 06:45:28 +1000
Message-ID: <1307652328.2874.274.camel@pasglop>
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

Here are a small batch of fixes for powerpc.

Just one note: I just noticed a mistake while fixing a bug in "powerpc:
Force page alignment for initrd reserved memory". Bloody "citool"
changed the authorchip to me. The real author is Dave Carroll
<dcarroll@astekcorp.com>. (it's a nasty mis-feature of ci-tool that
overrides the author when doing an amend of an existing commit).

I didn't want to rebase the branch for that tho.

Cheers,
Ben.

The following changes since commit 06e86849cf4019945a106913adb9ff0abcc01770:

  Merge branch 'pm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6 (2011-06-08 15:58:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1): (Dave Carroll really)
      powerpc: Force page alignment for initrd reserved memory

Kumar Gala (2):
      powerpc/fsl_rio: Fix compile error when CONFIG_FSL_RIO not set
      powerpc/book3e: Fix CPU feature handling on e5500 in 32-bit mode

Shaohui Xie (1):
      powerpc/85xx: fix race bug of calling request_irq after enable elbc interrupts

Wolfram Sang (1):
      dtc/powerpc: remove obsolete .gitignore entries

 arch/powerpc/boot/.gitignore         |    1 -
 arch/powerpc/boot/dtc-src/.gitignore |    3 ---
 arch/powerpc/include/asm/rio.h       |    2 +-
 arch/powerpc/kernel/cputable.c       |    2 +-
 arch/powerpc/kernel/prom.c           |   27 ++++++++++++++++++++++++---
 arch/powerpc/mm/init_32.c            |   15 ---------------
 arch/powerpc/mm/init_64.c            |   14 --------------
 arch/powerpc/mm/mem.c                |   19 +++++++++++++++++++
 arch/powerpc/sysdev/fsl_lbc.c        |    6 +++---
 9 files changed, 48 insertions(+), 41 deletions(-)
 delete mode 100644 arch/powerpc/boot/dtc-src/.gitignore
