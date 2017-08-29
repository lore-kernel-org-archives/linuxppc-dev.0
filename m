Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhjhS5FVqzDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 08:18:32 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TMF7dS052575
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 18:18:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cn9fyx4pg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 18:18:30 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 18:18:29 -0400
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, agraf@suse.com, mpe@ellerman.id.au
Subject: [PATCH RFC] powerpc: Implements MMIO emulation for lvx/stvx
 instructions
Date: Tue, 29 Aug 2017 19:18:01 -0300
Message-Id: <1504045082-16178-1-git-send-email-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

This patch implements MMIO emulation for two instructions: lvx and stvx. I started to implement other instructions but I'd like to have this reviewed beforehand because this is my first patch here and I'll certainly have some rework/fixes :-).

Note: stvx is only storing 8 bytes, for some reason the code "vcpu->arch.paddr_accessed += run->mmio.len;", which adds the 8-byte offset after the first write is not making any difference (interesting that it works for load operations). I'm still investigating it but any idea about it will be appreciated.

Thank you very much,

Jose Ricardo Ziviani (1):
  KVM: PPC: Book3S: Add MMIO emulation for VMX instructions

 arch/powerpc/include/asm/kvm_host.h   |   2 +
 arch/powerpc/include/asm/kvm_ppc.h    |   4 +
 arch/powerpc/include/asm/ppc-opcode.h |   6 ++
 arch/powerpc/kvm/emulate_loadstore.c  |  32 +++++++
 arch/powerpc/kvm/powerpc.c            | 162 ++++++++++++++++++++++++++++++----
 5 files changed, 189 insertions(+), 17 deletions(-)

-- 
2.7.4
