Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B447F2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 18:17:38 +1000 (EST)
Message-ID: <1376036249.32100.36.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 09 Aug 2013 18:17:29 +1000
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

Here are some powerpc fixes for you.

This includes small series from Michael Neuling to fix a couple of nasty
remaining problems with the new Power8 support, also targeted at stable
3.10, without which some new userspace accessible registers aren't
properly context switched, and in some case, can be clobbered by the
user of transactional memory.

Along with that, a few slightly more minor things, such as a missing
Kconfig option to enable handling of denorm exceptions when not running
under a hypervisor (or userspace will randomly crash when hitting
denorms with the vector unit), some nasty bugs in the new pstore oops
code, and other simple bug fixes worth having in now.

Note: I picked up the two powerpc KVM fixes as Alex Graf asked me to
handle KVM bits while he is on vacation. However I'll let him decide
whether they should go to -stable or not when he is back.

Cheers,
Ben.

The following changes since commit b7bc9e7d808ba55729bd263b0210cda36965be32:

  Merge tag 'trace-fixes-3.11-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2013-08-07 13:01:30 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 28e61cc466d8daace4b0f04ba2b83e0bd68f5832:

  powerpc/tm: Fix context switching TAR, PPR and DSCR SPRs (2013-08-09 18:07:12 +1000)

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc: On POWERNV enable PPC_DENORMALISATION by default

Aruna Balakrishnaiah (2):
      powerpc/pseries: Fix buffer overflow when reading from pstore
      powerpc/pseries: Add backward compatibilty to read old kernel oops-log

Chen Gang (1):
      powerpc/kvm: Add signed type cast for comparation

Michael Neuling (5):
      powerpc: Fix hypervisor facility unavaliable vector number
      powerpc: Rework setting up H/FSCR bit definitions
      powerpc: Fix context switch DSCR on POWER8
      powerpc: Save the TAR register earlier
      powerpc/tm: Fix context switching TAR, PPR and DSCR SPRs

Mike Qiu (1):
      powerpc/eeh: Add missing procfs entry for PowerNV

Thadeu Lima de Souza Cascardo (1):
      powerpc/kvm/book3s_pr: Return appropriate error when allocation fails

 arch/powerpc/Kconfig                   |  2 +-
 arch/powerpc/include/asm/processor.h   |  4 ++
 arch/powerpc/include/asm/reg.h         | 31 ++++++++-----
 arch/powerpc/include/asm/switch_to.h   |  9 ++++
 arch/powerpc/kernel/asm-offsets.c      |  3 ++
 arch/powerpc/kernel/eeh.c              |  2 +-
 arch/powerpc/kernel/entry_64.S         | 36 ++++++++++-----
 arch/powerpc/kernel/exceptions-64s.S   |  5 ++-
 arch/powerpc/kernel/process.c          | 10 +++++
 arch/powerpc/kernel/tm.S               | 20 +++++++++
 arch/powerpc/kernel/traps.c            | 58 ++++++++++++++----------
 arch/powerpc/kvm/book3s_hv.c           |  4 +-
 arch/powerpc/kvm/book3s_pr.c           |  5 ++-
 arch/powerpc/platforms/pseries/nvram.c | 80 +++++++++++++++-------------------
 14 files changed, 170 insertions(+), 99 deletions(-)
