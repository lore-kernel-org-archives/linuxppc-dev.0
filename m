Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5950E1A0EB8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 02:14:33 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1292014017D
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:14:33 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 31 Jan 2015 01:14:32 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 663E12CE8050
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:14:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0UFEBqb48169128
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:14:20 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0UFDsLp019468
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:13:54 +1100
Subject: [PATCH v4 0/3] powerpc/pstore: Add pstore support for nvram partitions
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 30 Jan 2015 20:43:36 +0530
Message-ID: <20150130151247.13976.88337.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds pstore support on powernv platform to
read different nvram partitions and write compressed data to
oops-log nvram partition. As pseries platform already has
pstore support, this series moves most of the common code
for pseries and powernv platforms to a common file. Tested
the patches successfully on both pseries and powernv
platforms. Also, tested the patches successfully, on a kernel
compiled with both CONFIG_PPC_PSERIES=y & CONFIG_PPC_POWERNV=y.

Changes from v3:
1. Updated the changelog
2. Resolved compile issues with !CONFIG_PPC_PSERIES

---

Hari Bathini (3):
      powerpc/nvram: move generic code for nvram and pstore
      pstore: Add pstore type id for PPC64 opal nvram partition
      pstore: add pstore support on powernv


 arch/powerpc/include/asm/nvram.h            |   50 ++
 arch/powerpc/include/asm/rtas.h             |    4 
 arch/powerpc/kernel/nvram_64.c              |  677 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-nvram.c |   10 
 arch/powerpc/platforms/pseries/nvram.c      |  665 ---------------------------
 fs/pstore/inode.c                           |    3 
 include/linux/pstore.h                      |    1 
 7 files changed, 749 insertions(+), 661 deletions(-)

--
- Hari
