Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5544B6EEC
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2011 10:56:26 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Mar 2011 10:55:45 +1100
Message-ID: <1299714945.22236.444.camel@pasglop>
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

Here's a pair of regression fixes for 2.6.38. One fixes a 2.6.37
regression (I'll send it to -stable separately) that breaks booting on
legacy iSeries, and the other one disables a newly introduced features
as it triggers nasty races in the scheduler that causes hangs and seem
to be too much to fix for this release (working with PeterZ on it).

Cheers,
Ben.

The following changes since commit a5abba989deceb731047425812d268daf7536575:

  Linux 2.6.38-rc8 (2011-03-07 21:09:37 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (2):
      powerpc/iseries: Fix early init access to lppaca
      powerpc/pseries: Disable VPNH feature

 arch/powerpc/include/asm/lppaca.h      |   16 ++++++++++++++++
 arch/powerpc/kernel/paca.c             |   14 --------------
 arch/powerpc/mm/numa.c                 |    3 ++-
 arch/powerpc/platforms/iseries/dt.c    |    6 +++---
 arch/powerpc/platforms/iseries/setup.c |    1 +
 5 files changed, 22 insertions(+), 18 deletions(-)
