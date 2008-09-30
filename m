Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05F0CDDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 13:38:16 +1000 (EST)
Subject: Please pull 'merge' branch of "deputy" powerpc.git tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 13:38:03 +1000
Message-Id: <1222745883.9006.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

The following changes since commit 94aca1dac6f6d21f4b07e4864baf7768cabcc6e7:
  Linus Torvalds (1):
        Linux 2.6.27-rc8

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Those are two fixes for regressions introduced recently, the first
one due to some change in the timer code becoming more sensitive to
timer interrupts taken from offlined CPUs and the second is an update
to a board device-tree to fix some address translation problems.

 arch/powerpc/boot/dts/holly.dts |  106 +++++++++++++++++++-------------------
 arch/powerpc/kernel/idle.c      |    6 +--
 2 files changed, 54 insertions(+), 58 deletions(-)

(Oh and please let me know what I screwed up this time :-)

commit 61e9916eba35dfb76d38013a5aae9a59cc50877a
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Wed Sep 24 22:56:25 2008 +0000

    powerpc: Fix failure to shutdown with CPU hotplug
    
    I tracked down the shutdown regression to CPUs not dying
    when being shut down during power-off. This turns out to
    be due to the system_state being SYSTEM_POWER_OFF, which
    this code doesn't take as a valid state for shutting off
    CPUs in.
    
    This has never made sense to me, but when I added hotplug
    code to implement hibernate I only "made it work" and did
    not question the need to check the system_state. Thomas
    Gleixner helped me dig, but the only thing we found is
    that it was added with the original commit that added CPU
    hotplug support.
    
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Acked-by: Joel Schopp <jschopp@austin.ibm.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit ad611045ce5d059af84a9855b22ca3f7a99d47be
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Wed Sep 24 16:39:04 2008 +0000

    powerpc: Fix PCI in Holly device tree
    
    The PCI bridge on the Holly board is incorrectly represented in the
    device tree.  The current device tree node for the PCI bridge sits
    under the tsi-bridge node.  That's not obviously wrong, but the PCI
    bridge translates some PCI spaces into CPU address ranges which were
    not translated by the "ranges" property in tsi-bridge node.
    
    We used to get away with this problem because the PCI bridge discovery
    code was also buggy, assuming incorrectly that PCI host bridge nodes
    were always directly under the root bus and treating the translated
    addresses as raw CPU addresses, rather than parent bus addresses.
    This has since been fixed, thus breaking Holly.
    
    This could be fixed by adding extra translations to the tsi-bridge
    node, but this patch instead moves the Holly PCI bridge out of the
    tsi-bridge node to the root bus.  This makes the tsi-bridge node
    represent only the built-in IO devices in the bridge, with a
    more-or-less contiguous address range.  This is the same convention
    used on Freescale SoC chips, where the "soc" node represents only the
    IMMR region, and the PCI and other bus bridges are separate nodes
    under the root bus.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
