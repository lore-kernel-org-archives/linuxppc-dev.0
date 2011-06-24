Return-Path: <nacc@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2E6CB6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jun 2011 05:05:58 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5OIvLPL007473
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2011 12:57:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5OJ5TUF175850
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2011 13:05:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5OD51W6017605
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2011 07:05:02 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: [PATCH 0/4] pseries/iommu bug-fixes and cleanups for dynamic dma
	windows
Date: Fri, 24 Jun 2011 12:05:21 -0700
Message-Id: <1308942325-4813-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In my last submission, 5/8 wasn't sent to Ben, so he only picked up 1-4.
Re-sending 5-8, as such.

Milton Miller (4):
  powerpc: override dma_get_required_mask by platform hook and ops
  dma-mapping: add get_required_mask if arch overrides default
  powerpc: use the newly added get_required_mask dma_map_ops hook
  powerpc: tidy up dma_map_ops after adding new hook

Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org

 arch/powerpc/include/asm/device.h       |    2 +
 arch/powerpc/include/asm/machdep.h      |    3 +-
 arch/powerpc/kernel/dma-iommu.c         |   28 ++++++++++++++-----
 arch/powerpc/kernel/dma-swiotlb.c       |   16 +++++++++++
 arch/powerpc/kernel/dma.c               |   44 ++++++++++++++++++++++++++-----
 arch/powerpc/kernel/ibmebus.c           |   22 ++++++++++-----
 arch/powerpc/kernel/vio.c               |   21 +++++++++-----
 arch/powerpc/platforms/cell/iommu.c     |   21 ++++++++++++++
 arch/powerpc/platforms/ps3/system-bus.c |    7 +++++
 arch/powerpc/platforms/pseries/iommu.c  |   27 +++++++++++++++++++
 include/linux/dma-mapping.h             |    3 ++
 11 files changed, 163 insertions(+), 31 deletions(-)

-- 
1.7.4.1
