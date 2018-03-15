Return-Path: <kernelfans@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401wt628qQzF12j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 15:42:05 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id j2so2392726pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 21:42:05 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com,
 kexec@lists.infradead.org, paulus@ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Subject: [PATCHv5 0/3] enable nr_cpus for powerpc
Date: Thu, 15 Mar 2018 12:41:49 +0800
Message-Id: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This topic has a very long history. It comes from Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
For v3: https://patchwork.ozlabs.org/patch/834860/
I hope we can acquire it for "kexec -p" soon.

V4->V5:
  improve the [1/3] implementation based on Benjamin's suggestion.

Mahesh Salgaonkar (1):
  ppc64 boot: Wait for boot cpu to show up if nr_cpus limit is about to
    hit.

Pingfan Liu (2):
  powerpc, cpu: partially unbind the mapping between cpu logical id and 
       its seq in dt
  powerpc, cpu: handling the special case when boot_cpuid greater than
    nr_cpus

 arch/powerpc/include/asm/paca.h    |  3 +++
 arch/powerpc/include/asm/smp.h     |  2 ++
 arch/powerpc/kernel/paca.c         | 19 ++++++++++++++-----
 arch/powerpc/kernel/prom.c         | 27 ++++++++++++++++-----------
 arch/powerpc/kernel/setup-common.c | 35 ++++++++++++++++++++++++++++++++---
 5 files changed, 67 insertions(+), 19 deletions(-)

-- 
2.7.4
