Return-Path: <anju@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B8E21A021E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 17:10:13 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 11:40:10 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A3A5D125805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 11:40:05 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA36A5sm64684268
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 11:40:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA36A2aI013957
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 11:40:04 +0530
From: Anju T <anju@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 acme@redhat.com, dsahern@gmail.com, jolsa@redhat.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH V3 0/3] perf/powerpc:Add ability to sample intr machine state
 in powerpc
Date: Tue,  3 Nov 2015 11:39:59 +0530
Message-Id: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
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

$perf record -I ls   // record machine state at interrupt
$perf script -D      //read the perf.data file

Sample output obtained for this patchset/ output looks like as follows:

331557004666 0x1988 [0x188]: PERF_RECORD_SAMPLE(IP, 0x1): 4807/4807: 0xc0000000001ddf60 period: 1 addr: 0
... intr regs: mask 0x7ffffffffff ABI 64-bit
.... gpr0  0xc0000000001e6a74
.... gpr1  0xc0000000ff33b9a0
.... gpr2  0xc000000001523000
.... gpr3  0xc000000ffa9deb60
.... gpr4  0xc0000000ff971e00
.... gpr5  0x4d32564532
.... gpr6  0x1e000000
.... gpr7  0x0
.... gpr8  0x0
.... gpr9  0x0
.... gpr10 0x1
.... gpr11 0x0
.... gpr12 0x24022822
.... gpr13 0xc00000000feeaf80
.... gpr14 0x0
.... gpr15 0xc0000000fbc21000
.... gpr16 0x0
.... gpr17 0xc000000ffa9c5000
.... gpr18 0xc0000000ff33b8a0
.... gpr19 0xc000000001523000
.... gpr20 0xc0000000000a097c
.... gpr21 0xc000000fcac65600
.... gpr22 0xc0000000001e55a8
.... gpr23 0xc000000001523000
.... gpr24 0xc0000000ff33b850
.... gpr25 0xc000000fcac65600
.... gpr26 0xc000001e4b378210
.... gpr27 0xfffffffffffffead
.... gpr28 0x100000000
.... gpr29 0xc000000fcac65600
.... gpr30 0x1
.... gpr31 0x0
.... nip   0xc0000000001ddf68
.... msr   0x9000000000009032
.... orig_r3 0xc0000000001e5fcc
.... ctr   0xc00000000009e1b0
.... link  0xc0000000001e6a74
.... xer   0x0
.... ccr   0x84022882
.... softe 0x0
.... trap  0xf01
.... dar   0x0
.... dsisr 0xf00040060000004
 ... thread: :4807:4807
 ...... dso: /root/.debug/.build-id/1c/011201a1082e91b8449e6dd528f224d7a16535
           :4807  4807   331.557004:          1 cycles:  c0000000001ddf60 .perf_ctx_unlock (/boot/vmlinux)

0x1b10 [0x188]: event: 9


Changes from V2:

- tools/perf/config/Makefile is moved to the patch tools/perf.
- The patchset is reordered.
- perf_regs_load() function is used for the dwarf unwind test.Since it is not required here,
  it is removed from tools/perf/arch/powerpc/include/perf_regs.h 	
- PERF_REGS_POWERPC_RESULT is removed.





Anju T (3):
  perf/powerpc:add ability to sample intr machine state in power
  perf/powerpc :add support for sampling intr machine state
  tools/perf:Map the ID values with register names

 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/uapi/asm/perf_regs.h   |  54 +++++++++++++
 arch/powerpc/perf/Makefile                  |   2 +
 arch/powerpc/perf/perf_regs.c               |  92 ++++++++++++++++++++++
 tools/perf/arch/powerpc/include/perf_regs.h | 114 ++++++++++++++++++++++++++++
 tools/perf/config/Makefile                  |   5 ++
 6 files changed, 268 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/powerpc/perf/perf_regs.c
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h

-- 
2.1.0
