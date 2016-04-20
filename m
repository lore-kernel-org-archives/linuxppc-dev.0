Return-Path: <acme@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqSlW0DkVzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:57:58 +1000 (AEST)
Date: Wed, 20 Apr 2016 00:57:54 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Anju T <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 0/4]perf/powerpc: Add ability to sample intr machine
 state in powerpc
Message-ID: <20160420035754.GH2527@redhat.com>
References: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
 <5714AD1F.9020807@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5714AD1F.9020807@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Apr 18, 2016 at 03:17:11PM +0530, Anju T escreveu:
> On Saturday 20 February 2016 10:32 AM, Anju T wrote:
> >This short patch series adds the ability to sample the interrupted
> >machine state for each hardware sample.
> >
> >To test this patchset,
> >Eg:
> >
> >$ perf record -I?       # list supported registers
> >
> >output:
> >available registers: r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 r30 r31 nip msr orig_r3 ctr link xer ccr softe trap dar dsisr
> >
> >  usage: perf record [<options>] [<command>]
> >     or: perf record [<options>] -- <command> [<options>]
> >
> >     -I, --intr-regs[=<any register>]
> >                           sample selected machine registers on interrupt, use -I ? to list register names
> >
> >
> >$ perf record -I ls   # record machine state at interrupt
> >$ perf script -D      # read the perf.data file
> >
> >Sample output obtained for this patchset/ output looks like as follows:
> >
> >496768515470 0x1988 [0x188]: PERF_RECORD_SAMPLE(IP, 0x1): 4522/4522: 0xc0000000001e538c period: 1 addr: 0
> >... intr regs: mask 0x7ffffffffff ABI 64-bit
> >.... r0    0xc0000000001e5e34
> >.... r1    0xc000000fe733f9a0
> >.... r2    0xc000000001523100
> >.... r3    0xc000000ffaadeb60
> >.... r4    0xc000000003456800
> >.... r5    0x73a9b5e000
> >.... r6    0x1e000000
> >.... r7    0x0
> >.... r8    0x0
> >.... r9    0x0
> >.... r10   0x1
> >.... r11   0x0
> >.... r12   0x24022822
> >.... r13   0xc00000000feec180
> >.... r14   0x0
> >.... r15   0xc000001e4be18800
> >.... r16   0x0
> >.... r17   0xc000000ffaac5000
> >.... r18   0xc000000fe733f8a0
> >.... r19   0xc000000001523100
> >.... r20   0xc00000000009fd1c
> >.... r21   0xc000000fcaa69000
> >.... r22   0xc0000000001e4968
> >.... r23   0xc000000001523100
> >.... r24   0xc000000fe733f850
> >.... r25   0xc000000fcaa69000
> >.... r26   0xc000000003b8fcf0
> >.... r27   0xfffffffffffffead
> >.... r28   0x0
> >.... r29   0xc000000fcaa69000
> >.... r30   0x1
> >.... r31   0x0
> >.... nip   0xc0000000001dd320
> >.... msr   0x9000000000009032
> >.... orig_r3 0xc0000000001e538c
> >.... ctr   0xc00000000009d550
> >.... link  0xc0000000001e5e34
> >.... xer   0x0
> >.... ccr   0x84022882
> >.... softe 0x0
> >.... trap  0xf01
> >.... dar   0x0
> >.... dsisr 0xf00040060000004
> >  ... thread: :4522:4522
> >  ...... dso: /root/.debug/.build-id/b0/ef11b1a1629e62ac9de75199117ee5ef9469e9
> >            :4522  4522   496.768515:          1 cycles:  c0000000001e538c .perf_event_context_sched_in (/boot/vmlinux)
> >
> >
> >
> >Changes from v10:
> >
> >- Included SOFTE as suggested by mpe
> >- The name of registers displayed is  changed from
> >   gpr* to r* also the macro names changed from
> >   PERF_REG_POWERPC_GPR* to PERF_REG_POWERPC_R*.
> >- The conflict in returning the ABI is resolved.
> >- #define PERF_REG_SP  is again changed to  PERF_REG_POWERPC_R1
> >- Comment in tools/perf/config/Makefile is updated.
> >- removed the "Reviewed-By" tag as the patch has logic changes.
> >
> >
> >Changes from V9:
> >
> >- Changed the name displayed for link register from "lnk" to "link" in
> >   tools/perf/arch/powerpc/include/perf_regs.h
> >
> >changes from V8:
> >
> >- Corrected the indentation issue in the Makefile mentioned in 3rd patch
> >
> >Changes from V7:
> >
> >- Addressed the new line issue in 3rd patch.
> >
> >Changes from V6:
> >
> >- Corrected the typo in patch  tools/perf: Map the ID values with register names.
> >   ie #define PERF_REG_SP  PERF_REG_POWERPC_R1 should be #define PERF_REG_SP   PERF_REG_POWERPC_GPR1
> >
> >
> >Changes from V5:
> >
> >- Enabled perf_sample_regs_user also in this patch set.Functions added in
> >    arch/powerpc/perf/perf_regs.c
> >- Added Maddy's patch to this patchset for enabling -I? option which will
> >   list the supported register names.
> >
> >
> >Changes from V4:
> >
> >- Removed the softe and MQ from all patches
> >- Switch case is replaced with an array in the 3rd patch
> >
> >Changes from V3:
> >
> >- Addressed the comments by Sukadev regarding the nits in the descriptions.
> >- Modified the subject of first patch.
> >- Included the sample output in the 3rd patch also.
> >
> >Changes from V2:
> >
> >- tools/perf/config/Makefile is moved to the patch tools/perf.
> >- The patchset is reordered.
> >- perf_regs_load() function is used for the dwarf unwind test.Since it is not required here,
> >   it is removed from tools/perf/arch/powerpc/include/perf_regs.h
> >- PERF_REGS_POWERPC_RESULT is removed.
> >
> >Changes from V1:
> >
> >- Solved the name missmatch issue in the from and signed-off field of the patch series.
> >- Added necessary comments in the 3rd patch ie perf/powerpc ,as suggested by Maddy.
> >
> >
> >
> >Anju T (3):
> >   perf/powerpc: assign an id to each powerpc register
> >   perf/powerpc: add support for sampling intr machine state
> >   tools/perf: Map the ID values with register names
> >
> >Madhavan Srinivasan (1):
> >   tool/perf: Add sample_reg_mask to include all perf_regs regs
> >
> >
> >  arch/powerpc/Kconfig                        |  1 +
> >  arch/powerpc/include/uapi/asm/perf_regs.h   | 50 ++++++++++++++++
> >  arch/powerpc/perf/Makefile                  |  1 +
> >  arch/powerpc/perf/perf_regs.c               | 91 +++++++++++++++++++++++++++++
> >  tools/perf/arch/powerpc/include/perf_regs.h | 69 ++++++++++++++++++++++
> >  tools/perf/arch/powerpc/util/Build          |  1 +
> >  tools/perf/arch/powerpc/util/perf_regs.c    | 49 ++++++++++++++++
> >  tools/perf/config/Makefile                  |  5 ++
> >  8 files changed, 267 insertions(+)
> >  create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
> >  create mode 100644 arch/powerpc/perf/perf_regs.c
> >  create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
> >  create mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
> >
> 
> Hi,
> 
> Can this be taken into the next tree?

Even the bits in tools/perf/ are arch specific, so I guess this goes via
the powerpc tree? Michael?

- Arnaldo
