Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FD561A0338
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 05:05:31 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 951ED1400D2
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:05:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 17 Dec 2014 04:05:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 801423578056
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:05:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBGI5P9I29753404
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:05:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBGI5OMX021340
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:05:25 +1100
Subject: [PATCH v2 0/3] powerpc/pstore: Add pstore support for nvram partitions
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Dec 2014 23:35:11 +0530
Message-ID: <20141216180442.7778.38272.stgit@localhost.localdomain>
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
platforms.

---

Hari Bathini (3):
      powerpc/nvram: move generic code for nvram and pstore
      pstore: Add pstore type id for firmware partition
      pstore: add pstore support on powernv


 arch/powerpc/include/asm/nvram.h            |   50 ++
 arch/powerpc/include/asm/rtas.h             |    2 
 arch/powerpc/kernel/nvram_64.c              |  681 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-nvram.c |   10 
 arch/powerpc/platforms/pseries/nvram.c      |  665 --------------------------
 fs/pstore/inode.c                           |    3 
 include/linux/pstore.h                      |    1 
 7 files changed, 751 insertions(+), 661 deletions(-)

--
- Hari
