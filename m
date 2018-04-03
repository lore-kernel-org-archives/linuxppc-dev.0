Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0d73ND7zF28J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:12:43 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KAkZV029205
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:12:40 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h4fup9vcy-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:12:40 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:12:38 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 00/10] powerpc64/ftrace: Add support for
 ftrace_modify_call() and a few other fixes
Date: Wed,  4 Apr 2018 01:42:15 +0530
Message-Id: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v4 of the patches posted at:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg130739.html

This series has been tested using mambo for p8 (hash) and p9 (radix).


v4 changes:
- flip the paca field from 'ftrace_disabled' to 'ftrace_enabled' to 
  signify a default disable policy to address early boot
- add and use helpers to disable/enable ftrace, which addresses 32-bit 
  build issues
- a new patch to address issues with function_graph tracing during cpu 
  hotplug.

The last three patches are unchanged from the previous series, for the 
most part (except for the ftrace_disabled -> ftrace_enabled adjustment).

The last two patches implement support for ftrace_caller() to 
conditionally save the register state. This speeds up the function 
tracer a bit. The existing ftrace_caller() is renamed to 
ftrace_regs_caller() since we save the entire pt_regs today. A new 
implementation of ftrace_caller() that saves the minimum register state 
is provided. We switch between the two variants through 
ftrace_modify_call(). The necessary support to call into the two 
different variants from modules is also added.


- Naveen


Naveen N. Rao (10):
  powerpc64/ftrace: Add a field in paca to disable ftrace in unsafe code
    paths
  powerpc64/ftrace: Disable ftrace during kvm guest entry/exit
  powerpc64/ftrace: Rearrange #ifdef sections in ftrace.h
  powerpc64/ftrace: Add helpers to hard disable ftrace
  powerpc64/ftrace: Delay enabling ftrace on secondary cpus
  powerpc64/ftrace: Disable ftrace during hotplug
  powerpc64/kexec: Hard disable ftrace before switching to the new
    kernel
  powerpc64/module: Tighten detection of mcount call sites with
    -mprofile-kernel
  powerpc64/ftrace: Use the generic version of ftrace_replace_code()
  powerpc64/ftrace: Implement support for ftrace_regs_caller()

 arch/powerpc/include/asm/ftrace.h              |  27 +++-
 arch/powerpc/include/asm/module.h              |   3 +
 arch/powerpc/include/asm/paca.h                |   1 +
 arch/powerpc/kernel/asm-offsets.c              |   1 +
 arch/powerpc/kernel/machine_kexec.c            |   2 +
 arch/powerpc/kernel/module_64.c                |  43 +++--
 arch/powerpc/kernel/setup_64.c                 |   7 +
 arch/powerpc/kernel/smp.c                      |  12 ++
 arch/powerpc/kernel/trace/ftrace.c             | 210 ++++++++++++++++++++-----
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  85 +++++++++-
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |   4 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |   8 +
 12 files changed, 336 insertions(+), 67 deletions(-)

-- 
2.16.2
