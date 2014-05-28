Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9FD21A060D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 13:29:11 +1000 (EST)
Message-ID: <1401247741.8262.21.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 May 2014 13:29:01 +1000
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

Here's a pair of powerpc fixes for 3.15 which are also going to stable.

One's a fix for building with newer binutils (the problem currently only
affects the BookE kernels but the affected macro might come back into
use on BookS platforms at any time). Unfortunately, the binutils maintainer
did a backward incompatible change to a construct that we use so we have
to add Makefile check.

The other one is a fix for CPUs getting stuck in kexec when running single
threaded. Since we routinely use kexec on power (including in our newer
bootloaders), I deemed that important enough.

Cheers,
Ben.

The following changes since commit 8050936caf125fbe54111ba5e696b68a360556ba:

  powerpc: irq work racing with timer interrupt can result in timer interrupt hang (2014-05-12 14:29:28 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 011e4b02f1da156ac7fea28a9da878f3c23af739:

  powerpc, kexec: Fix "Processor X is stuck" issue during kexec from ST mode (2014-05-28 13:24:26 +1000)

----------------------------------------------------------------
Guenter Roeck (1):
      powerpc: Fix 64 bit builds with binutils 2.24

Srivatsa S. Bhat (1):
      powerpc, kexec: Fix "Processor X is stuck" issue during kexec from ST mode

 arch/powerpc/Makefile                  | 4 +++-
 arch/powerpc/include/asm/ppc_asm.h     | 7 ++++++-
 arch/powerpc/kernel/machine_kexec_64.c | 2 +-
 kernel/kexec.c                         | 8 ++++++++
 4 files changed, 18 insertions(+), 3 deletions(-)
