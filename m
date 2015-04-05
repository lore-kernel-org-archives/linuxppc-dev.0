Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 554A91A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Apr 2015 21:50:06 +1000 (AEST)
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: sparclinux@vger.kernel.org
Subject: [PATCH v9 RFC 0/3] Generic IOMMU pooled allocator
Date: Sun,  5 Apr 2015 07:49:39 -0400
Message-Id: <cover.1428181553.git.sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Addresses latest BenH comments: need_flush checks, add support
for dma mask and align_order. 

Sowmini Varadhan (3):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  172 ++++++------------------
 arch/sparc/kernel/iommu_common.h  |    8 -
 arch/sparc/kernel/ldc.c           |  153 +++++++++------------
 arch/sparc/kernel/pci_sun4v.c     |  183 ++++++++++++--------------
 include/linux/iommu-common.h      |   51 +++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  266 +++++++++++++++++++++++++++++++++++++
 8 files changed, 511 insertions(+), 331 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c
