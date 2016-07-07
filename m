Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcm839cpzDqyh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:45:28 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67ChhgK018915
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 08:45:26 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmtcnh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 08:45:25 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 09:45:23 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 055321DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 08:45:09 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u67CjGMY32375246
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 09:45:16 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u67CjFX8016408
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 09:45:16 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 0/3] dma, nvme,
 powerpc: introduce and implement DMA_ATTR_NO_WARN
Date: Thu,  7 Jul 2016 09:45:06 -0300
Message-Id: <1467895509-12194-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset introduces dma_attr DMA_ATTR_NO_WARN (just like __GFP_NOWARN),
which tells the DMA-mapping subsystem to suppress allocation failure reports.

On some architectures allocation failures are reported with error messages
to the system logs.  Although this can help to identify and debug problems,
drivers which handle failures (eg, retry later) have no problems with them,
and can actually flood the system logs with error messages that aren't any
problem at all, depending on the implementation of the retry mechanism.

So, this provides a way for drivers to avoid those error messages on calls
where allocation failures are not a problem, and shouldn't bother the logs.

 - Patch 1/3 introduces and documents the new dma_attr.

 - Patch 2/3 implements it on the nvme driver (which might repeatedly trip
             on allocation failures due to high load, flooding system logs
             with error messages at least on powerpc: "iommu_alloc failed")

 - Patch 3/3 implements support for it on powerpc arch (where this problem
             was observed.  It's possible to extend support for more archs
             if the patchset is welcome).

Changelog:
 v2:
  - address warnings from checkpatch.pl (line wrapping and typos)

Mauricio Faria de Oliveira (3):
  dma: introduce DMA_ATTR_NO_WARN
  nvme: implement DMA_ATTR_NO_WARN
  powerpc: implement DMA_ATTR_NO_WARN

 Documentation/DMA-attributes.txt | 17 +++++++++++++++++
 arch/powerpc/kernel/iommu.c      |  6 ++++--
 drivers/nvme/host/pci.c          | 12 ++++++++++--
 include/linux/dma-attrs.h        |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)

-- 
1.8.3.1
