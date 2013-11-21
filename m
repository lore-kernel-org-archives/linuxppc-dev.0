Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9BCB62C016E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 11:35:02 +1100 (EST)
Message-ID: <1384994090.26969.130.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2013 11:34:50 +1100
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

Since you pulled my previous one in less than 20mn (the LE stuff),
there's no point waiting for tomorrow for these fixes I mentioned
earlier so here they are.

This is a small collection of random bug fixes and a few improvements
of Oops output which I deemed valuable enough to include as well.

The fixes are essentially recent build breakage and regressions,
and a couple of older bugs such as the DTL log duplication, the
EEH issue with PCI_COMMAND_MASTER and the problem with small
contexts passed to get/set_context with VSX enabled.

Cheers,
Ben.
The following changes since commit b4789b8e6be3151a955ade74872822f30e8cd914:

  aacraid: prevent invalid pointer dereference (2013-11-19 16:27:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to c13f20ac48328b05cd3b8c19e31ed6c132b44b42:

  powerpc/signals: Mark VSX not saved with small contexts (2013-11-21 10:33:45 +1100)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc: booke: Fix build failures

Anton Blanchard (5):
      powerpc: Print DAR and DSISR on machine check oopses
      powerpc: Remove a few lines of oops output
      powerpc/pseries: Duplicate dtl entries sometimes sent to userspace
      powerpc: Only print PACATMSCRATCH in oops when TM is active
      powerpc: ppc64 address space capped at 32TB, mmap randomisation disabled

Gavin Shan (2):
      powerpc/eeh: Enable PCI_COMMAND_MASTER for PCI bridges
      powerpc/eeh: More accurate log

Heiko Carstens (1):
      powerpc: Fix __get_user_pages_fast() irq handling

Li Zhong (1):
      powerpc/vio: Fix a dma_mask issue of vio

Michael Ellerman (2):
      powerpc: Make cpu_to_chip_id() available when SMP=n
      powerpc/pseries: Fix SMP=n build of rng.c

Michael Neuling (1):
      powerpc/signals: Mark VSX not saved with small contexts

 arch/powerpc/include/asm/smp.h        |  2 +-
 arch/powerpc/kernel/eeh.c             |  9 +++++++++
 arch/powerpc/kernel/eeh_event.c       |  9 +++++++--
 arch/powerpc/kernel/process.c         | 21 +++++++++++----------
 arch/powerpc/kernel/prom.c            | 20 ++++++++++++++++++++
 arch/powerpc/kernel/signal_32.c       | 10 +++++++++-
 arch/powerpc/kernel/smp.c             | 16 ----------------
 arch/powerpc/kernel/time.c            |  4 ++--
 arch/powerpc/kernel/vio.c             |  2 +-
 arch/powerpc/mm/gup.c                 |  5 +++--
 arch/powerpc/mm/slice.c               |  2 +-
 arch/powerpc/platforms/powernv/rng.c  |  1 +
 arch/powerpc/platforms/pseries/rng.c  |  1 +
 arch/powerpc/platforms/wsp/chroma.c   |  1 +
 arch/powerpc/platforms/wsp/h8.c       |  1 +
 arch/powerpc/platforms/wsp/ics.c      |  2 ++
 arch/powerpc/platforms/wsp/opb_pic.c  |  2 ++
 arch/powerpc/platforms/wsp/psr2.c     |  1 +
 arch/powerpc/platforms/wsp/scom_wsp.c |  1 +
 arch/powerpc/platforms/wsp/wsp.c      |  1 +
 20 files changed, 75 insertions(+), 36 deletions(-)
