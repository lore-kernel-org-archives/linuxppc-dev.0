Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3FKj6hlMzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 09:05:13 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71N484q136838
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 19:05:12 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grracqa1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 19:05:11 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 20:05:09 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9EFDA352006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 19:04:47 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71N57sx4059168
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71N56uW023861
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/3] dma-mapping, powerpc,
 nvme: introduce the DMA_ATTR_NO_WARN attribute
Date: Mon,  1 Aug 2016 20:05:03 -0300
Message-Id: <1470092706-28075-1-git-send-email-mauricfo@linux.vnet.ibm.com>
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

 - Patch 1/3 introduces the dma_attr DMA_ATTR_NO_WARN.

 - Patch 2/3 implements support for it on powerpc arch (where this problem
             was observed;  it's possible to extend support for more archs)

 - Patch 3/3 implements it on the nvme driver (which might repeatedly trip
             on allocation failures due to high load, flooding system logs
             with error messages at least on powerpc: "iommu_alloc failed")

Changelog:
 v4:
  - rebase for commit 53a4b60 dma-mapping: use unsigned long for dma_attrs.
  - reorder patches 2/3 and 3/3.
 v3:
  - nvme: use DMA_ATTR_NO_WARN when ret = BLK_MQ_RQ_QUEUE_BUSY (io will be
    requeued) but not when ret = BLK_MQ_RQ_QUEUE_ERROR (io will be failed).
    thanks: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
 v2:
  - all: address warnings from checkpatch.pl (line wrapping and typos)

Tested on next-20160801.

Mauricio Faria de Oliveira (3):
  dma-mapping: introduce the DMA_ATTR_NO_WARN attribute
  powerpc: implement the DMA_ATTR_NO_WARN attribute
  nvme: use the DMA_ATTR_NO_WARN attribute

 Documentation/DMA-attributes.txt | 17 +++++++++++++++++
 arch/powerpc/kernel/iommu.c      |  6 ++++--
 drivers/nvme/host/pci.c          |  3 ++-
 include/linux/dma-mapping.h      |  5 +++++
 4 files changed, 28 insertions(+), 3 deletions(-)

-- 
1.8.3.1
