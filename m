Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 081881A0427
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 01:41:56 +1100 (AEDT)
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: sparclinux@vger.kernel.org
Subject: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Date: Tue, 31 Mar 2015 10:40:43 -0400
Message-Id: <cover.1427761300.git.sowmini.varadhan@oracle.com>
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

Addresses BenH comments with one exception: I've left the
IOMMU_POOL_HASH as is, so that powerpc can tailor it to their
convenience. 

I've not heard back from the IB folks, but I'm going to make
a judgement call here and go with the spin_lock. *If* they
report some significant benefit from the trylock, probably 
need to revisit this (and then probably start by re-exmaining
the hash function to avoid collisions, before resorting to 
trylock).

Sowmini Varadhan (3):
  Break up monolithic iommu table/lock into finer graularity pools and
    lock
  Make sparc64 use scalable lib/iommu-common.c functions
  Make LDC use common iommu poll management functions

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  171 +++++++--------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/ldc.c           |  153 ++++++++++--------------
 arch/sparc/kernel/pci_sun4v.c     |  181 +++++++++++++----------------
 include/linux/iommu-common.h      |   48 ++++++++
 lib/Makefile                      |    2 +-
 lib/iommu-common.c                |  233 +++++++++++++++++++++++++++++++++++++
 8 files changed, 472 insertions(+), 331 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c
