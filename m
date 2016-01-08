Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C8151A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 20:03:26 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 8 Jan 2016 19:03:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 832082CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 20:03:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0892tHg36896786
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 20:03:03 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0892phO017308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 20:02:51 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V8 0/4] perf/powerpc: Add ability to sample intr machine state
 in powerpc
Date: Fri,  8 Jan 2016 14:32:27 +0530
Message-Id: <1452243751-382-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This short patch series adds the ability to sample the interrupted
machine state for each hardware sample.

To test this patchset,
Eg:

$ perf record -I?       # list supported registers

output:

available registers: gpr0 gpr1 gpr2 gpr3 gpr4 gpr5 gpr6 gpr7 gpr8 gpr9 gpr10 gpr11 gpr12 gpr13 gpr14 gpr15 gpr16 gpr17 gpr18 gpr19 gpr20 gpr21 gpr22 gpr23 gpr24 gpr25 gpr26 gpr27 gpr28 gpr29 gpr30 gpr31 nip msr orig_r3 ctr link xer ccr trap dar dsisr
usage: perf record [<options>] [<command>]
or: perf record [<options>] -- <command> [<options>]
 -I, --intr-regs[=<any register>]
sample selected machine registers on interrupt, use -I ? to list register names


$ perf record -I ls   # record machine state at interrupt
$ perf script -D      # read the perf.data file

Samplfdoutput obtained for this patchset/ output looks like as follows:

178329381464 0x138 [0x180]: PERF_RECORD_SAMPLE(IP, 0x1): 7803/7803: 0xc00000000000fd9c period: 1 addr: 0
... intr regs: mask 0x3ffffffffff ABI 64-bit
.... gpr0  0xc0000000001a6420
.... gpr1  0xc000001e4df039b0
.... gpr2  0xc000000000cdd100
.... gpr3  0x1
.... gpr4  0xc000001e4a96d000
.... gpr5  0x29854255ba
.... gpr6  0xc000000ffa3050b8
.... gpr7  0x0
.... gpr8  0x0
.... gpr9  0x0
.... gpr10 0x0
.... gpr11 0x0
.... gpr12 0x24022822
.... gpr13 0xc00000000fe03000
.... gpr14 0x0
.... gpr15 0xc000000000d763f8
.... gpr16 0x0
.... gpr17 0xc000001e4ddcf000
.... gpr18 0x0
.... gpr19 0xc000000ffa305000
.... gpr20 0xc000001e4df038c0
.... gpr21 0xc000001e40ed7a00
.... gpr22 0xc0000000000aa28c
.... gpr23 0xc000000000cdd100
.... gpr24 0x0
.... gpr25 0xc000000000cdd100
.... gpr26 0xc000001e4df038b0
.... gpr27 0xfffffffffffffeae
.... gpr28 0xc000001e4df03880
.... gpr29 0xc000000000dce900
.... gpr30 0xc000001e4df03890
.... gpr31 0xc000001e355c7a30
.... nip   0xc0000000001a62d8
.... msr   0x9000000000009032
.... orig_r3 0xc0000000001a6320
.... ctr   0xc0000000000a7be0
.... lnk   0xc0000000001a6428
.... xer   0x0
.... ccr   0x24022888
.... trap  0xf01
.... dar   0xc000001e40ed7a00
.... dsisr 0x3000c0060000004
 ... thread: :7803:7803
 ...... dso: /root/.debug/.build-id/d0/eb47b06c0d294143af13c50616f638c2d88658
           :7803  7803   178.329381:          1 cycles:  c00000000000fd9c .arch_local_irq_restore (/boot/vmlinux)

Changes from V7:

- Addressed the new line issue in 3rd patch.

Changes from V6:

- Corrected the typo in patch  tools/perf: Map the ID values with register names.
  ie #define PERF_REG_SP  PERF_REG_POWERPC_R1 should be #define PERF_REG_SP   PERF_REG_POWERPC_GPR1


Changes from V5:

- Enabled perf_sample_regs_user also in this patch set.Functions added in 
   arch/powerpc/perf/perf_regs.c
- Added Maddy's patch to this patchset for enabling -I? option which will
  list the supported register names.


Changes from V4:

- Removed the softe and MQ from all patches
- Switch case is replaced with an array in the 3rd patch

Changes from V3:

- Addressed the comments by Sukadev regarding the nits in the descriptions.
- Modified the subject of first patch.
- Included the sample output in the 3rd patch also.

Changes from V2:

- tools/perf/config/Makefile is moved to the patch tools/perf.
- The patchset is reordered.
- perf_regs_load() function is used for the dwarf unwind test.Since it is not required here,
  it is removed from tools/perf/arch/powerpc/include/perf_regs.h
- PERF_REGS_POWERPC_RESULT is removed.

Changes from V1:

- Solved the name missmatch issue in the from and signed-off field of the patch series.
- Added necessary comments in the 3rd patch ie perf/powerpc ,as suggested by Maddy.



Anju T (3):
  perf/powerpc: assign an id to each powerpc register
  perf/powerpc: add support for sampling intr machine state
  tools/perf: Map the ID values with register names

Madhavan Srinivasan (1):
  tool/perf: Add sample_reg_mask to include all perf_regs regs

 arch/powerpc/Kconfig                        |  1 +
 arch/powerpc/include/uapi/asm/perf_regs.h   | 49 +++++++++++++++++
 arch/powerpc/perf/Makefile                  |  1 +
 arch/powerpc/perf/perf_regs.c               | 85 +++++++++++++++++++++++++++++
 tools/perf/arch/powerpc/include/perf_regs.h | 64 ++++++++++++++++++++++
 tools/perf/arch/powerpc/util/Build          |  1 +
 tools/perf/arch/powerpc/util/perf_regs.c    | 48 ++++++++++++++++
 tools/perf/config/Makefile                  |  5 ++
 8 files changed, 254 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/powerpc/perf/perf_regs.c
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
 create mode 100644 tools/perf/arch/powerpc/util/perf_regs.c

-- 
2.1.0
