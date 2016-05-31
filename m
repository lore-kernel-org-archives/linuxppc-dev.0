Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJr7K19ZYzDqbg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:58:04 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4VAsdY3044148
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 06:58:02 -0400
Message-Id: <201605311058.u4VAsdY3044148@mx0a-001b2d01.pphosted.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23961qwakp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 06:58:02 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 31 May 2016 20:57:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 799C53578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:57:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4VAviM064815104
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:57:52 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4VAuptV029767
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:56:52 +1000
From: Anju T <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anju@linux.vnet.ibm.com, ananth@in.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org, anjutsudhakar@gmail.com
Subject: [RFC PATCH v3 0/3] OPTPROBES for powerpc
Date: Tue, 31 May 2016 16:26:28 +0530
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are the RFC V3 patchset of the kprobes jump optimization
(a.k.a OPTPROBES)for powerpc. Kprobe being an inevitable tool
for kernel developers,enhancing the performance of kprobe has
got much importance.

Currently kprobes inserts a trap instruction to probe a running kernel.
Jump optimization allows kprobes to replace the trap with a branch,reducing
the probe overhead drastically.

Performance:
=============
An optimized kprobe in powerpc is 1.05 to 4.7 times faster than a kprobe.

Example:

Placed a probe at an offset 0x50 in _do_fork().
*Time Diff here is, difference in time before hitting the probe and after the probed instruction.
mftb() is employed in kernel/fork.c for this purpose.

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

The trap instruction is replaced by a branch to a detour buffer.
To address the limitation of branch instruction in power architecture
detour buffer slot is allocated from a reserved area . This will ensure
that the branch is within +/- 32 MB range. Patch 2/3 furnishes this.
The current kprobes insn caches  allocate memory area for insn slots
with module_alloc(). This will always be beyond +/- 32MB range.

The detour buffer contains a call to optimized_callback() which in turn
call the pre_handler(). Once the pre-handler is run, the original instruction
is emulated from the detour buffer itself. Also the detour buffer is equipped
with a branch back to the normal work flow after the probed instruction is emulated.
Before preparing optimization, Kprobes inserts original(breakpoint instruction) kprobe on the
specified address. So, even if the kprobe is not possible to be optimized, it just uses
a normal kprobe.

Limitations:
==============
- Number of probes which can be optimized is limited by the size of the area reserved.
- Currently instructions which can be emulated are the only candidates for optimization.
- Probes on kernel module region are not considered for optimization now.

Changes from RFC-v1:

- Detour buffer memory reservation code moved to optprobes.c
- optimized_callback() is marked as NOKPROBE_SYMBOL.
- Return NULL when there is no more slots to allocate from detour buffer.
- Other comments by Masami are addressed.


Changes from RFC-v2:

- The Come-From Address Register (CFAR) is a 64-bit
  register. When an rfebb, rfid, or rfscv instruction is
  executed, the register is set to the effective address of
  the instruction . Hence cfar register cannot be used to
  store the probed instruction address into the in memory pt_regs.
  The NIP value is stored into the stack using load instructions
  as suggested by Naveen.
- For allocating and freeing memory from the reserved area the existing 
  _get_insn_slot() and _free_insn_slot() are used with the approach suggested
  by Masami.
- CR register is also stored in the stack as suggested by Maddy.
- create_load_address_insn() in patch 2/3 is modified.
- SOFTE,ORIG_GPR3 and RESULT are also stored in stack.
- Other comments regarding the coding style are addressed.



Kindly let me know your suggestions and comments.

Thanks
-Anju


Anju T (3):
  arch/powerpc : Add detour buffer support for optprobes
  arch/powerpc : optprobes for powerpc core
  arch/powerpc : Enable optprobes support in powerpc

 .../features/debug/optprobes/arch-support.txt      |   2 +-
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/kprobes.h                 |  27 ++
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/optprobes.c                    | 351 +++++++++++++++++++++
 arch/powerpc/kernel/optprobes_head.S               | 136 ++++++++
 6 files changed, 517 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/kernel/optprobes.c
 create mode 100644 arch/powerpc/kernel/optprobes_head.S

-- 
2.1.0
