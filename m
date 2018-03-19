Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404lmW5gQNzF1TT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 06:02:03 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/14] perf vendor events: Update POWER9 events
Date: Mon, 19 Mar 2018 16:01:27 -0300
Message-Id: <20180319190136.7441-6-acme@kernel.org>
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20180313224647.GA22960@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 ---
 .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
 .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
 .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
 .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++++++++++++-------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 ++---
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
 .../arch/powerpc/power9/translation.json           |  10 +-
 8 files changed, 178 insertions(+), 173 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/cache.json b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
index 7945c5196c43..851072105054 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
@@ -19,11 +19,6 @@
     "EventName": "PM_CMPLU_STALL_FXU",
     "BriefDescription": "Finish stall due to a scalar fixed point or CR instruction in the execution pipeline. These instructions get routed to the ALU, ALU2, and DIV pipes"
   },
-  {,
-    "EventCode": "0x1D15C",
-    "EventName": "PM_MRK_DTLB_MISS_1G",
-    "BriefDescription": "Marked Data TLB reload (after a miss) page size 2M. Implies radix translation was used"
-  },
   {,
     "EventCode": "0x4D12A",
     "EventName": "PM_MRK_DATA_FROM_RL4_CYC",
@@ -79,21 +74,6 @@
     "EventName": "PM_THRESH_EXC_4096",
     "BriefDescription": "Threshold counter exceed a count of 4096"
   },
-  {,
-    "EventCode": "0x3D156",
-    "EventName": "PM_MRK_DTLB_MISS_64K",
-    "BriefDescription": "Marked Data TLB Miss page size 64K"
-  },
-  {,
-    "EventCode": "0x4C15E",
-    "EventName": "PM_MRK_DTLB_MISS_16M",
-    "BriefDescription": "Marked Data TLB Miss page size 16M"
-  },
-  {,
-    "EventCode": "0x2D15E",
-    "EventName": "PM_MRK_DTLB_MISS_16G",
-    "BriefDescription": "Marked Data TLB Miss page size 16G"
-  },
   {,
     "EventCode": "0x3F14A",
     "EventName": "PM_MRK_DPTEG_FROM_RMEM",
@@ -123,10 +103,5 @@
     "EventCode": "0x1002A",
     "EventName": "PM_CMPLU_STALL_LARX",
     "BriefDescription": "Finish stall because the NTF instruction was a larx waiting to be satisfied"
-  },
-  {,
-    "EventCode": "0x1C058",
-    "EventName": "PM_DTLB_MISS_16G",
-    "BriefDescription": "Data TLB Miss page size 16G"
   }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
index bd8361b5fd6a..f9fa84b16fb5 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
@@ -154,11 +154,6 @@
     "EventName": "PM_MRK_DATA_FROM_RL2L3_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load"
   },
-  {,
-    "EventCode": "0x3C056",
-    "EventName": "PM_DTLB_MISS_64K",
-    "BriefDescription": "Data TLB Miss page size 64K"
-  },
   {,
     "EventCode": "0x30060",
     "EventName": "PM_TM_TRANS_RUN_INST",
@@ -344,11 +339,6 @@
     "EventName": "PM_MRK_LARX_FIN",
     "BriefDescription": "Larx finished"
   },
-  {,
-    "EventCode": "0x4C056",
-    "EventName": "PM_DTLB_MISS_16M",
-    "BriefDescription": "Data TLB Miss page size 16M"
-  },
   {,
     "EventCode": "0x1003A",
     "EventName": "PM_CMPLU_STALL_LSU_FIN",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/marked.json b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
index 22f9f32060a8..b1954c38bab1 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
@@ -529,11 +529,6 @@
     "EventName": "PM_L1_ICACHE_RELOADED_ALL",
     "BriefDescription": "Counts all Icache reloads includes demand, prefetch, prefetch turned into demand and demand turned into prefetch"
   },
-  {,
-    "EventCode": "0x4003C",
-    "EventName": "PM_DISP_HELD_SYNC_HOLD",
-    "BriefDescription": "Cycles in which dispatch is held because of a synchronizing instruction in the pipeline"
-  },
   {,
     "EventCode": "0x3003C",
     "EventName": "PM_CMPLU_STALL_NESTED_TEND",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/memory.json b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
index 9960d1c0dd44..2e2ebc700c74 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
@@ -44,11 +44,6 @@
     "EventName": "PM_LD_CMPL",
     "BriefDescription": "count of Loads completed"
   },
-  {,
-    "EventCode": "0x2D156",
-    "EventName": "PM_MRK_DTLB_MISS_4K",
-    "BriefDescription": "Marked Data TLB Miss page size 4k"
-  },
   {,
     "EventCode": "0x4C042",
     "EventName": "PM_DATA_FROM_L3",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 5ce312973f1e..48cf4f920b3f 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -69,6 +69,11 @@
     "EventName": "PM_THRD_PRIO_0_1_CYC",
     "BriefDescription": "Cycles thread running at priority level 0 or 1"
   },
