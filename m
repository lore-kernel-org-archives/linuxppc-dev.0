Return-Path: <mgreer@mvista.com>
Date: Wed, 13 Sep 2006 17:04:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: oprofile-list@lists.sf.net
Subject: Re: [PATCH] Add 7450 support to oprofile tools
Message-ID: <20060914000403.GA2123@mag.az.mvista.com>
References: <20060908225718.GA1724@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060908225718.GA1724@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, vwool@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Well, my first patch to this mailing list didn't go so well.  There were
some errors in the events file so there is a replacement patch below.

I know 0.9.2 is coming out so I will respin it when it arrives.
I'm resending in case someone is uses it before 0.9.2.

Sorry for the spam,

Mark
--

Hi,

I don't normally monitor or contribute to oprofile so I'm not sure
what your patch conventions are.  If this email or patch is not in the
correct format please let me know what that format is and I'll resubmit.

Notes:
- This patch applies to oprofile-0.9.1.tar.gz
- Vitaly Wool contributed significantly to this patch.

Thanks,

Mark
--

This patch adds PowerPC MPC7450 support to the oprofile tools.
In reality, it also adds support for the MPC7445, MPC7447, MPC7447A,
MPC7448, MPC7455, and MPC7457 processors but has only been tested
on a MPC7447A.  The 7450 name was chosen because it matches the name
used in the Linux kernel, <file:arch/powerpc/oprofile/op_model_7450.c>.

Note that not all of the performance counters available on those
processors were added to the events file but its a start, at least.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 events/Makefile.in         |    3 ++-
 events/ppc/7450/events     |   22 ++++++++++++++++++++++
 events/ppc/7450/unit_masks |    4 ++++
 libop/op_cpu_type.c        |    1 +
 libop/op_cpu_type.h        |    1 +
 libop/op_events.c          |    6 +++++-
 utils/ophelp.c             |    5 +++++
 7 files changed, 40 insertions(+), 2 deletions(-)
--

diff -Nurp oprofile-0.9.1/events/Makefile.in oprofile-0.9.1.current/events/Makefile.in
--- oprofile-0.9.1/events/Makefile.in	2005-07-18 12:40:00.000000000 -0700
+++ oprofile-0.9.1.current/events/Makefile.in	2006-09-11 14:40:41.000000000 -0700
@@ -210,7 +210,8 @@ event_files = \
 	mips/r12000/events mips/r12000/unit_masks \
 	mips/vr5432/events mips/vr5432/unit_masks \
 	mips/vr5500/events mips/vr5500/unit_masks \
-	ppc/e500/events ppc/e500/unit_masks
+	ppc/e500/events ppc/e500/unit_masks \
+	ppc/7450/events ppc/7450/unit_masks
 
 EXTRA_DIST = $(event_files)
 all: all-am
