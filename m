Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN4YS2BwszDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:29:15 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EESgFH032907
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 09:29:13 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kx6vpbgh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 09:29:13 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 00:29:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 764872BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:29:09 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1EET1FX26017798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:29:09 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1EESaqA002417
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:28:37 +1100
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, lsorense@csclub.uwaterloo.ca,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v4 0/2] powerpc: Emulation support for load/store instructions
 on LE
Date: Tue, 14 Feb 2017 19:58:06 +0530
Message-Id: <1487082488-5624-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

emulate_step is the basic infrastructure which is used by number of other
kernel infrastructures like kprobe, hw-breakpoint(data breakpoint) etc.
In case of kprobe, enabling emulation of load/store instructions will
speedup the execution of probed instruction. In case of kernel-space
breakpoint, causative instruction is first get emulated before executing
user registered handler. If emulation fails, hw-breakpoint is disabled
with error. As emulate_step does not support load/store instructions on
LE, kernel-space hw-breakpoint infrastructure is broken on LE.

emulate_step() uses a number of underlying kernel functions that were
initially not enabled for LE. This has been rectified since. So, fix
emulate_step() for LE for the corresponding instructions.

Also add selftest which will run at boot if CONFIG_KPROBES_SANITY_TEST
and CONFIG_PPC64 is set.

Changes in v4:
  - Used late_initcall() for selftest
  - Makefile changes

v3 link: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1332686.html

Ravi Bangoria (2):
  powerpc: Emulation support for load/store instructions on LE
  powerpc: emulate_step tests for load/store instructions

 arch/powerpc/include/asm/ppc-opcode.h |   7 +
 arch/powerpc/lib/Makefile             |   2 +
 arch/powerpc/lib/sstep.c              |  20 --
 arch/powerpc/lib/test_emulate_step.c  | 443 ++++++++++++++++++++++++++++++++++
 4 files changed, 452 insertions(+), 20 deletions(-)
 create mode 100644 arch/powerpc/lib/test_emulate_step.c

-- 
1.8.3.1
