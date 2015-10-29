Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 721E31A0BE3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 10:40:57 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B6808140E6F
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2015 10:40:56 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 29 Oct 2015 17:40:54 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AD67619D803F
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2015 17:29:01 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9TNeqqu9634208
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2015 16:40:52 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9TNepgF003140
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2015 17:40:51 -0600
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 0/2] Increase number of supported IPI messages
Date: Thu, 29 Oct 2015 18:40:43 -0500
Message-Id: <1446162045-26496-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a H_IPI hypercall is made, we often need to switch to the 
host to poke the VCPU to which the virtual IPI is targeted. 
This is because we cannot do a thread wake-up in real mode in 
the guest. Peformance tests have shown that this is impacting
several different workloads - from MongoDB to small message
networking.

One solution is to hand off this job of waking the VCPU to a CPU
that is running in the host by sending it a message through the 
IPI mechanism from the guest. 

Currently, we only support 4 IPI messages and all 4 are already 
used for other purposes. This patch set increases the number
of supported IPI messages to 8. It also provides the code to
send an IPI from KVM real-mode since the existing cause_ipi
functions cannot be executed in real-mode.

There is an associated patch set for "KVM: PPC: Book3S HV" 
that implements the actual solution to avoid the switch to
host to do the VCPU wakeup. 

Suresh Warrier (2):
  powerpc/smp: Support more IPI messages
  powerpc/smp: Add smp_muxed_ipi_rm_message_pass

 arch/powerpc/include/asm/smp.h |  4 ++++
 arch/powerpc/kernel/smp.c      | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

-- 
1.8.3.4