diff -Nurp oprofile-0.9.1/events/ppc/7450/events oprofile-0.9.1.current/events/ppc/7450/events
--- oprofile-0.9.1/events/ppc/7450/events	1969-12-31 17:00:00.000000000 -0700
+++ oprofile-0.9.1.current/events/ppc/7450/events	2006-09-13 16:44:07.000000000 -0700
@@ -0,0 +1,22 @@
+# 745x Events
+#
+event:0x1 counters:0,1,2,3 um:zero minimum:3000 name:CYCLES : Processor cycles
+event:0x2 counters:0,1,2,3 um:zero minimum:3000 name:COMPLETED_INSNS : Completed Instructions
+event:0x3 counters:0,1,2,3 um:zero minimum:3000 name:TBL_BIT_TRANSTNS : TBL Bit Transitions
+event:0x4 counters:0,1,2,3 um:zero minimum:3000 name:DISPATCHED_INSNS : Dispatched Instructions
+event:0x5 counters:0,1,2,3 um:zero minimum:3000 name:PROC_PERFMON_EXC: Process Performance Monitor Exception
+event:0x8 counters:0,1,3 um:zero minimum:3000 name:VPU_INSNS : VPU Instructions Completed
+event:0x9 counters:0,1,3 um:zero minimum:3000 name:VFPU_INSNS : VFPU Instructions Completed
+event:0xa counters:0,1,3 um:zero minimum:3000 name:VIU1_INSNS : VIU1 Instructions Completed
+event:0xb counters:0,1,3 um:zero minimum:3000 name:VIU2_INSNS : VIU2 Instructions Completed
+event:0xe counters:0,1 um:zero minimum:3000 name:VPU_CYCLES : Cycles a VPU Instruction
+event:0xf counters:0,1 um:zero minimum:3000 name:VFPU_CYCLES : Cycles a VFPU Instruction
+event:0x10 counters:0,1 um:zero minimum:3000 name:VIU1_CYCLES : Cycles a VIU1 Instruction
+event:0x11 counters:0,1 um:zero minimum:3000 name:VIU2_CYCLES : Cycles a VIU2 Instruction
+event:0x14 counters:0,1 um:zero minimum:3000 name:STORE_INSNS : Store Instructions
+event:0x15 counters:0,1 um:zero minimum:3000 name:L1_ICACHE_MISSES : L1 Instruction Cache Misses
+event:0x16 counters:0,1 um:zero minimum:3000 name:L1_DATA_SNOOPS: L1 Data Snoops
+event:0x17 counters:0,1 um:zero minimum:3000 name:UNRESOLVED_BRANCHES: Unresolved Branches
+event:0x27 counters:0,1 um:zero minimum:3000 name:ITLB_TABLE_CYCLES: ITLM Hardware Table Search Cycles
+event:0x29 counters:0,1 um:zeor minimum:3000 name: L1_ICACHE_ACCESSES: L1 Instruction Cache Accesses
+event:0x2a counters:0,1 um:zeor minimum:3000 name: INSN_BP_MATCHES: Instruction Breakpoint Matches
diff -Nurp oprofile-0.9.1/events/ppc/7450/unit_masks oprofile-0.9.1.current/events/ppc/7450/unit_masks
--- oprofile-0.9.1/events/ppc/7450/unit_masks	1969-12-31 17:00:00.000000000 -0700
+++ oprofile-0.9.1.current/events/ppc/7450/unit_masks	2006-09-11 14:40:41.000000000 -0700
@@ -0,0 +1,4 @@
+# 745x possible unit masks
+#
+name:zero type:mandatory default:0x0
+	0x0 No unit mask
diff -Nurp oprofile-0.9.1/libop/op_cpu_type.c oprofile-0.9.1.current/libop/op_cpu_type.c
--- oprofile-0.9.1/libop/op_cpu_type.c	2005-07-11 13:46:23.000000000 -0700
+++ oprofile-0.9.1.current/libop/op_cpu_type.c	2006-09-11 14:40:41.000000000 -0700
@@ -55,6 +55,7 @@ static struct cpu_descr const cpu_descrs
 	{ "NEC VR5432", "mips/vr5432", CPU_MIPS_VR5432, 2 },
 	{ "NEC VR5500", "mips/vr5500", CPU_MIPS_VR5500, 2 },
 	{ "e500", "ppc/e500", CPU_PPC_E500, 4 },
+	{ "ppc 7450", "ppc/7450", CPU_PPC_7450, 6 },
 };
  
 static size_t const nr_cpu_descrs = sizeof(cpu_descrs) / sizeof(struct cpu_descr);
diff -Nurp oprofile-0.9.1/libop/op_cpu_type.h oprofile-0.9.1.current/libop/op_cpu_type.h
--- oprofile-0.9.1/libop/op_cpu_type.h	2005-07-11 13:46:23.000000000 -0700
+++ oprofile-0.9.1.current/libop/op_cpu_type.h	2006-09-11 14:40:41.000000000 -0700
@@ -51,6 +51,7 @@ typedef enum {
 	CPU_MIPS_VR5432, /**< NEC VR5432 */
 	CPU_MIPS_VR5500, /**< MIPS VR5500, VR5532 and VR7701 */
 	CPU_PPC_E500,	/**< e500 */
+	CPU_PPC_7450,	/**< PPC 7450 */
 	MAX_CPU_TYPE
 } op_cpu;
 
diff -Nurp oprofile-0.9.1/libop/op_events.c oprofile-0.9.1.current/libop/op_events.c
--- oprofile-0.9.1/libop/op_events.c	2005-07-11 13:46:23.000000000 -0700
+++ oprofile-0.9.1.current/libop/op_events.c	2006-09-11 14:40:41.000000000 -0700
@@ -816,7 +816,11 @@ void op_default_event(op_cpu cpu_type, s
 		case CPU_PPC_E500:
 			descr->name = "CPU_CLK";
 			break;
-             
+
+		case CPU_PPC_7450:
+			descr->name = "CYCLES";
+			break;
+
 		// don't use default, if someone add a cpu he wants a compiler
 		// warning if he forgets to handle it here.
 		case CPU_TIMER_INT:
diff -Nurp oprofile-0.9.1/utils/ophelp.c oprofile-0.9.1.current/utils/ophelp.c
--- oprofile-0.9.1/utils/ophelp.c	2005-07-11 13:46:23.000000000 -0700
+++ oprofile-0.9.1.current/utils/ophelp.c	2006-09-11 14:40:41.000000000 -0700
@@ -450,6 +450,11 @@ int main(int argc, char const * argv[])
 			"Chapter 7: Performance Monitor\n"
 			"Downloadable from http://www.freescale.com\n");
 		break;
+	case CPU_PPC_7450:
+		printf("See MPC7450 RISC Microprocessor Family "
+			"Reference Manual\n"
+			"Chapter 11: Performance Monitor\n"
+			"Downloadable from http://www.freescale.com\n");
 
 	case CPU_RTC:
 		break;
