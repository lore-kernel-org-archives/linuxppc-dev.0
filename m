Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj1hK2s54zDwLW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:40 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJDFoOm094431
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 08:18:38 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ecg2uk02-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 08:18:38 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 23:18:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 579C02CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:34 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJDIYfI55247094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:34 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJDIXYi010768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:34 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com, mhiramat@kernel.org,
 anju@linux.vnet.ibm.com
Subject: [PATCH V3 0/4] OPTPROBES for powerpc
Date: Mon, 19 Dec 2016 18:48:23 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Message-Id: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the V3 patchset of the kprobes jump optimization
(a.k.a OPTPROBES)for powerpc. Kprobe being an inevitable tool
for kernel developers, enhancing the performance of kprobe has
got much importance.

Currently kprobes inserts a trap instruction to probe a running kernel.
Jump optimization allows kprobes to replace the trap with a branch,
reducing the probe overhead drastically.

In this series, conditional branch instructions are not considered for
optimization as they have to be assessed carefully in SMP systems.

The kprobe placed on the kretprobe_trampoline during boot time, is also
optimized in this series. Patch 4/4 furnishes this.

The first two patches can go independently of the series. The helper 
functions in these patches are invoked in patch 3/4.

Performance:
============
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
the limitation of branch instruction in power architecture, detour buffer
slot is allocated from a reserved area. This will ensure that the branch
is within ± 32 MB range. The existing generic approach for kprobes insn 
cache uses module_alloc() to allocate memory area for insn slots. This will 
always be beyond ± 32MB range.
 
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
- Currently instructions which can be emulated using analyse_instr() are 
  the only candidates for optimization.
- Conditional branch instructions are not optimized.
- Probes on kernel module region are not considered for optimization now.
 
Link for the V1 patchset: 
			https://lkml.org/lkml/2016/9/7/171
			https://lkml.org/lkml/2016/9/7/174
			https://lkml.org/lkml/2016/9/7/172
			https://lkml.org/lkml/2016/9/7/173

Changes from v1:

- Merged the three patches in V1 into a single patch.
- Comments by Masami are addressed.
- Some helper functions are implemented in separate patches.
- Optimization for kprobe placed on the kretprobe_trampoline during
  boot time is implemented.

Changes from v2:

- Comments by Masami are addressed.
- Description in the cover letter is modified a bit.


Kindly let me know your suggestions and comments.

Thanks,
-Anju


Anju T Sudhakar (2):
  arch/powerpc: Implement Optprobes
  arch/powerpc: Optimize kprobe in kretprobe_trampoline

Naveen N. Rao (2):
  powerpc: asm/ppc-opcode.h: introduce __PPC_SH64()
  powerpc: add helper to check if offset is within rel branch range

 .../features/debug/optprobes/arch-support.txt      |   2 +-
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/code-patching.h           |   1 +
 arch/powerpc/include/asm/kprobes.h                 |  24 +-
 arch/powerpc/include/asm/ppc-opcode.h              |   1 +
 arch/powerpc/include/asm/sstep.h                   |   1 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/kprobes.c                      |   8 +
 arch/powerpc/kernel/optprobes.c                    | 330 +++++++++++++++++++++
 arch/powerpc/kernel/optprobes_head.S               | 135 +++++++++
 arch/powerpc/lib/code-patching.c                   |  24 +-
 arch/powerpc/lib/sstep.c                           |  21 ++
 arch/powerpc/net/bpf_jit.h                         |  11 +-
 13 files changed, 551 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/kernel/optprobes.c
 create mode 100644 arch/powerpc/kernel/optprobes_head.S

-- 
2.7.4
