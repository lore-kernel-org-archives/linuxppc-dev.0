Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 28/63] powerpc: Add endian annotations to lppaca,
 slb_shadow and dtl_entry
Date: Wed,  7 Aug 2013 02:01:45 +1000
Message-Id: <1375804940-22050-29-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add endian annotation to various hypervisor structures which
are defined as big endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/lppaca.h | 50 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index bc8def0..4470d1e 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -48,13 +48,13 @@
 struct lppaca {
 	/* cacheline 1 contains read-only data */
 
-	u32	desc;			/* Eye catcher 0xD397D781 */
-	u16	size;			/* Size of this struct */
+	__be32	desc;			/* Eye catcher 0xD397D781 */
+	__be16	size;			/* Size of this struct */
 	u8	reserved1[3];
 	u8	__old_status;		/* Old status, including shared proc */
 	u8	reserved3[14];
-	volatile u32 dyn_hw_node_id;	/* Dynamic hardware node id */
-	volatile u32 dyn_hw_proc_id;	/* Dynamic hardware proc id */
+	volatile __be32 dyn_hw_node_id;	/* Dynamic hardware node id */
+	volatile __be32 dyn_hw_proc_id;	/* Dynamic hardware proc id */
 	u8	reserved4[56];
 	volatile u8 vphn_assoc_counts[8]; /* Virtual processor home node */
 					  /* associativity change counters */
@@ -71,9 +71,9 @@ struct lppaca {
 	u8	fpregs_in_use;
 	u8	pmcregs_in_use;
 	u8	reserved8[28];
-	u64	wait_state_cycles;	/* Wait cycles for this proc */
+	__be64	wait_state_cycles;	/* Wait cycles for this proc */
 	u8	reserved9[28];
-	u16	slb_count;		/* # of SLBs to maintain */
+	__be16	slb_count;		/* # of SLBs to maintain */
 	u8	idle;			/* Indicate OS is idle */
 	u8	vmxregs_in_use;
 
@@ -87,17 +87,17 @@ struct lppaca {
 	 * NOTE: This value will ALWAYS be zero for dedicated processors and
 	 * will NEVER be zero for shared processors (ie, initialized to a 1).
 	 */
-	volatile u32 yield_count;
-	volatile u32 dispersion_count;	/* dispatch changed physical cpu */
-	volatile u64 cmo_faults;	/* CMO page fault count */
-	volatile u64 cmo_fault_time;	/* CMO page fault time */
+	volatile __be32 yield_count;
+	volatile __be32 dispersion_count; /* dispatch changed physical cpu */
+	volatile __be64 cmo_faults;	/* CMO page fault count */
+	volatile __be64 cmo_fault_time;	/* CMO page fault time */
 	u8	reserved10[104];
 
 	/* cacheline 4-5 */
 
-	u32	page_ins;		/* CMO Hint - # page ins by OS */
+	__be32	page_ins;		/* CMO Hint - # page ins by OS */
 	u8	reserved11[148];
-	volatile u64 dtl_idx;		/* Dispatch Trace Log head index */
+	volatile __be64 dtl_idx;		/* Dispatch Trace Log head index */
 	u8	reserved12[96];
 } __attribute__((__aligned__(0x400)));
 
@@ -123,12 +123,12 @@ static inline bool lppaca_shared_proc(struct lppaca *l)
  * ESID is stored in the lower 64bits, then the VSID.
  */
 struct slb_shadow {
-	u32	persistent;		/* Number of persistent SLBs */
-	u32	buffer_length;		/* Total shadow buffer length */
-	u64	reserved;
+	__be32	persistent;		/* Number of persistent SLBs */
+	__be32	buffer_length;		/* Total shadow buffer length */
+	__be64	reserved;
 	struct	{
-		u64     esid;
-		u64	vsid;
+		__be64     esid;
+		__be64	vsid;
 	} save_area[SLB_NUM_BOLTED];
 } ____cacheline_aligned;
 
@@ -140,14 +140,14 @@ extern struct slb_shadow slb_shadow[];
 struct dtl_entry {
 	u8	dispatch_reason;
 	u8	preempt_reason;
-	u16	processor_id;
-	u32	enqueue_to_dispatch_time;
-	u32	ready_to_enqueue_time;
-	u32	waiting_to_ready_time;
-	u64	timebase;
-	u64	fault_addr;
-	u64	srr0;
-	u64	srr1;
+	__be16	processor_id;
+	__be32	enqueue_to_dispatch_time;
+	__be32	ready_to_enqueue_time;
+	__be32	waiting_to_ready_time;
+	__be64	timebase;
+	__be64	fault_addr;
+	__be64	srr0;
+	__be64	srr1;
 };
 
 #define DISPATCH_LOG_BYTES	4096	/* bytes per cpu */
-- 
1.8.1.2
