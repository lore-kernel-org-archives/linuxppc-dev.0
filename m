Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B005E2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 13:22:35 +1000 (EST)
Message-ID: <1378869743.3783.8.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Sep 2013 13:22:23 +1000
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

Here are a handful of small powerpc fixes. A couple of section mismatches
(always worth fixing), a missing export of a new symbol causing build
failures of modules, a page fault deadlock fix (interestingly that
bug has been around for a LONG time, though it seems to be more easily
triggered by KVM) and fixing pseries default idle loop in the absence of
the cpuidle drivers (such as during boot).

Cheers,
Ben.

The following changes since commit 8d7551eb1916832f2a5b27346edf24e7b2382f67:

  Merge tag 'cris-for-3.12' of git://jni.nu/cris (2013-09-10 14:55:16 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 363edbe2614aa90df706c0f19ccfa2a6c06af0be:

  powerpc: Default arch idle could cede processor on pseries (2013-09-11 11:41:54 +1000)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc: Fix possible deadlock on page fault

Guenter Roeck (1):
      powerpc: Export cpu_to_chip_id() to fix build error

Vaidyanathan Srinivasan (1):
      powerpc: Default arch idle could cede processor on pseries

Vladimir Murzin (2):
      powerpc: Fix section mismatch warning for prom_rtas_call
      fbdev/ps3fb: Fix section mismatch warning for ps3fb_probe

 arch/powerpc/kernel/prom_init.c        |  3 ++-
 arch/powerpc/kernel/smp.c              |  1 +
 arch/powerpc/mm/fault.c                | 13 ++++++++++---
 arch/powerpc/platforms/pseries/setup.c | 31 +++++++++++++++++++++----------
 drivers/video/ps3fb.c                  |  2 +-
 5 files changed, 35 insertions(+), 15 deletions(-)
