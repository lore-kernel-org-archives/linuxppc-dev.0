Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQdJH3SjszDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 02:12:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9UF7gjq022788
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 11:12:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dx4ur8ptp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 11:12:27 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 30 Oct 2017 15:12:25 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] Fix function_graph tracer for ppc64 BE
Date: Mon, 30 Oct 2017 20:42:07 +0530
Message-Id: <cover.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chandan reported that trying to enable function_graph tracer on ppc64 BE 
now locks up the system. This is due to prepare_ftrace_return() using 
ppc_function_entry() for resolving return_to_handler(), which in turn 
invokes kernel_text_address(), which also gets traced resulting in a 
loop.

We added a check for kernel_text_address() in ppc_function_entry() to 
guard all users in case we were called with a function, rather than a 
function descriptor. In hindsight, I feel that this is inefficient since 
we usually only pass function descriptors to ppc_function_entry() (and 
ppc_global_function_entry()). So, I am proposing that we revert the 
previous patch and instead implement the necessary checks in the kprobes 
subsystem.

The other way to fix this is to simply guard the call to 
kernel_text_address() within [un]pause_graph_tracing(), if you think 
it's useful to have the check in ppc_function_entry() for all users.


- Naveen

Naveen N. Rao (2):
  Revert "powerpc64/elfv1: Only dereference function descriptor for
    non-text symbols"
  powerpc/kprobes: Dereference function pointers only if the address
    does not belong to kernel text

 arch/powerpc/include/asm/code-patching.h | 10 +---------
 arch/powerpc/kernel/kprobes.c            |  7 ++++++-
 2 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.14.2
