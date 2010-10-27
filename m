Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2226AB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 14:35:58 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9R3PsL3002818
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:25:54 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9R3ZhcQ148204
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:35:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9R3Zh4Q003408
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:35:43 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 0/7 v2] ppc: enable dynamic dma window support
Date: Tue, 26 Oct 2010 20:35:10 -0700
Message-Id: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series, which builds upon the series of cleanups I posted
on 9/15 and 10/18 as "ppc iommu cleanups", enables the pseries firmware
feature dynamic dma windows. This feature will allow future devices to
have a 64-bit DMA mapping covering all memory, coexisting with a smaller
IOMMU window in 32-bit PCI space

Changes from v1 to v2:

Fixed numerous bugs/issues found in testing.
Reworked to be based off platform hook dma_set_mask().

Nishanth Aravamudan (7):
  macio: ensure all dma routines get copied over
  ppc: add memory_hotplug_max
  ppc: do not search for dma-window property on dlpar remove
  ppc: checking for pdn->parent is redundant
  ppc/iommu: do not need to check for dma_window == NULL
  ppc/iommu: pass phb only to iommu_table_setparms_lpar
  ppc: add dynamic dma window support

 arch/powerpc/include/asm/device.h      |    6 +
 arch/powerpc/include/asm/mmzone.h      |    5 +
 arch/powerpc/mm/numa.c                 |   26 ++
 arch/powerpc/platforms/pseries/iommu.c |  600 ++++++++++++++++++++++++++++++--
 drivers/macintosh/macio_asic.c         |    7 +-
 5 files changed, 619 insertions(+), 25 deletions(-)
