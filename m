Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t821q1B9TzDvJB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:53:18 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA28mfhL002729
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 04:53:16 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26fbm757nh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 04:53:16 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 18:53:13 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 79AFC2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:53:11 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA28rBmL19595444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 19:53:11 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA28rA1h005371
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 19:53:11 +1100
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, lsorense@csclub.uwaterloo.ca,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powerpc: Emulation support for load/store instructions on
 LE
Date: Wed,  2 Nov 2016 14:23:00 +0530
Message-Id: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Changes w.r.t. RFC:
  - Enable emulation support for all types of (Normal, Floating Point,
    Vector and Vector Scalar) load/store instructions.
  - Introduce selftest to test emulate_step for load/store instructions.

Ravi Bangoria (3):
  powerpc: Emulation support for load/store instructions on LE
  powerpc: Add encoding for couple of load/store instructions
  powerpc: emulate_step test for load/store instructions

 arch/powerpc/include/asm/ppc-opcode.h |   7 +
 arch/powerpc/include/asm/sstep.h      |   8 +
 arch/powerpc/kernel/kprobes.c         |   2 +
 arch/powerpc/lib/Makefile             |   4 +
 arch/powerpc/lib/sstep.c              |  20 --
 arch/powerpc/lib/test_emulate_step.c  | 439 ++++++++++++++++++++++++++++++++++
 6 files changed, 460 insertions(+), 20 deletions(-)
 create mode 100644 arch/powerpc/lib/test_emulate_step.c

-- 
1.8.3.1
