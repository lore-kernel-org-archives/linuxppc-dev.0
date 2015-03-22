Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53FC61A2AA8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 06:24:19 +1100 (AEDT)
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 RFC 0/3] Generic IOMMU pooled allocator
Date: Sun, 22 Mar 2015 15:22:51 -0400
Message-Id: <cover.1426986386.git.sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sowmini.varadhan@oracle.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Follows up on the feedback in the thread at
  http://www.spinics.net/lists/sparclinux/msg13493.html

- removed ->cookie_to_index and ->demap indirection from the iommu_tbl_ops
  The caller needs to call these functions as needed, before invoking
  the generic arena allocator functions.

- added the "skip_span_boundary" argument to iommu_tbl_pool_init() for
  those callers like LDC which do no care about span boundary checks.


Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

Sowmini Varadhan (1):
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  187 +++++++++++---------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  172 ++++++++++++++---------------
 arch/sparc/kernel/pci_sun4v.c     |  194 ++++++++++++++++-----------------
 include/linux/iommu-common.h      |   55 +++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  219 +++++++++++++++++++++++++++++++++++++
 8 files changed, 519 insertions(+), 325 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c
