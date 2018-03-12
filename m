Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4005323fD1zDrD9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 15:43:23 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id m22-v6so8706332pls.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 21:43:23 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, mahesh@linux.vnet.ibm.com,
 cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com, paulus@ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au
Subject: [PATCHv4 0/3] enable nr_cpus for powerpc
Date: Mon, 12 Mar 2018 12:43:07 +0800
Message-Id: <1520829790-14029-1-git-send-email-kernelfans@gmail.com>
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
In this series, I separate and change the mapping between cpu logical id and hwid.
I hope we can acquire it for "kexec -p"

Mahesh Salgaonkar (1):
  ppc64 boot: Wait for boot cpu to show up if nr_cpus limit is about to
    hit.

Pingfan Liu (2):
  powerpc, cpu: partially unbind the mapping between cpu logical id and 
       its seq in dt
  powerpc, cpu: handling the special case when boot_cpuid greater than
    nr_cpus

 arch/powerpc/include/asm/paca.h    |  3 +++
 arch/powerpc/include/asm/smp.h     |  1 +
 arch/powerpc/kernel/paca.c         | 19 ++++++++++++++-----
 arch/powerpc/kernel/prom.c         | 25 ++++++++++++++-----------
 arch/powerpc/kernel/setup-common.c | 35 +++++++++++++++++++++++++++++++++--
 5 files changed, 65 insertions(+), 18 deletions(-)

-- 
2.7.4
