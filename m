Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0D1C1A0270
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 04:35:11 +1100 (AEDT)
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: sparclinux@vger.kernel.org
Subject: [PATCH v7 0/3] Generic IOMMU pooled allocator
Date: Wed, 25 Mar 2015 13:34:45 -0400
Message-Id: <cover.1427295804.git.sowmini.varadhan@oracle.com>
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


Changes from patchv6: moved pool_hash initialization to
lib/iommu-common.c and cleaned up code duplication from 
sun4v/sun4u/ldc. 

Sowmini (2):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions

Sowmini Varadhan (1):
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  174 +++++++--------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  152 ++++++++++--------------
 arch/sparc/kernel/pci_sun4v.c     |  179 +++++++++++++----------------
 include/linux/iommu-common.h      |   48 ++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  235 +++++++++++++++++++++++++++++++++++++
 8 files changed, 475 insertions(+), 330 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c
