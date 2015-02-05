Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 841B81A0FFF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 06:36:36 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 540081401DD
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 06:36:36 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 Feb 2015 05:36:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7D9772CE8040
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 06:36:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t15JaOOE26476668
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 06:36:32 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t15JZwG6020231
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 06:35:58 +1100
Subject: [PATCH v5 0/4] powerpc/pstore: Add pstore support for nvram partitions
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Anton Vorontsov <anton@enomsg.org>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Colin Cross <ccross@android.com>
Date: Fri, 06 Feb 2015 01:05:39 +0530
Message-ID: <20150205193412.24669.8648.stgit@localhost.localdomain>
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

Changes from v4:
1. Added a patch for y2038-safe code changes

---

Hari Bathini (4):
      powerpc/nvram: move generic code for nvram and pstore
      pstore: Add pstore type id for PPC64 opal nvram partition
      pstore: add pstore support on powernv
      powerpc: make timestamp related code y2038-safe


 arch/powerpc/include/asm/nvram.h            |   50 ++
 arch/powerpc/include/asm/rtas.h             |    5 
 arch/powerpc/kernel/nvram_64.c              |  677 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-nvram.c |   10 
 arch/powerpc/platforms/pseries/nvram.c      |  673 ---------------------------
 fs/pstore/inode.c                           |    3 
 include/linux/pstore.h                      |    1 
 7 files changed, 754 insertions(+), 665 deletions(-)

--
-Hari
