Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0554B1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 14:14:45 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 14:14:28 +1000
Message-ID: <1279858468.1970.64.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@arm.linux.org.uk>,
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

Here's a few things for 2.6.35.

One's a fallover from the lmb->memblock rename that I missed, which causes
a bunch of pseries machine to boot with 128M of memory and that's it :-)

There's a few patches fixing a nasty race we found in our hugepage code,
a kexec fix from Kumar, and an .lds fix from Sam for a bug that as far
as we know only affects powerpc.

Cheers,
Ben.

The following changes since commit b37fa16e78d6f9790462b3181602a26b5af36260:
  Linus Torvalds (1):
        Linux 2.6.35-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Blanchard (1):
      powerpc/mm: Handle hypervisor pte insert failure in __hash_page_huge

Benjamin Herrenschmidt (5):
      powerpc/mm: Move around testing of _PAGE_PRESENT in hash code
      powerpc/mm: Fix bugs in huge page hashing
      powerpc/mm: Add some debug output when hash insertion fails
      powerpc: Fix erroneous lmb->memblock conversions
      Merge commit 'kumar/merge' into merge

Kumar Gala (1):
      powerpc/kexec: Fix boundary case for book-e kexec memory limits

Sam Ravnborg (1):
      vmlinux.lds: fix .data..init_task output section (fix popwerpc boot)

 arch/powerpc/include/asm/kexec.h                |    6 +-
 arch/powerpc/include/asm/mmu-hash64.h           |    4 +-
 arch/powerpc/kernel/prom.c                      |    2 +-
 arch/powerpc/mm/hash_low_64.S                   |    9 ----
 arch/powerpc/mm/hash_utils_64.c                 |   53 +++++++++++++++++------
 arch/powerpc/mm/hugetlbpage-hash64.c            |   40 +++++++++--------
 arch/powerpc/mm/numa.c                          |   24 +++++-----
 arch/powerpc/platforms/pseries/hotplug-memory.c |   22 +++++-----
 include/asm-generic/vmlinux.lds.h               |    2 +-
 9 files changed, 93 insertions(+), 69 deletions(-)
