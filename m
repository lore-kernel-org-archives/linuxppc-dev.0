Return-Path: <nacc@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3EED2B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:13:19 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHsMM9003267
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 13:54:22 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FIDGiH364450
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:13:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8FIDFVo026421
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 15:13:15 -0300
Received: from arkanoid.localdomain (sig-9-65-116-150.mts.ibm.com
	[9.65.116.150])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o8FIDEiE026339
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 15:13:15 -0300
Date: Wed, 15 Sep 2010 11:13:07 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [nacc@us.ibm.com: [PATCH 00/15] ppc iommu cleanups]
Message-ID: <20100915181307.GA3683@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Clearly need to work on my git-send-mail usage! Apologies...

----- Forwarded message from Nishanth Aravamudan <nacc@us.ibm.com> -----

Date: Wed, 15 Sep 2010 11:05:43 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 00/15] ppc iommu cleanups

While working on some upcoming IOMMU-related changes, we found the
following cleanups throughout the ppc code.

Nishanth Aravamudan (15):
  ppc: fix return type of BUID_{HI,LO} macros
  ppc64: fix dma_iommu_dma_supported compare
  ppc64 iommu: fix check for direct DMA support
  vio: put device on device_register failure
  viobus: free TCE table on device release
  pseries/dlpar: use kmemdup
  ppc: pci-common cleanup
  microblaze: pci-common cleanup
  ppc/vio: use dma ops helpers
  ppc/pasemi: clean up pasemi iommu table initializations
  ppc/cell: beat dma ops cleanup
  ppc/dart: iommu table cleanup
  ppc/pseries: iommu cleanup
  ppc64 iommu: use coherent_dma_mask for alloc_coherent
  ppc/vio: ensure dma_coherent_mask is set

 arch/microblaze/pci/pci-common.c         |    6 ++----
 arch/powerpc/include/asm/ppc-pci.h       |    4 ++--
 arch/powerpc/kernel/dma-iommu.c          |   23 ++++++++++++-----------
 arch/powerpc/kernel/dma.c                |    2 +-
 arch/powerpc/kernel/pci-common.c         |    4 +---
 arch/powerpc/kernel/vio.c                |   24 ++++++++++++++++++------
 arch/powerpc/platforms/cell/beat_iommu.c |    3 +--
 arch/powerpc/platforms/pasemi/iommu.c    |   19 +------------------
 arch/powerpc/platforms/pseries/dlpar.c   |    3 +--
 arch/powerpc/platforms/pseries/iommu.c   |    9 ++-------
 arch/powerpc/sysdev/dart_iommu.c         |   18 +-----------------
 11 files changed, 42 insertions(+), 73 deletions(-)

---

I used git-send-email for this series, and noticed that
get_maintainer.pl will always pull in LKML to the Cc because of the
following in MAINTAINERS:

THE REST
M:	Linus Torvalds <torvalds@linux-foundation.org>
L:	linux-kernel@vger.kernel.org
Q:	http://patchwork.kernel.org/project/LKML/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
S:	Buried alive in reporters
F:	*
F:	*/

Is there any way to exclude that in the script that anyone knows of? Or
am I mis-using the script (as the --cc-cmd option to git-send-email).

Thanks,
Nish

----- End forwarded message -----

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
