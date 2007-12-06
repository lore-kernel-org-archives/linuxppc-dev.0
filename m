Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 77B49DDF6D
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:52 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 5408D368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:52 +1100 (EST)
Date: Thu, 6 Dec 2007 18:00:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Powerpc PCI cleanups (mainly iSeries)
Message-Id: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I started out looking for ways to remove our dependencies on pci_dn and
got sidetracked into clening up the iSeries PCI code.  The intention of
the following set of patches is that there be no semantic changes
(mostly).

Overall diffstat looks like this:
 arch/powerpc/kernel/pci-common.c           |   31 +--
 arch/powerpc/kernel/pci_32.c               |    6 +-
 arch/powerpc/kernel/pci_64.c               |   40 +--
 arch/powerpc/kernel/pci_dn.c               |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
 arch/powerpc/platforms/iseries/pci.c       |  426 +++++++++++-----------------
 arch/powerpc/platforms/iseries/pci.h       |   20 +-
 arch/powerpc/platforms/iseries/setup.c     |    2 +
 arch/powerpc/platforms/iseries/vpdinfo.c   |   17 +-
 arch/powerpc/platforms/powermac/pci.c      |    2 +-
 arch/powerpc/platforms/pseries/iommu.c     |    2 +-
 include/asm-powerpc/pci-bridge.h           |  156 ++++------
 include/asm-powerpc/ppc-pci.h              |    3 -
 14 files changed, 266 insertions(+), 445 deletions(-)

This entire set sits on top of benh's "Make isa_mem_base common to 32 and
64 bits" and "Merge pci_process_bridge_OF_ranges" patches and my
"iommu_free_table doesn't need the device_node" and "pSeries: remove
dependency on pci_dn bussubno" patches posted earlier.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
