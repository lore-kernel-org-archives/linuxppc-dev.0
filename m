Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B50BF2C008F
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 16:01:28 +1100 (EST)
Message-ID: <1389762075.6933.76.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Jan 2014 16:01:15 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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

So you make the call onto whether taking that one now or waiting for the
merge window. It's a bug fix for a crash in mremap that occurs on
powerpc with THP enabled.

The fix however requires a small change in the generic code. It moves a
condition into a helper we can override from the arch which is harmless,
but it *also* slightly changes the order of the set_pmd and the withdraw
& deposit, which should be fine according to Kirill (who wrote that
code) but I agree -rc8 is a bit late...

It was acked by Kirill and Andrew told me to just merge it via powerpc.

My original intend was to put it in powerpc-next and then shoot it to
stable, but it got a tad annoying (due to churn it needs to be applied
at least on rc4 or later while my next is at rc1 and clean that way), so
I put it in the merge branch.

>From there, you tell me if you want to take it now, if not, I'll send
you that branch along with my normal next one after you open the merge
window.

Cheers,
Ben.

The following changes since commit a6da83f98267bc8ee4e34aa899169991eb0ceb93:

  Merge branch 'merge' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2014-01-13 10:59:05 +0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to b3084f4db3aeb991c507ca774337c7e7893ed04f:

  powerpc/thp: Fix crash on mremap (2014-01-15 15:46:38 +1100)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/thp: Fix crash on mremap

 arch/powerpc/include/asm/pgtable-ppc64.h | 14 ++++++++++++++
 include/asm-generic/pgtable.h            | 12 ++++++++++++
 mm/huge_memory.c                         | 14 +++++---------
 3 files changed, 31 insertions(+), 9 deletions(-)
