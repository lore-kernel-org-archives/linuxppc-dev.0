Return-Path: <kernelfans@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421rck6ylZzF38S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 17:30:46 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id j8-v6so5051841pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 00:30:46 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH 0/2] powerpc/kexec: automatically allocating mem for
 crashkernel=Y
Date: Fri, 31 Aug 2018 15:30:21 +0800
Message-Id: <1535700623-23750-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If no start address is specified for crashkernel, the current program hard
code as: crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
This limits the candidate memory region, and may cause failure while there
is enough mem for crashkernel. This patch suggests to find a suitable mem
chunk by memblock_find_in_range()

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>

Pingfan Liu (2):
  powerpc/prom: move mmu_early_init_devtree() before    
    early_init_dt_scan_cpus()
  powerpc/kexec: avoid hard coding when automatically allocating mem for
        crashkernel

 arch/powerpc/kernel/machine_kexec.c | 24 +++++++++++++++---------
 arch/powerpc/kernel/prom.c          | 10 ++++++----
 2 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.7.4
