Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D74271A09EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 23:18:57 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 17:48:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 940A2125804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:49:02 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARCJOWc54460452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:49:24 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARCIm92013178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:48:48 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [RFC PATCH 0/2] powerpc: CR based local atomic operation
 implementation
Date: Thu, 27 Nov 2014 17:48:39 +0530
Message-Id: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, rusty@rustcorp.com.au,
 paulus@samba.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset create the infrastructure to handle the CR based
local_* atomic operations. Local atomic operations are fast
and highly reentrant per CPU counters.  Used for percpu
variable updates. Local atomic operations only guarantee
variable modification atomicity wrt the CPU which owns the
data and these needs to be executed in a preemption safe way.

Here is the design of the first patch. Since local_* operations
are only need to be atomic to interrupts (IIUC), patch uses
one of the Condition Register (CR) fields as a flag variable. When
entering the local_*, specific bit in the CR5 field is set
and on exit, bit is cleared. CR bit checking is done in the
interrupt return path. If CR5[EQ] bit set and if we return
to kernel, we reset to start of local_* operation.

Reason for this approach is that, currently l[w/d]arx/st[w/d]cx.
instruction pair is used for local_* operations, which are heavy
on cycle count and they dont support a local varient.  So to
see whether the new implementation helps, Used a modified
version of Rusty's benchmark code on local_t. Have the 
performance numbers in the patch commit message.

Second patch has the rewrite of the local_* functions to use
CR5 based logic. Changes are mostly in asm/local.h and only for
CONFIG_PPC64


Madhavan Srinivasan (2):
 powerpc: foundation code to handle CR5 for local_t
 powerpc: rewrite local_* to use CR5 flag

 Makefile                                 |   6 +
 arch/powerpc/include/asm/exception-64s.h |  21 ++-
 arch/powerpc/include/asm/local.h         | 306 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/entry_64.S           | 106 ++++++++++-
 arch/powerpc/kernel/exceptions-64s.S     |   2 +-
 arch/powerpc/kernel/head_64.S            |   8 +
 6 files changed, 444 insertions(+), 5 deletions(-)

-- 
1.9.1
