Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406N9R3W9DzF1qQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 21:25:46 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MAOhaC094479
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:25:44 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gv9bqbv9p-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:25:44 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 10:25:40 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: [PATCH v3 0/6] powerpc64/ftrace: Add support for ftrace_modify_call()
 and a few other fixes
Date: Thu, 22 Mar 2018 15:55:20 +0530
Message-Id: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v3 of the patches posted at:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg130652.html

This series has been tested using mambo for p8 (hash) and p9 (radix).


The first two patches fix a kernel oops when function tracing is enabled 
while using KVM.

Patch 3 is new and changes how ftrace is disabled before kexec.

Patch 4 tightens how we detect _mcount() call sites for -mprofile-kernel 
during module loading.

The last two patches implement support for ftrace_caller() to 
conditionally save the register state. This speeds up the function 
tracer a bit. The existing ftrace_caller() is renamed to 
ftrace_regs_caller() since we save the entire pt_regs today. A new 
implementation of ftrace_caller() that saves the minimum register state 
is provided. We switch between the two variants through 
ftrace_modify_call(). The necessary support to call into the two 
different variants from modules is also added.


- Naveen


Naveen N. Rao (6):
  powerpc64/ftrace: Add a field in paca to disable ftrace in unsafe code
    paths
  powerpc64/ftrace: Disable ftrace during kvm guest entry/exit
  powerpc/kexec: Disable ftrace before switching to the new kernel
  powerpc64/module: Tighten detection of mcount call sites with
    -mprofile-kernel
  powerpc64/ftrace: Use the generic version of ftrace_replace_code()
  powerpc64/ftrace: Implement support for ftrace_regs_caller()

 arch/powerpc/include/asm/ftrace.h              |   2 -
 arch/powerpc/include/asm/module.h              |   3 +
 arch/powerpc/include/asm/paca.h                |   1 +
 arch/powerpc/kernel/asm-offsets.c              |   1 +
 arch/powerpc/kernel/machine_kexec.c            |   6 +-
 arch/powerpc/kernel/module_64.c                |  43 +++--
 arch/powerpc/kernel/trace/ftrace.c             | 210 ++++++++++++++++++++-----
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  85 +++++++++-
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |   4 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |   8 +
 10 files changed, 296 insertions(+), 67 deletions(-)

-- 
2.16.2
