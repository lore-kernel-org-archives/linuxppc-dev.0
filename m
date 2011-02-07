Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7499B6F12
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2011 14:58:05 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 14:57:55 +1100
Message-ID: <1297051075.14982.31.camel@pasglop>
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

Here are a few powerpc bug fixes for you. Mostly Anton and Jesse fixing
up the new VPNH feature (which was added this cycle) and a handful of
other fixes worth having.

Cheers,
Ben.

The following changes since commit 8dbdea8444d303a772bceb1ba963f0e3273bfc5e:

  Merge branch 'ixp4xx' of git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux-2.6 (2011-02-06 12:05:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Blanchard (6):
      powerpc/numa: Only use active VPHN count fields
      powerpc/numa: Check for all VPHN changes
      powerpc/numa: Add length when creating OF properties via VPHN
      powerpc/numa: Disable VPHN on dedicated processor partitions
      powerpc/numa: Fix bug in unmap_cpu_from_node
      powerpc: Fix hcall tracepoint recursion

Benjamin Herrenschmidt (2):
      powerpc: Pass the right cpu_spec to ->setup_cpu() on 64-bit
      powerpc: Fix some 6xx/7xxx CPU setup functions

Jesse Larrew (3):
      powerpc/pseries: Fix typo in VPHN comments
      powerpc/pseries: Fix brace placement in numa.c
      powerpc/pseries: Remove unnecessary variable initializations in numa.c

Scott Wood (2):
      powerpc: Fix pfn_valid() when memory starts at a non-zero address
      powerpc/book3e: Protect complex macro args in mmu-book3e.h

 arch/powerpc/include/asm/mmu-book3e.h |    8 ++--
 arch/powerpc/include/asm/page.h       |    2 +-
 arch/powerpc/kernel/cpu_setup_6xx.S   |   40 ++++++++++++------------
 arch/powerpc/kernel/cputable.c        |    4 +-
 arch/powerpc/mm/numa.c                |   55 ++++++++++++++++++---------------
 arch/powerpc/platforms/pseries/lpar.c |   37 ++++++++++++++++++++++
 6 files changed, 94 insertions(+), 52 deletions(-)
