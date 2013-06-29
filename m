Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 18CB92C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 09:16:58 +1000 (EST)
Message-ID: <1372547811.18612.82.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Jun 2013 09:16:51 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

We discovered some breakage in our "EEH" (PCI Error Handling) code while
doing error injection, due to a couple of regressions. One of them is
due to a patch (37f02195b) that, in hindsight, I shouldn't have merged
considering that it caused more problems than it solved.

Please pull those two fixes. One for a simple EEH address cache
initialization issue. The other one is a patch from Guenter that I had
originally planned to put in 3.11 but which happens to also fix that
other regression (a kernel oops during EEH error handling and possibly
hotplug).

With those two, the couple of test machines I've hammered with error
injection are remaining up now. EEH appears to still fail to recover on
some devices, so there is another problem that Gavin is looking into but
at least it's no longer crashing the kernel.

Cheers,
Ben.

The following changes since commit b37e161388ac3980d5dfb73050e85874b84253eb:

  powerpc/pci: Fix boot panic on mpc83xx (regression) (2013-06-24 16:54:09 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 7846de406f43df98ac9864212dcfe3f2816bdb04:

  powerpc/pci: Improve device hotplug initialization (2013-06-30 08:46:46 +1000)

----------------------------------------------------------------
Guenter Roeck (1):
      powerpc/pci: Improve device hotplug initialization

Thadeu Lima de Souza Cascardo (1):
      powerpc/eeh: Add eeh_dev to the cache during boot

 arch/powerpc/kernel/pci-common.c           |   17 ++++++++++++-----
 arch/powerpc/platforms/pseries/eeh_cache.c |    4 ++--
 2 files changed, 14 insertions(+), 7 deletions(-)
