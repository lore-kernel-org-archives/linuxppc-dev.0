Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C12651A0279
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 05:11:07 +1100 (AEDT)
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: sparclinux@vger.kernel.org
Subject: [PATCH v6 0/3] Generic IOMMU pooled allocator
Date: Tue, 24 Mar 2015 13:10:27 -0400
Message-Id: <cover.1427210772.git.sowmini.varadhan@oracle.com>
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

Deltas from patchv5:
- removed iommu_tbl_ops, and instead pass the ->flush_all as
  an indirection to iommu_tbl_pool_init()
- only invoke ->flush_all when there is no large_pool, based on
  the assumption that large-pool usage is infrequently encountered.

Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

Sowmini Varadhan (1):
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  182 ++++++++++---------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  169 ++++++++++++++---------------
 arch/sparc/kernel/pci_sun4v.c     |  192 ++++++++++++++++-----------------
 include/linux/iommu-common.h      |   49 ++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  219 +++++++++++++++++++++++++++++++++++++
 8 files changed, 503 insertions(+), 325 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c