+  {,
+    "EventCode": "0x4C054",
+    "EventName": "PM_DERAT_MISS_16G_1G",
+    "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16G (hpt mode) or 1G (radix mode)"
+  },
   {,
     "EventCode": "0x2084",
     "EventName": "PM_FLUSH_HB_RESTORE_CYC",
@@ -107,12 +112,12 @@
   {,
     "EventCode": "0x360B2",
     "EventName": "PM_L3_GRP_GUESS_WRONG_LOW",
-    "BriefDescription": "Initial scope=group (GS or NNS) but data from outside group (far or rem). Prediction too Low"
+    "BriefDescription": "Prefetch scope predictor selected GS or NNS, but was wrong because scope was LNS"
   },
   {,
     "EventCode": "0x168A6",
     "EventName": "PM_TM_CAM_OVERFLOW",
-    "BriefDescription": "L3 TM cam overflow during L2 co of SC"
+    "BriefDescription": "L3 TM CAM is full when a L2 castout of TM_SC line occurs.  Line is pushed to memory"
   },
   {,
     "EventCode": "0xE8B0",
@@ -149,11 +154,6 @@
     "EventName": "PM_ISU3_ISS_HOLD_ALL",
     "BriefDescription": "All ISU rejects"
   },
-  {,
-    "EventCode": "0x460A6",
-    "EventName": "PM_RD_FORMING_SC",
-    "BriefDescription": "Read forming SC"
-  },
   {,
     "EventCode": "0x468A0",
     "EventName": "PM_L3_PF_OFF_CHIP_MEM",
@@ -187,7 +187,7 @@
   {,
     "EventCode": "0x368A6",
     "EventName": "PM_SNP_TM_HIT_T",
-    "BriefDescription": "Snp TM sthit T/Tn/Te"
+    "BriefDescription": "TM snoop that is a store hits line in L3 in T, Tn or Te state (shared modified)"
   },
   {,
     "EventCode": "0x3001A",
@@ -204,6 +204,11 @@
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's ECO L3 on the same chip due to a marked load"
   },
+  {,
+    "EventCode": "0xF0B4",
+    "EventName": "PM_DC_PREF_CONS_ALLOC",
+    "BriefDescription": "Prefetch stream allocated in the conservative phase by either the hardware prefetch mechanism or software prefetch. The sum of this pair subtracted from the total number of allocs will give the total allocs in normal phase"
+  },
   {,
     "EventCode": "0xF894",
     "EventName": "PM_LSU3_L1_CAM_CANCEL",
@@ -227,7 +232,12 @@
   {,
     "EventCode": "0x468A6",
     "EventName": "PM_RD_CLEARING_SC",
-    "BriefDescription": "Read clearing SC"
+    "BriefDescription": "Core TM load hits line in L3 in TM_SC state and causes it to be invalidated"
+  },
+  {,
+    "EventCode": "0xD0B0",
+    "EventName": "PM_HWSYNC",
+    "BriefDescription": ""
   },
   {,
     "EventCode": "0x168B0",
@@ -264,6 +274,11 @@
     "EventName": "PM_DC_PREF_HW_ALLOC",
     "BriefDescription": "Prefetch stream allocated by the hardware prefetch mechanism"
   },
+  {,
+    "EventCode": "0xF0BC",
+    "EventName": "PM_LS2_UNALIGNED_ST",
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+  },
   {,
     "EventCode": "0xD0AC",
     "EventName": "PM_SRQ_SYNC_CYC",
@@ -274,6 +289,11 @@
     "EventName": "PM_MRK_INST_FROM_L3MISS",
     "BriefDescription": "Marked instruction was reloaded from a location beyond the local chiplet"
   },
+  {,
+    "EventCode": "0x58A8",
+    "EventName": "PM_DECODE_HOLD_ICT_FULL",
+    "BriefDescription": "Counts the number of cycles in which the IFU was not able to decode and transmit one or more instructions because all itags were in use.  This means the ICT is full for this thread"
+  },
   {,
     "EventCode": "0x26082",
     "EventName": "PM_L2_IC_INV",
@@ -364,6 +384,16 @@
     "EventName": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE_CYC",
     "BriefDescription": "Duration in cycles to reload either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked load"
   },
+  {,
+    "EventCode": "0xF888",
+    "EventName": "PM_LSU1_STORE_REJECT",
+    "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
+  },
+  {,
+    "EventCode": "0xC098",
+    "EventName": "PM_LS2_UNALIGNED_LD",
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+  },
   {,
     "EventCode": "0x20058",
     "EventName": "PM_DARQ1_10_12_ENTRIES",
@@ -372,7 +402,7 @@
   {,
     "EventCode": "0x360A6",
     "EventName": "PM_SNP_TM_HIT_M",
-    "BriefDescription": "Snp TM st hit M/Mu"
+    "BriefDescription": "TM snoop that is a store hits line in L3 in M or Mu state (exclusive modified)"
   },
   {,
     "EventCode": "0x5898",
@@ -395,9 +425,9 @@
     "BriefDescription": "A data line was written to the L1 due to a hardware or software prefetch"
   },
   {,
-    "EventCode": "0xF888",
-    "EventName": "PM_LSU1_STORE_REJECT",
-    "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
+    "EventCode": "0x2608E",
+    "EventName": "PM_TM_LD_CONF",
+    "BriefDescription": "TM Load (fav or non-fav) ran into conflict (failed)"
   },
   {,
     "EventCode": "0x1D144",
@@ -422,7 +452,7 @@
   {,
     "EventCode": "0x26884",
     "EventName": "PM_DSIDE_MRU_TOUCH",
-    "BriefDescription": "D-side L2 MRU touch sent to L2"
+    "BriefDescription": "D-side L2 MRU touch commands sent to the L2"
   },
   {,
     "EventCode": "0x30134",
@@ -439,6 +469,16 @@
     "EventName": "PM_EAT_FORCE_MISPRED",
     "BriefDescription": "XL-form branch was mispredicted due to the predicted target address missing from EAT.  The EAT forces a mispredict in this case since there is no predicated target to validate.  This is a rare case that may occur when the EAT is full and a branch is issued"
   },
+  {,
+    "EventCode": "0xC094",
+    "EventName": "PM_LS0_UNALIGNED_LD",
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+  },
+  {,
+    "EventCode": "0xF8BC",
+    "EventName": "PM_LS3_UNALIGNED_ST",
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+  },
   {,
     "EventCode": "0x460AE",
     "EventName": "PM_L3_P2_CO_RTY",
@@ -492,7 +532,7 @@
   {,
     "EventCode": "0xC880",
     "EventName": "PM_LS1_LD_VECTOR_FIN",
-    "BriefDescription": ""
+    "BriefDescription": "LS1 finished load vector op"
   },
   {,
     "EventCode": "0x2894",
@@ -514,6 +554,11 @@
     "EventName": "PM_MRK_LSU_DERAT_MISS",
     "BriefDescription": "Marked derat reload (miss) for any page size"
   },
+  {,
+    "EventCode": "0x160A0",
+    "EventName": "PM_L3_PF_MISS_L3",
+    "BriefDescription": "L3 PF missed in L3"
+  },
   {,
     "EventCode": "0x1C04A",
     "EventName": "PM_DATA_FROM_RL2L3_SHR",
@@ -564,11 +609,21 @@
     "EventName": "PM_L2_LOC_GUESS_WRONG",
     "BriefDescription": "L2 guess local (LNS) and guess was not correct (ie data not on chip)"
   },
+  {,
+    "EventCode": "0xC888",
+    "EventName": "PM_LSU_DTLB_MISS_64K",
+    "BriefDescription": "Data TLB Miss page size 64K"
+  },
   {,
     "EventCode": "0xE0A4",
     "EventName": "PM_TMA_REQ_L2",
     "BriefDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding"
   },
+  {,
+    "EventCode": "0xC088",
+    "EventName": "PM_LSU_DTLB_MISS_4K",
+    "BriefDescription": "Data TLB Miss page size 4K"
+  },
   {,
     "EventCode": "0x3C042",
     "EventName": "PM_DATA_FROM_L3_DISP_CONFLICT",
@@ -602,7 +657,7 @@
   {,
     "EventCode": "0x26084",
     "EventName": "PM_L2_RCLD_DISP_FAIL_OTHER",
-    "BriefDescription": "All I-or-D side load dispatch attempts for this thread that failed due to reason other than address collision (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All D-side-Ld or I-side-instruction-fetch dispatch attempts for this thread that failed due to reasons other than an address collision conflicts with an L2 machines (e.g. Read-Claim/Snoop machine not available)"
   },
   {,
     "EventCode": "0x101E4",
@@ -647,12 +702,12 @@
   {,
     "EventCode": "0x46080",
     "EventName": "PM_L2_DISP_ALL_L2MISS",
-    "BriefDescription": "All successful Ld/St dispatches for this thread that were an L2 miss (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All successful D-side-Ld/St or I-side-instruction-fetch dispatches for this thread that were an L2 miss"
   },
   {,
-    "EventCode": "0x160A0",
-    "EventName": "PM_L3_PF_MISS_L3",
-    "BriefDescription": "L3 PF missed in L3"
+    "EventCode": "0xF8B8",
+    "EventName": "PM_LS1_UNALIGNED_ST",
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
   {,
     "EventCode": "0x408C",
@@ -667,7 +722,7 @@
   {,
     "EventCode": "0x160B2",
     "EventName": "PM_L3_LOC_GUESS_CORRECT",
-    "BriefDescription": "initial scope=node/chip (LNS) and data from local node (local) (pred successful) - always PFs only"
+    "BriefDescription": "Prefetch scope predictor selected LNS and was correct"
   },
   {,
     "EventCode": "0x48B4",
@@ -767,7 +822,7 @@
   {,
     "EventCode": "0x36082",
     "EventName": "PM_L2_LD_DISP",
-    "BriefDescription": "All successful I-or-D side load dispatches for this thread (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All successful D-side-Ld or I-side-instruction-fetch dispatches for this thread"
   },
   {,
     "EventCode": "0xF8B0",
@@ -787,7 +842,7 @@
   {,
     "EventCode": "0x16884",
     "EventName": "PM_L2_RCLD_DISP_FAIL_ADDR",
-    "BriefDescription": "All I-od-D side load dispatch attempts for this thread that failed due to address collision with RC/CO/SN/SQ machine (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All D-side-Ld or I-side-instruction-fetch dispatch attempts for this thread that failed due to an address collision conflicts with an L2 machines already working on this line (e.g. ld-hit-stq or Read-claim/Castout/Snoop machines)"
   },
   {,
     "EventCode": "0x460A0",
@@ -829,6 +884,11 @@
     "EventName": "PM_IC_PREF_REQ",
     "BriefDescription": "Instruction prefetch requests"
   },
+  {,
+    "EventCode": "0xC898",
+    "EventName": "PM_LS3_UNALIGNED_LD",
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+  },
   {,
     "EventCode": "0x488C",
     "EventName": "PM_IC_PREF_WRITE",
@@ -837,7 +897,7 @@
   {,
     "EventCode": "0xF89C",
     "EventName": "PM_XLATE_MISS",
-    "BriefDescription": "The LSU requested a line from L2 for translation.  It may be satisfied from any source beyond L2.  Includes speculative instructions"
+    "BriefDescription": "The LSU requested a line from L2 for translation.  It may be satisfied from any source beyond L2.  Includes speculative instructions. Includes instruction, prefetch and demand"
   },
   {,
     "EventCode": "0x14158",
@@ -849,10 +909,15 @@
     "EventName": "PM_MRK_DATA_FROM_L31_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's L3 on the same chip due to a marked load"
   },
+  {,
+    "EventCode": "0xC88C",
+    "EventName": "PM_LSU_DTLB_MISS_16G_1G",
+    "BriefDescription": "Data TLB Miss page size 16G (HPT) or 1G (Radix)"
+  },
   {,
     "EventCode": "0x268A6",
     "EventName": "PM_TM_RST_SC",
-    "BriefDescription": "TM-snp rst RM SC"
+    "BriefDescription": "TM snoop hits line in L3 that is TM_SC state and causes it to be invalidated"
   },
   {,
     "EventCode": "0x468A4",
@@ -917,7 +982,7 @@
   {,
     "EventCode": "0x46086",
     "EventName": "PM_L2_SN_M_RD_DONE",
-    "BriefDescription": "SNP dispatched for a read and was M (true M)"
+    "BriefDescription": "Snoop dispatched for a read and was M (true M)"
   },
   {,
     "EventCode": "0x40154",
@@ -979,15 +1044,10 @@
     "EventName": "PM_LINK_STACK_CORRECT",
     "BriefDescription": "Link stack predicts right address"
   },
-  {,
-    "EventCode": "0x4C05A",
-    "EventName": "PM_DTLB_MISS_1G",
-    "BriefDescription": "Data TLB reload (after a miss) page size 1G. Implies radix translation was used"
-  },
   {,
     "EventCode": "0x36886",
     "EventName": "PM_L2_SN_SX_I_DONE",
-    "BriefDescription": "SNP dispatched and went from Sx to Ix"
+    "BriefDescription": "Snoop dispatched and went from Sx to Ix"
   },
   {,
     "EventCode": "0x4E04A",
@@ -999,11 +1059,6 @@
     "EventName": "PM_MRK_DATA_FROM_DL4_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's L4 on a different Node or Group (Distant) due to a marked load"
   },
-  {,
-    "EventCode": "0x2608E",
-    "EventName": "PM_TM_LD_CONF",
-    "BriefDescription": "TM Load (fav or non-fav) ran into conflict (failed)"
-  },
   {,
     "EventCode": "0x4080",
     "EventName": "PM_INST_FROM_L1",
@@ -1037,7 +1092,7 @@
   {,
     "EventCode": "0x260A6",
     "EventName": "PM_NON_TM_RST_SC",
-    "BriefDescription": "Non-TM snp rst TM SC"
+    "BriefDescription": "Non-TM snoop hits line in L3 that is TM_SC state and causes it to be invalidated"
   },
   {,
     "EventCode": "0x3608A",
@@ -1064,11 +1119,6 @@
     "EventName": "PM_FLUSH_MPRED",
     "BriefDescription": "Branch mispredict flushes.  Includes target and address misprecition"
   },
-  {,
-    "EventCode": "0x508C",
-    "EventName": "PM_SHL_CREATED",
-    "BriefDescription": "Store-Hit-Load Table Entry Created"
-  },
   {,
     "EventCode": "0x1504C",
     "EventName": "PM_IPTEG_FROM_LL4",
@@ -1107,7 +1157,7 @@
   {,
     "EventCode": "0x2608A",
     "EventName": "PM_ISIDE_DISP_FAIL_ADDR",
-    "BriefDescription": "All I-side dispatch attempts for this thread that failed due to a addr collision with another machine (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All I-side-instruction-fetch dispatch attempts for this thread that failed due to an address collision conflict with an L2 machine already working on this line (e.g. ld-hit-stq or RC/CO/SN machines)"
   },
   {,
     "EventCode": "0x50B4",
@@ -1180,9 +1230,9 @@
     "BriefDescription": "Number of stcx instructions finished. This includes instructions in the speculative path of a branch that may be flushed"
   },
   {,
-    "EventCode": "0xE0B8",
-    "EventName": "PM_LS2_TM_DISALLOW",
-    "BriefDescription": "A TM-ineligible instruction tries to execute inside a transaction and the LSU disallows it"
+    "EventCode": "0xD8AC",
+    "EventName": "PM_LWSYNC",
+    "BriefDescription": ""
   },
   {,
     "EventCode": "0x2094",
@@ -1209,6 +1259,11 @@
     "EventName": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL",
     "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF; CR; XVF (XER/VSCR/FPSCR)"
   },
+  {,
+    "EventCode": "0xC894",
+    "EventName": "PM_LS1_UNALIGNED_LD",
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+  },
   {,
     "EventCode": "0x360A2",
     "EventName": "PM_L3_L2_CO_HIT",
@@ -1292,7 +1347,7 @@
   {,
     "EventCode": "0xC084",
     "EventName": "PM_LS2_LD_VECTOR_FIN",
-    "BriefDescription": ""
+    "BriefDescription": "LS2 finished load vector op"
   },
   {,
     "EventCode": "0x1608E",
@@ -1344,6 +1399,11 @@
     "EventName": "PM_SN_USAGE",
     "BriefDescription": "Continuous 16 cycle (2to1) window where this signals rotates thru sampling each SN machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running"
   },
+  {,
+    "EventCode": "0x36084",
+    "EventName": "PM_L2_RCST_DISP",
+    "BriefDescription": "All D-side store dispatch attempts for this thread"
+  },
   {,
     "EventCode": "0x46084",
     "EventName": "PM_L2_RCST_DISP_FAIL_OTHER",
@@ -1354,11 +1414,6 @@
     "EventName": "PM_DC_PREF_STRIDED_CONF",
     "BriefDescription": "A demand load referenced a line in an active strided prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software."
   },
-  {,
-    "EventCode": "0x36084",
-    "EventName": "PM_L2_RCST_DISP",
-    "BriefDescription": "All D-side store dispatch attempts for this thread"
-  },
   {,
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
@@ -1372,7 +1427,7 @@
   {,
     "EventCode": "0x36080",
     "EventName": "PM_L2_INST",
-    "BriefDescription": "All successful I-side dispatches for this thread   (excludes i_l2mru_tch reqs)"
+    "BriefDescription": "All successful I-side-instruction-fetch (e.g. i-demand, i-prefetch) dispatches for this thread"
   },
   {,
     "EventCode": "0x3504C",
@@ -1387,7 +1442,7 @@
   {,
     "EventCode": "0x1688A",
     "EventName": "PM_ISIDE_DISP",
-    "BriefDescription": "All I-side dispatch attempts for this thread (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All I-side-instruction-fetch dispatch attempts for this thread"
   },
   {,
     "EventCode": "0x468AA",
@@ -1419,6 +1474,11 @@
     "EventName": "PM_LSU2_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1"
   },
+  {,
+    "EventCode": "0xE0B8",
+    "EventName": "PM_LS2_TM_DISALLOW",
+    "BriefDescription": "A TM-ineligible instruction tries to execute inside a transaction and the LSU disallows it"
+  },
   {,
     "EventCode": "0x44044",
     "EventName": "PM_INST_FROM_L31_ECO_MOD",
@@ -1467,7 +1527,7 @@
   {,
     "EventCode": "0x36086",
     "EventName": "PM_L2_RC_ST_DONE",
-    "BriefDescription": "RC did store to line that was Tx or Sx"
+    "BriefDescription": "Read-claim machine did store to line that was in Tx or Sx (Tagged or Shared state)"
   },
   {,
     "EventCode": "0xE8AC",
@@ -1499,6 +1559,11 @@
     "EventName": "PM_IPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a instruction side request"
   },
+  {,
+    "EventCode": "0x460A6",
+    "EventName": "PM_RD_FORMING_SC",
+    "BriefDescription": "Doesn't occur"
+  },
   {,
     "EventCode": "0x35042",
     "EventName": "PM_IPTEG_FROM_L3_DISP_CONFLICT",
@@ -1527,7 +1592,7 @@
   {,
     "EventCode": "0x36882",
     "EventName": "PM_L2_LD_HIT",
-    "BriefDescription": "All successful I-or-D side load dispatches for this thread that were L2 hits (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All successful D-side-Ld or I-side-instruction-fetch dispatches for this thread that were L2 hits"
   },
   {,
     "EventCode": "0x168AC",
@@ -1554,11 +1619,6 @@
     "EventName": "PM_PROBE_NOP_DISP",
     "BriefDescription": "ProbeNops dispatched"
   },
-  {,
-    "EventCode": "0x58A8",
-    "EventName": "PM_DECODE_HOLD_ICT_FULL",
-    "BriefDescription": "Counts the number of cycles in which the IFU was not able to decode and transmit one or more instructions because all itags were in use.  This means the ICT is full for this thread"
-  },
   {,
     "EventCode": "0x10052",
     "EventName": "PM_GRP_PUMP_MPRED_RTY",
@@ -1572,7 +1632,7 @@
   {,
     "EventCode": "0x2688A",
     "EventName": "PM_ISIDE_DISP_FAIL_OTHER",
-    "BriefDescription": "All I-side dispatch attempts for this thread that failed due to a reason other than addrs collision (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All I-side-instruction-fetch dispatch attempts for this thread that failed due to reasons other than an address collision conflict with an L2 machine (e.g. no available RC/CO machines)"
   },
   {,
     "EventCode": "0x2001A",
@@ -1652,12 +1712,12 @@
   {,
     "EventCode": "0x46880",
     "EventName": "PM_ISIDE_MRU_TOUCH",
-    "BriefDescription": "I-side L2 MRU touch sent to L2 for this thread"
+    "BriefDescription": "I-side L2 MRU touch sent to L2 for this thread I-side L2 MRU touch commands sent to the L2 for this thread"
   },
   {,
-    "EventCode": "0x1C05C",
-    "EventName": "PM_DTLB_MISS_2M",
-    "BriefDescription": "Data TLB reload (after a miss) page size 2M. Implies radix translation was used"
+    "EventCode": "0x508C",
+    "EventName": "PM_SHL_CREATED",
+    "BriefDescription": "Store-Hit-Load Table Entry Created"
   },
   {,
     "EventCode": "0x50B8",
@@ -1672,7 +1732,7 @@
   {,
     "EventCode": "0x268B2",
     "EventName": "PM_L3_LOC_GUESS_WRONG",
-    "BriefDescription": "Initial scope=node (LNS) but data from out side local node (near or far or rem). Prediction too Low"
+    "BriefDescription": "Prefetch scope predictor selected LNS, but was wrong"
   },
   {,
     "EventCode": "0x36088",
@@ -1684,6 +1744,11 @@
     "EventName": "PM_L3_P2_PF_RTY",
     "BriefDescription": "L3 PF received retry port 2, every retry counted"
   },
+  {,
+    "EventCode": "0xD8B0",
+    "EventName": "PM_PTESYNC",
+    "BriefDescription": ""
+  },
   {,
     "EventCode": "0x26086",
     "EventName": "PM_CO_TM_SC_FOOTPRINT",
@@ -1739,6 +1804,11 @@
     "EventName": "PM_L2_ST_MISS",
     "BriefDescription": "All successful D-Side Store dispatches that were an L2 miss for this thread"
   },
+  {,
+    "EventCode": "0xF8B4",
+    "EventName": "PM_DC_PREF_XCONS_ALLOC",
+    "BriefDescription": "Prefetch stream allocated in the Ultra conservative phase by either the hardware prefetch mechanism or software prefetch"
+  },
   {,
     "EventCode": "0x35048",
     "EventName": "PM_IPTEG_FROM_DL2L3_SHR",
@@ -1782,7 +1852,7 @@
   {,
     "EventCode": "0x460B2",
     "EventName": "PM_L3_SYS_GUESS_WRONG",
-    "BriefDescription": "Initial scope=system (VGS or RNS) but data from local or near. Prediction too high"
+    "BriefDescription": "Prefetch scope predictor selected VGS or RNS, but was wrong"
   },
   {,
     "EventCode": "0x58B8",
@@ -1799,11 +1869,6 @@
     "EventName": "PM_TM_TABORT_TRECLAIM",
     "BriefDescription": "Completion time tabortnoncd, tabortcd, treclaim"
   },
-  {,
-    "EventCode": "0x4C054",
-    "EventName": "PM_DERAT_MISS_16G",
-    "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16G"
-  },
   {,
     "EventCode": "0x268A0",
     "EventName": "PM_L3_CO_L31",
@@ -1862,7 +1927,7 @@
   {,
     "EventCode": "0x368B2",
     "EventName": "PM_L3_GRP_GUESS_WRONG_HIGH",
-    "BriefDescription": "Initial scope=group (GS or NNS) but data from local node. Prediction too high"
+    "BriefDescription": "Prefetch scope predictor selected GS or NNS, but was wrong because scope was VGS or RNS"
   },
   {,
     "EventCode": "0xE8BC",
@@ -1897,7 +1962,7 @@
   {,
     "EventCode": "0x260B2",
     "EventName": "PM_L3_SYS_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=system (VGS or RNS) and data from outside group (far or rem)(pred successful)"
+    "BriefDescription": "Prefetch scope predictor selected VGS or RNS and was correct"
   },
   {,
     "EventCode": "0x1D146",
@@ -1914,6 +1979,11 @@
     "EventName": "PM_L2_GROUP_PUMP",
     "BriefDescription": "RC requests that were on group (aka nodel) pump attempts"
   },
+  {,
+    "EventCode": "0xC08C",
+    "EventName": "PM_LSU_DTLB_MISS_16M_2M",
+    "BriefDescription": "Data TLB Miss page size 16M (HPT) or 2M (Radix)"
+  },
   {,
     "EventCode": "0x16080",
     "EventName": "PM_L2_LD",
@@ -1927,7 +1997,7 @@
   {,
     "EventCode": "0xC080",
     "EventName": "PM_LS0_LD_VECTOR_FIN",
-    "BriefDescription": ""
+    "BriefDescription": "LS0 finished load vector op"
   },
   {,
     "EventCode": "0x368B0",
@@ -1999,6 +2069,11 @@
     "EventName": "PM_BR_CORECT_PRED_TAKEN_CMPL",
     "BriefDescription": "Conditional Branch Completed in which the HW correctly predicted the direction as taken.  Counted at completion time"
   },
+  {,
+    "EventCode": "0xF0B8",
+    "EventName": "PM_LS0_UNALIGNED_ST",
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+  },
   {,
     "EventCode": "0x20132",
     "EventName": "PM_MRK_DFU_FIN",
@@ -2007,7 +2082,7 @@
   {,
     "EventCode": "0x160A6",
     "EventName": "PM_TM_SC_CO",
-    "BriefDescription": "L3 castout TM SC line"
+    "BriefDescription": "L3 castout of line that was StoreCopy (original value of speculatively written line) in a Transaction"
   },
   {,
     "EventCode": "0xC8B0",
@@ -2017,7 +2092,7 @@
   {,
     "EventCode": "0x16084",
     "EventName": "PM_L2_RCLD_DISP",
-    "BriefDescription": "All I-or-D side load dispatch attempts for this thread (excludes i_l2mru_tch_reqs)"
+    "BriefDescription": "All D-side-Ld or I-side-instruction-fetch dispatch attempts for this thread"
   },
   {,
     "EventCode": "0x3F150",
@@ -2122,12 +2197,12 @@
   {,
     "EventCode": "0x46082",
     "EventName": "PM_L2_ST_DISP",
-    "BriefDescription": "All successful D-side store dispatches for this thread (L2 miss + L2 hits)"
+    "BriefDescription": "All successful D-side store dispatches for this thread"
   },
   {,
     "EventCode": "0x36880",
     "EventName": "PM_L2_INST_MISS",
-    "BriefDescription": "All successful I-side dispatches that were an L2 miss for this thread (excludes i_l2mru_tch reqs)"
+    "BriefDescription": "All successful I-side-instruction-fetch (e.g. i-demand, i-prefetch) dispatches for this thread that were an L2 miss"
   },
   {,
     "EventCode": "0xE084",
@@ -2217,7 +2292,7 @@
   {,
     "EventCode": "0xC884",
     "EventName": "PM_LS3_LD_VECTOR_FIN",
-    "BriefDescription": ""
+    "BriefDescription": "LS3 finished load vector op"
   },
   {,
     "EventCode": "0x360A8",
@@ -2242,7 +2317,7 @@
   {,
     "EventCode": "0x168B2",
     "EventName": "PM_L3_GRP_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=group (GS or NNS) and data from same group (near) (pred successful)"
+    "BriefDescription": "Prefetch scope predictor selected GS or NNS and was correct"
   },
   {,
     "EventCode": "0x48A4",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index 5af1abbe82c4..b4772f54a271 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -64,11 +64,6 @@
     "EventName": "PM_DISP_HELD",
     "BriefDescription": "Dispatch Held"
   },
-  {,
-    "EventCode": "0x3D154",
-    "EventName": "PM_MRK_DERAT_MISS_16M",
-    "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16M"
-  },
   {,
     "EventCode": "0x200F8",
     "EventName": "PM_EXT_INT",
@@ -119,6 +114,11 @@
     "EventName": "PM_MRK_DPTEG_FROM_L3_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without dispatch conflicts hit on Mepf state. due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
+  {,
+    "EventCode": "0x4C15C",
+    "EventName": "PM_MRK_DERAT_MISS_16G_1G",
+    "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16G (hpt mode) and 1G (radix mode)"
+  },
   {,
     "EventCode": "0x10024",
     "EventName": "PM_PMC5_OVERFLOW",
@@ -154,11 +154,6 @@
     "EventName": "PM_ICT_NOSLOT_IC_MISS",
     "BriefDescription": "Ict empty for this thread due to Icache Miss"
   },
-  {,
-    "EventCode": "0x3D152",
-    "EventName": "PM_MRK_DERAT_MISS_1G",
-    "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 1G. Implies radix translation"
-  },
   {,
     "EventCode": "0x4F14A",
     "EventName": "PM_MRK_DPTEG_FROM_OFF_CHIP_CACHE",
@@ -184,11 +179,6 @@
     "EventName": "PM_MRK_DPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
-    "EventCode": "0x2C05A",
-    "EventName": "PM_DERAT_MISS_1G",
-    "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 1G. Implies radix translation"
-  },
   {,
     "EventCode": "0x1F058",
     "EventName": "PM_RADIX_PWC_L2_PTE_FROM_L2",
@@ -239,11 +229,6 @@
     "EventName": "PM_DTLB_MISS",
     "BriefDescription": "Data PTEG reload"
   },
-  {,
-    "EventCode": "0x2D152",
-    "EventName": "PM_MRK_DERAT_MISS_2M",
-    "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 2M. Implies radix translation"
-  },
   {,
     "EventCode": "0x2C046",
     "EventName": "PM_DATA_FROM_RL2L3_MOD",
@@ -289,6 +274,11 @@
     "EventName": "PM_CMPLU_STALL_DFU",
     "BriefDescription": "Finish stall because the NTF instruction was issued to the Decimal Floating Point execution pipe and waiting to finish. Includes decimal floating point instructions + 128 bit binary floating point instructions. Not qualified by multicycle"
   },
+  {,
+    "EventCode": "0x3C054",
+    "EventName": "PM_DERAT_MISS_16M_2M",
+    "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16M (HPT mode) or 2M (Radix mode)"
+  },
   {,
     "EventCode": "0x4C04C",
     "EventName": "PM_DATA_FROM_DMEM",
@@ -359,11 +349,6 @@
     "EventName": "PM_INST_FROM_MEMORY",
     "BriefDescription": "The processor's Instruction cache was reloaded from a memory location including L4 from local remote or distant due to an instruction fetch (not prefetch)"
   },
-  {,
-    "EventCode": "0x1C05A",
-    "EventName": "PM_DERAT_MISS_2M",
-    "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 2M. Implies radix translation"
-  },
   {,
     "EventCode": "0x30024",
     "EventName": "PM_PMC6_OVERFLOW",
@@ -374,6 +359,11 @@
     "EventName": "PM_BRU_FIN",
     "BriefDescription": "Branch Instruction Finished"
   },
+  {,
+    "EventCode": "0x3D154",
+    "EventName": "PM_MRK_DERAT_MISS_16M_2M",
+    "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16M (hpt mode) or 2M (radix mode)"
+  },
   {,
     "EventCode": "0x30020",
     "EventName": "PM_PMC2_REWIND",
@@ -409,11 +399,6 @@
     "EventName": "PM_MRK_DPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
-    "EventCode": "0x4C15C",
-    "EventName": "PM_MRK_DERAT_MISS_16G",
-    "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16G"
-  },
   {,
     "EventCode": "0x14052",
     "EventName": "PM_INST_GRP_PUMP_MPRED_RTY",
@@ -444,11 +429,6 @@
     "EventName": "PM_IC_DEMAND_CYC",
     "BriefDescription": "Icache miss demand cycles"
   },
-  {,
-    "EventCode": "0x3C054",
-    "EventName": "PM_DERAT_MISS_16M",
-    "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16M"
-  },
   {,
     "EventCode": "0x2D14E",
     "EventName": "PM_MRK_DATA_FROM_L21_SHR",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
index d0b89f930567..8b3b0f3be664 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
@@ -9,11 +9,6 @@
     "EventName": "PM_MEM_LOC_THRESH_LSU_HIGH",
     "BriefDescription": "Local memory above threshold for LSU medium"
   },
-  {,
-    "EventCode": "0x2C056",
-    "EventName": "PM_DTLB_MISS_4K",
-    "BriefDescription": "Data TLB Miss page size 4k"
-  },
   {,
     "EventCode": "0x40118",
     "EventName": "PM_MRK_DCACHE_RELOAD_INTV",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/translation.json b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
index bc8e03d7a6b0..b27642676244 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
@@ -29,11 +29,6 @@
     "EventName": "PM_ST_FIN",
     "BriefDescription": "Store finish count. Includes speculative activity"
   },
-  {,
-    "EventCode": "0x44042",
-    "EventName": "PM_INST_FROM_L3",
-    "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 due to an instruction fetch (not prefetch)"
-  },
   {,
     "EventCode": "0x1504A",
     "EventName": "PM_IPTEG_FROM_RL2L3_SHR",
@@ -124,6 +119,11 @@
     "EventName": "PM_PMC1_SAVED",
     "BriefDescription": "PMC1 Rewind Value saved"
   },
+  {,
+    "EventCode": "0x44042",
+    "EventName": "PM_INST_FROM_L3",
+    "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 due to an instruction fetch (not prefetch)"
+  },
   {,
     "EventCode": "0x200FE",
     "EventName": "PM_DATA_FROM_L2MISS",
-- 
2.14.3
