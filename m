Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJGgJ3K6TzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 20:51:08 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v189nw5d129567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 04:51:06 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fmwr3qwd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 04:51:06 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 15:21:03 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 33E34E005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 15:22:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v189p0Be26738926
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 15:21:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v189ow1I002212
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 15:21:00 +0530
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org
Subject: [PATCH v4 0/2] OPTPROBES for powerpc
Date: Wed,  8 Feb 2017 15:20:50 +0530
Message-Id: <1486547452-13510-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the patchset of the kprobes jump optimization
(a.k.a OPTPROBES)for powerpc. Kprobe being an inevitable tool
for kernel developers, enhancing the performance of kprobe has
got much importance.

Currently kprobes inserts a trap instruction to probe a running kernel.
Jump optimization allows kprobes to replace the trap with a branch,
reducing the probe overhead drastically.

In this series, conditional branch instructions are not considered for
optimization as there isn't a foolproof mechanism to ensure the conditional
branch targets lie in the range of addresses (2^^24) that is a necessary
condition for optimization.

The kprobe placed on the kretprobe_trampoline during boot time, is also
optimized in this series. Patch 2/2 furnishes this.


Note:   This patch set depends on the patch series which I send earlier.
        Links are here :
		https://patchwork.ozlabs.org/patch/725563/
		https://patchwork.ozlabs.org/patch/725562/
		https://patchwork.ozlabs.org/patch/725564/

The helper functions in these patches are invoked in patch 1/2.


Performance:
============
An optimized kprobe in powerpc is up to 4 times faster than a trap
based kprobe.

Example:

Placed a probe at an instruction in _do_fork().
*Time Diff here is, difference in time before hitting the probe and
after the probed instruction. mftb() is employed in kernel/fork.c for
this purpose.

# echo 0 > /proc/sys/debug/kprobes-optimization
Kprobes globally unoptimized

[  172.252347] Time diff = 0xc4c
[  172.257389] Time diff = 0x86e
[  172.262035] Time diff = 0xb8f
[  172.266479] Time diff = 0x5ec
[  172.270641] Time diff = 0xd4f
[  172.273224] Time diff = 0x52b
[  172.277328] Time diff = 0x793
[  172.280520] Time diff = 0x286
[  172.284125] Time diff = 0x592
[  172.287319] Time diff = 0x593
[  172.292319] Time diff = 0xa30
[  172.294909] Time diff = 0x2e1
[  172.297806] Time diff = 0x6a3
[  172.300718] Time diff = 0x5aa
[  172.304675] Time diff = 0xa6e
[  172.307668] Time diff = 0x322
[  172.310875] Time diff = 0x844
[  172.313710] Time diff = 0x2db
[  172.317361] Time diff = 0x831
[  172.320066] Time diff = 0x327

# echo 1 > /proc/sys/debug/kprobes-optimization
Kprobes globally optimized

[  207.070301] Time diff = 0x1dd
[  207.073401] Time diff = 0x118
[  207.075724] Time diff = 0x100
[  207.078643] Time diff = 0x242
[  207.080938] Time diff = 0x129
[  207.084103] Time diff = 0x32f
[  207.087022] Time diff = 0x194
[  207.090139] Time diff = 0x13d
[  207.092436] Time diff = 0x195
[  207.095031] Time diff = 0x103
[  207.097481] Time diff = 0x15a
[  207.100414] Time diff = 0x11f
[  207.102831] Time diff = 0x161
[  207.105713] Time diff = 0x242
[  207.108271] Time diff = 0x2d7
[  207.111741] Time diff = 0x104
[  207.114389] Time diff = 0xf1
[  207.118002] Time diff = 0x2f1
[  207.120930] Time diff = 0x179
[  207.124259] Time diff = 0x10f

Implementation:
===================

The trap instruction is replaced by a branch to a detour buffer. To address
the limitation of branch instruction in POWER architecture, detour buffer
slot is allocated from a reserved area. This will ensure that the branch
is within +/- 32 MB range. The existing generic approach for kprobes
instruction cache uses module_alloc() to allocate memory area for instruction
slots. This will always be beyond +/- 32MB range.

The detour buffer contains a call to optimized_callback() which in turn
call the pre_handler(). Once the pre-handler is run, the original
instruction is emulated from the detour buffer itself. Also the detour
buffer is equipped with a branch back to the normal work flow after the
probed instruction is emulated. This branch instruction is set up during
the preparation of the detour buffer itself. The address of the instruction
to which we need to jump back is determined through analyse_instr(), which
is invoked during the sanity checks for optprobes. A dummy pt_regs along with
probed instruction is used for this purpose. 

Kprobe placed in conditional branch instructions are not optimized, as we
can't predict the nip prior with dummy pt_regs and can not ensure that
the return branch from detour buffer falls in the range of address (i.e 32MB).

Before preparing optimization, Kprobes inserts original(breakpoint instruction)
kprobe on the specified address. So, even if the kprobe is not possible to be
optimized, it just uses a normal kprobe.


Limitations:
==============
- Number of probes which can be optimized is limited by the size of the
  area reserved.
- Currently instructions which can be emulated using analyse_instr() are 
  the only candidates for optimization.
- Conditional branch instructions are not optimized.
- Probes on kernel module region are not considered for optimization now.


Changes from v3:

- The optprobe specific patches are moved to a separate series.
- Comments by Michael Ellerman are addressed.
- Performance results in the cover letter are updated with the
  latest patch set.

Changes from v2:

- Comments by Masami are addressed.
- Description in the cover letter is modified a bit.

Changes from v1:

- Merged the three patches in V1 into a single patch.
- Comments by Masami are addressed.
- Some helper functions are implemented in separate patches.
- Optimization for kprobe placed on the kretprobe_trampoline during
  boot time is implemented.


Kindly let me know your suggestions and comments.

Thanks,
-Anju


Anju T Sudhakar (2):
  arch/powerpc: Implement Optprobes
  arch/powerpc: Optimize kprobe in kretprobe_trampoline

 arch/powerpc/Kconfig                     |   1 +
 arch/powerpc/include/asm/code-patching.h |   1 +
 arch/powerpc/include/asm/kprobes.h       |  24 ++-
 arch/powerpc/kernel/Makefile             |   1 +
 arch/powerpc/kernel/kprobes.c            |   8 +
 arch/powerpc/kernel/optprobes.c          | 347 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/optprobes_head.S     | 135 ++++++++++++
 arch/powerpc/lib/code-patching.c         |  21 ++
 8 files changed, 537 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/kernel/optprobes.c
 create mode 100644 arch/powerpc/kernel/optprobes_head.S

-- 
2.7.4
