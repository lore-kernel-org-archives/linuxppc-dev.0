Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTdYz2rsPzDrvR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 19:33:27 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u879WfgA121462
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 05:33:25 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25a57v76ej-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 05:33:25 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 19:33:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7B2CF2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 19:33:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u879XJu254853714
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 19:33:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u879XIOx009603
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 19:33:19 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [PATCH 0/3] OPTPROBES for powerpc
Date: Wed,  7 Sep 2016 15:03:09 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Message-Id: <1473240792-10596-1-git-send-email-anju@linux.vnet.ibm.com>
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
optimization as they have to be assessed carefully in SMP systems.


Performance:
=============
An optimized kprobe in powerpc is 1.05 to 4.7 times faster than a kprobe.

Example:

Placed a probe at an offset 0x50 in _do_fork().
*Time Diff here is, difference in time before hitting the probe and
after the probed instruction. mftb() is employed in kernel/fork.c for
this purpose.

# echo 0 > /proc/sys/debug/kprobes-optimization
Kprobes globally unoptimized
[  233.607120] Time Diff = 0x1f0
[  233.608273] Time Diff = 0x1ee
[  233.609228] Time Diff = 0x203
[  233.610400] Time Diff = 0x1ec
[  233.611335] Time Diff = 0x200
[  233.612552] Time Diff = 0x1f0
[  233.613386] Time Diff = 0x1ee
[  233.614547] Time Diff = 0x212
[  233.615570] Time Diff = 0x206
[  233.616819] Time Diff = 0x1f3
[  233.617773] Time Diff = 0x1ec
[  233.618944] Time Diff = 0x1fb
[  233.619879] Time Diff = 0x1f0
[  233.621066] Time Diff = 0x1f9
[  233.621999] Time Diff = 0x283
[  233.623281] Time Diff = 0x24d
[  233.624172] Time Diff = 0x1ea
[  233.625381] Time Diff = 0x1f0
[  233.626358] Time Diff = 0x200
[  233.627572] Time Diff = 0x1ed

# echo 1 > /proc/sys/debug/kprobes-optimization
Kprobes globally optimized
[   70.797075] Time Diff = 0x103
[   70.799102] Time Diff = 0x181
[   70.801861] Time Diff = 0x15e
[   70.803466] Time Diff = 0xf0
[   70.804348] Time Diff = 0xd0
[   70.805653] Time Diff = 0xad
[   70.806477] Time Diff = 0xe0
[   70.807725] Time Diff = 0xbe
[   70.808541] Time Diff = 0xc3
[   70.810191] Time Diff = 0xc7
[   70.811007] Time Diff = 0xc0
[   70.812629] Time Diff = 0xc0
[   70.813640] Time Diff = 0xda
[   70.814915] Time Diff = 0xbb
[   70.815726] Time Diff = 0xc4
[   70.816955] Time Diff = 0xc0
[   70.817778] Time Diff = 0xcd
[   70.818999] Time Diff = 0xcd
[   70.820099] Time Diff = 0xcb
[   70.821333] Time Diff = 0xf0

Implementation:
===================

The trap instruction is replaced by a branch to a detour buffer. To address
the limitation of branch instruction in power architecture detour buffer
slot is allocated from a reserved area . This will ensure that the branch
is within ± 32 MB range. Patch 2/3 furnishes this. The current kprobes
insn caches allocate memory area for insn slots with module_alloc(). This
will always be beyond ± 32MB range.

The detour buffer contains a call to optimized_callback() which in turn
call the pre_handler(). Once the pre-handler is run, the original
instruction is emulated from the detour buffer itself. Also the detour
buffer is equipped with a branch back to the normal work flow after the
probed instruction is emulated. Before preparing optimization, Kprobes
inserts original(breakpoint instruction)kprobe on the specified address.
So, even if the kprobe is not possible to be optimized, it just uses a
normal kprobe.

Limitations:
==============
- Number of probes which can be optimized is limited by the size of the
  area reserved.
- Currently instructions which can be emulated are the only candidates for
  optimization.
- Conditional branch instructions are not optimized.
- Probes on kernel module region are not considered for optimization now.

RFC patchset for optprobes: https://lkml.org/lkml/2016/5/31/375
			    https://lkml.org/lkml/2016/5/31/376
			    https://lkml.org/lkml/2016/5/31/377
			    https://lkml.org/lkml/2016/5/31/378 

Changes from RFC-v3 :

- Optimization for kporbe(in case of branch instructions) is limited to
  unconditional branch instructions only, since the conditional
  branches are to be assessed carefully in SMP systems.
- create_return_branch() is omitted.
- Comments by Masami are addressed.
 

Anju T Sudhakar (3):
  arch/powerpc : Add detour buffer support for optprobes
  arch/powerpc : optprobes for powerpc core
  arch/powerpc : Enable optprobes support in powerpc

 .../features/debug/optprobes/arch-support.txt      |   2 +-
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/kprobes.h                 |  24 ++
 arch/powerpc/include/asm/sstep.h                   |   1 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/optprobes.c                    | 329 +++++++++++++++++++++
 arch/powerpc/kernel/optprobes_head.S               | 119 ++++++++
 arch/powerpc/lib/sstep.c                           |  21 ++
 8 files changed, 497 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/kernel/optprobes.c
 create mode 100644 arch/powerpc/kernel/optprobes_head.S

-- 
2.7.4
