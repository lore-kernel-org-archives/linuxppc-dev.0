Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0A152C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 17:32:12 +1000 (EST)
Message-ID: <1377588720.3819.113.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Aug 2013 17:32:00 +1000
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

Here are 3 bug fixes that should probably go into 3.11 since I'm also
tagging them for stable.

Once fixes our old /proc/powerpc/lparcfg file which provides partition
informations when running under our hypervisor and also acts as a
user-triggerable Oops when hot :-(

The other two respectively are a one liner to fix a HVSI protocol
handshake problem causing the console to fail to show up on a bunch of
machines until we reach userspace, which I deem annoying enough to
warrant going to stable, and a nasty gcc miscompile causing us to
pass virtual instead of physical addresses to the firmware under some
circumstances.

Cheers,
Ben.
The following changes since commit 28e61cc466d8daace4b0f04ba2b83e0bd68f5832:

  powerpc/tm: Fix context switching TAR, PPR and DSCR SPRs (2013-08-09 18:07:12 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to d220980b701d838560a70de691b53be007e99e78:

  powerpc/hvsi: Increase handshake timeout from 200ms to 400ms. (2013-08-27 16:59:56 +1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Don't Oops when accessing /proc/powerpc/lparcfg without hypervisor

Eugene Surovegin (1):
      powerpc/hvsi: Increase handshake timeout from 200ms to 400ms.

Paul Mackerras (1):
      powerpc: Work around gcc miscompilation of __pa() on 64-bit

 arch/powerpc/Kconfig            |  1 +
 arch/powerpc/include/asm/page.h | 10 ++++++++++
 arch/powerpc/kernel/lparcfg.c   | 22 +++++++++-------------
 drivers/tty/hvc/hvsi_lib.c      |  4 ++--
 4 files changed, 22 insertions(+), 15 deletions(-)
