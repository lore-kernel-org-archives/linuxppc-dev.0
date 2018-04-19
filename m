Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RVNS6sDCzDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 17:04:40 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3J74OuS120686
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:38 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hennp21fr-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:36 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 19 Apr 2018 08:04:32 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: [PATCH v5 00/10] powerpc64/ftrace: Add support for
 ftrace_modify_call() and a few other fixes
Date: Thu, 19 Apr 2018 12:33:59 +0530
Message-Id: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v5 of the patches posted at:
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=37250

This series has been tested using mambo for p8 (hash) and p9 (radix), 
and also on Power8 host.

In v5, the patch for KVM has been re-worked and is now [6/10], instead 
of [2/10]. This now works properly on a Power8 machine. More details in 
the patch. All other patches are unchanged from v4.


- Naveen


Naveen N. Rao (10):
  powerpc64/ftrace: Add a field in paca to disable ftrace in unsafe code
    paths
  powerpc64/ftrace: Rearrange #ifdef sections in ftrace.h
  powerpc64/ftrace: Add helpers to hard disable ftrace
  powerpc64/ftrace: Delay enabling ftrace on secondary cpus
  powerpc64/ftrace: Disable ftrace during hotplug
  powerpc64/ftrace: Disable ftrace during kvm entry/exit
  powerpc64/kexec: Hard disable ftrace before switching to the new
    kernel
  powerpc64/module: Tighten detection of mcount call sites with
    -mprofile-kernel
  powerpc64/ftrace: Use the generic version of ftrace_replace_code()
  powerpc64/ftrace: Implement support for ftrace_regs_caller()

 arch/powerpc/include/asm/ftrace.h             |  27 ++-
 arch/powerpc/include/asm/module.h             |   3 +
 arch/powerpc/include/asm/paca.h               |   1 +
 arch/powerpc/kernel/asm-offsets.c             |   1 +
 arch/powerpc/kernel/machine_kexec.c           |   2 +
 arch/powerpc/kernel/module_64.c               |  43 ++--
 arch/powerpc/kernel/setup_64.c                |   7 +
 arch/powerpc/kernel/smp.c                     |  12 +
 arch/powerpc/kernel/trace/ftrace.c            | 210 ++++++++++++++----
 .../powerpc/kernel/trace/ftrace_64_mprofile.S |  85 ++++++-
 arch/powerpc/kernel/trace/ftrace_64_pg.S      |   4 +
 arch/powerpc/kvm/book3s_hv.c                  |   4 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |   3 +
 13 files changed, 335 insertions(+), 67 deletions(-)

-- 
2.17.0
